From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 20 Feb 2014 18:24:38 -0500
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <20140220105854.GL11878@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-22-git-send-email-andrew@lunn.ch>
 <52F51922.6030502@gmail.com>
 <1392892217.23342.18.camel@kazak.uk.xensource.com>
 <20140220105854.GL11878@lunn.ch>
Message-ID: <20140220232438.GT7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 11:58:54AM +0100, Andrew Lunn wrote:
> On Thu, Feb 20, 2014 at 10:30:17AM +0000, Ian Campbell wrote:
> > On Fri, 2014-02-07 at 18:34 +0100, Sebastian Hesselbarth wrote:
> > > On 02/07/2014 12:42 AM, Andrew Lunn wrote:
> > > > Now that all the device tree support is in mach-mvebu, remove it from
> > > > mach-kirkwood.
> > > >
> > > > Regenerate kirkwood_defconfig, removing all DT support, and a couple
> > 
> > s/DT/board-file/?
> 
> We keep any system using -setup.c files, and remove the ability to
> boot systems with a DT description. Thus mach-kirkwood becomes legacy,
> and you should now be trying to only use mach-mvebu, compiled for v5
> systems and a second compile for v7 systems.
> 
> There are four systems left in mach-kirkwood which don't have DT
> equivalent. These are LaCie 2Big and 5Big, HP t5325 thin client and
> Marvell OpenRD machines. I'm working on t5325 and Openrd. The sticking
> point is audio support, which no other board has done with DT yet.
> The two LeCie boards have a custom LED driver which needs a DT
> binding. My gut feeling is that we won't get these four converted to
> DT in time for 3.15.

Why not do like we did when we started the kirkwood dt conversion?
Create dts files for the remaining boards, and do

if (of_machine_is_compatible(...))
	legacy_audio_init()

in board-v5.c?

I suspect audio is going to take time to sort out.  I'd hate to delay
this just for that.

thx,

Jason.
