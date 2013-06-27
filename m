From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Thu, 27 Jun 2013 15:38:01 +0100
Subject: [PATCH 1/4] Documentation: arm: [U]EFI runtime services
In-Reply-To: <20130627090050.GC18151@rocoto.smurfnet.nu>
References: <1372183863-11333-1-git-send-email-leif.lindholm@linaro.org>
 <1372183863-11333-2-git-send-email-leif.lindholm@linaro.org>
 <51CA2B03.4080106@wwwdotorg.org>
 <CACxGe6vsBKnbipR-Zd1T9Ox1J2ugFmShrGXGUzPa_=D9TJvFQw@mail.gmail.com>
 <20130626135311.GA9078@rocoto.smurfnet.nu>
 <20130626135933.GQ22026@console-pimps.org>
 <1372257499.2168.5.camel@dabdike>
 <20130627013219.GA346@srcf.ucam.org>
 <20130627090050.GC18151@rocoto.smurfnet.nu>
Message-ID: <20130627143801.GB12900@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 11:00:50AM +0200, Leif Lindholm wrote:
> On Thu, Jun 27, 2013 at 02:32:19AM +0100, Matthew Garrett wrote:
> > We can probably get away with that now, but it does risk us ending up 
> > with some firmware that expects to run in physical mode (boards designed 
> > for Linux) and some firmware that expects to run in virtual mode (boards 
> > designed for Windows). The degree of lockdown in the Windows ecosystem 
> > at present means it's not a real problem at the moment, but if that ever 
> > changes we're going to risk incompatibility.
> 
> Is there anything preventing calling SetVirtualAddressMap() with a
> 1:1 map?

No, but we've seen bugs as a result on some x86 systems. As far as the 
spec, though, you're fine.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
