From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Wed, 7 Oct 2015 11:33:52 +0200
Subject: at91sam9 Main crystal frequency problems
In-Reply-To: <5613E822.2020004@overkiz.com>
References: <55ED3D3B.8060700@overkiz.com> <20150908181212.0b4336f0@bbrezillon>
 <55F6C07C.8080803@overkiz.com> <20151006161244.06f3ceb4@bbrezillon>
 <5613E822.2020004@overkiz.com>
Message-ID: <20151007093352.GA15524@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

On Tue, Oct 06, 2015 at 05:26:26PM +0200, Antoine Aubert wrote:
> Le 06/10/2015 16:12, Boris Brezillon a ?crit :
> > 
> > Any progress regarding this problem. I think Jiri (in Cc) has pretty
> > much the same problem (see this thread [1]).
> > IIRC, activating NO_HZ_IDLE solved the problem for you, but have you
> > find the root cause?
> 
> I'm not sure that the same issue. Here I don't have slow xtal.

There was no issue, it was just a misunderstanding on how the watchdog 
stack is working.


> What I found:
> * DTB was not up to date (build with an other kernel version)
>   Since we start from kexec, we added --dtb option
> * slow_xtal wasn't disabled in our DTS
> * defconfig was outdated
> 
> What i did first:
> * updated the dts, disabled slow xtal
> * Update DTB
> * activating NO_HZ_IDLE
> 
> > 20d updtime without WRST
> 
> Today what I did:
> * use LTS last kernel: 4.1.6
> * updated the dts, disabled slow xtal
> * generate config from scratch using "make ARCH=arm at91_dt_defconfig"
>   (without NO_HZ_IDLE=
> 
> 12h uptime, at this time no WRST

Great, no issue then, thank you !


Sylvain
