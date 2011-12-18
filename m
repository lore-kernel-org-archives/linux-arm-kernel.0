From: tixy@yxit.co.uk (Tixy)
Date: Sun, 18 Dec 2011 11:58:42 +0000
Subject: arm and patch phys offset
In-Reply-To: <201112140017.49567.michael@walle.cc>
References: <201112112255.32534.michael@walle.cc>
 <201112130108.25337.michael@walle.cc>
 <alpine.LFD.2.02.1112122256580.2907@xanadu.home>
 <201112140017.49567.michael@walle.cc>
Message-ID: <1324209522.31155.13.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-12-14 at 00:17 +0100, Michael Walle wrote:
> Am Dienstag 13 Dezember 2011, 05:01:30 schrieb Nicolas Pitre:
> > > Seems like the l2 cache is enabled after uboot starts the linux kernel.
> > > I'll dig deeper into that tomorrow.
> > > 
> > > For now, i appended
> > > 
> > >   l2_cache_disable();
> > > 
> > > to uboots cleanup_before_linux() and all stubs seems to be patched
> > > correctly.
> > 
> > Strange.  Having l2 enabled shouldn't cause such trouble.
> There is a similar commit in uboots git tree:
> http://git.denx.de/?p=u-
> boot.git;a=commit;h=dc7100f4080952798413fb63bb4134b22c57623a
> 
> I don't know if this is somehow connected to my problem ;)

Michael, did you discover anything else about the problem?

I just tried 3.2-rc6 on my eSata SheevaPlug and I don't get anything
after "Uncompressing Linux... done, booting the kernel". If I hack
CONFIG_ARM_PATCH_PHYS_VIRT to be disabled, the it boots OK. My U-Boot
reports "U-Boot 2011.03 (Apr 26 2011 - 21:50:07)"

I haven't got time to dig deeper at the moment, but thought I'd report
'me too'.

-- 
Tixy
