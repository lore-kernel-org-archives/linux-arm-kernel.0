From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Thu, 27 Jun 2013 02:32:19 +0100
Subject: [PATCH 1/4] Documentation: arm: [U]EFI runtime services
In-Reply-To: <1372257499.2168.5.camel@dabdike>
References: <1372183863-11333-1-git-send-email-leif.lindholm@linaro.org>
 <1372183863-11333-2-git-send-email-leif.lindholm@linaro.org>
 <51CA2B03.4080106@wwwdotorg.org>
 <CACxGe6vsBKnbipR-Zd1T9Ox1J2ugFmShrGXGUzPa_=D9TJvFQw@mail.gmail.com>
 <20130626135311.GA9078@rocoto.smurfnet.nu>
 <20130626135933.GQ22026@console-pimps.org>
 <1372257499.2168.5.camel@dabdike>
Message-ID: <20130627013219.GA346@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 07:38:19AM -0700, James Bottomley wrote:
> The fixed virtual address scheme currently being looked at for x86_64 to
> make SetVirtualAddressMap() kexec invariant doesn't work on 32 bit
> because the address space isn't big enough.  For ARM, given that we've
> much more opportunity to work with the vendors, can we just avoid
> transitioning to a virtual address map and always just install a
> physical mapping before doing efi calls?

We can probably get away with that now, but it does risk us ending up 
with some firmware that expects to run in physical mode (boards designed 
for Linux) and some firmware that expects to run in virtual mode (boards 
designed for Windows). The degree of lockdown in the Windows ecosystem 
at present means it's not a real problem at the moment, but if that ever 
changes we're going to risk incompatibility.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
