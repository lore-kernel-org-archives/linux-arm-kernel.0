From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 14 Apr 2014 09:24:40 -0300
Subject: [PATCH 20/29] ARM: orion5x: convert edmini_v2 to DT pinctrl
In-Reply-To: <20140414120648.GB20845@lunn.ch>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-21-git-send-email-thomas.petazzoni@free-electrons.com>
 <534BBDAC.2010801@gmail.com> <20140414132329.48df793e@skate>
 <534BC62D.6010000@gmail.com> <20140414120648.GB20845@lunn.ch>
Message-ID: <20140414122440.GB6393@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Apr 14, Andrew Lunn wrote:
> On Mon, Apr 14, 2014 at 01:27:41PM +0200, Sebastian Hesselbarth wrote:
> > On 04/14/2014 01:23 PM, Thomas Petazzoni wrote:
> > >Dear Sebastian Hesselbarth,
> > >
> > >On Mon, 14 Apr 2014 12:51:24 +0200, Sebastian Hesselbarth wrote:
> > >
> > >>>   		internal-regs {
> > >>>+			pinctrl at 10000 {
> > >>
> > >>Use node label reference:
> > >>
> > >>&pinctrl {
> > >>	...
> > >>};
> > >
> > >I personally dislike using node label references. I know they are used
> > >for Ethernet because it has been done by someone else for Orion
> > >platforms. But on all Armada 370/XP platforms, we don't use node label
> > >references, and I'd prefer to do it the same way for Orion5x platforms
> > >if possible.
> > 
> > Well, I definitely disagree and would like to _enforce_ using node
> > label references. Anyway, if there is a strong reason for not using
> > them, I'd be fine too.
>  
> Hi Sebastian, Thomas
> 
> Could you both explain your like/dislike for using node labels.
> 

Aside from aesthetical reasons, let me add a fact in favor of node labels.
When we added the MBus devicetree we had to do some intrusive and error-prone
node relocations, such as:

de1af8d486ae05922efbb69b93b902b197dfaca9

These changes would have been much simpler by using node labels, probably
one-liners.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
