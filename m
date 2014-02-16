From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sun, 16 Feb 2014 18:17:24 -0300
Subject: [REGRESSION] 3.14-rc2 boot failure on Kirkwood (qnap ts-119p+)
In-Reply-To: <20140216202957.GC26583@lunn.ch>
References: <21248.39509.418884.931848@gargle.gargle.HOWL>
 <20140216143735.GA8680@localhost> <20140216202957.GC26583@lunn.ch>
Message-ID: <20140216211723.GA8291@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 16, 2014 at 09:29:57PM +0100, Andrew Lunn wrote:
> On Sun, Feb 16, 2014 at 11:45:20AM -0300, Ezequiel Garcia wrote:
> > Hi Mikael,
> > 
> > On Sun, Feb 16, 2014 at 12:00:37PM +0100, Mikael Pettersson wrote:
> > > My Kirkwood box worked fine with the 3.13 kernel, but with 3.14-rc2
> > > boot always fails due to a kernel NULL dereference in __clk_put.
> > > 
> > > This is a non-DT kernel, with:
> > > 
> > > CONFIG_ARCH_KIRKWOOD=y
> > > CONFIG_KIRKWOOD_LEGACY=y
> > > CONFIG_MACH_TS219=y
> > > # CONFIG_ARCH_KIRKWOOD_DT is not set
> > > 
> > 
> > Thanks for the report. I thought this issue was already fixed, but I
> > cannot find it on either the mailing lists or linux-next.
> > 
> > So, in case it hasn't been fixed here's an untested fix for you to test.
> > Please try this patch and let us know.
> > 
> > Your SATA won't work but if the patch is OK the kernel wont't blow away.
> > 
> > Andrew? Do we support the new phy requirement in non-DT platforms?
[..]
> 
> I consider Non-DT kirkwood now pretty much near death. Probably with
> 3.16 it will of gone altogether. So i did not plan for Non-DT to
> support SATA phy. I did however want it to at least boot, so i broke
> something here :-(
> 

I'm pretty sure v3.14-rc{3,4} will be fine for DT and non-DT plaforms,
as Mikael already reported linux-next works. Non-DT Kirkwood would
behave just as Armada 370/XP platforms, where a SATA phy is not
registered.

> I will take a look at your fix and what we can expect in the next -rc.
> 

AFAICS, the patch is a fix on its own, and should be merged (after we're
happy with it) for v3.14.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
