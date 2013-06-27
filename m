From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Thu, 27 Jun 2013 08:09:50 -0700
Subject: [PATCH 1/4] Documentation: arm: [U]EFI runtime services
In-Reply-To: <20130627143714.GA12900@srcf.ucam.org>
References: <1372183863-11333-1-git-send-email-leif.lindholm@linaro.org>
 <1372183863-11333-2-git-send-email-leif.lindholm@linaro.org>
 <51CA2B03.4080106@wwwdotorg.org>
 <CACxGe6vsBKnbipR-Zd1T9Ox1J2ugFmShrGXGUzPa_=D9TJvFQw@mail.gmail.com>
 <20130626135311.GA9078@rocoto.smurfnet.nu>
 <20130626135933.GQ22026@console-pimps.org>
 <1372257499.2168.5.camel@dabdike> <20130627013219.GA346@srcf.ucam.org>
 <CACxGe6uFkbuJ3BxM=A0Lu=jZQ79Ba8SmNsdBdTOO13szTfTZ=Q@mail.gmail.com>
 <1372314821.557.33.camel@dabdike> <20130627143714.GA12900@srcf.ucam.org>
Message-ID: <1372345790.2522.26.camel@dabdike>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-06-27 at 15:37 +0100, Matthew Garrett wrote:
> On Wed, Jun 26, 2013 at 11:33:41PM -0700, James Bottomley wrote:
> > On Thu, 2013-06-27 at 07:23 +0100, Grant Likely wrote:
> > > What is the problem trying to be avoided by not using the virtual map?
> > > Is it passing the virtual mapping data from one kernel to the next
> > > when kexecing? Or something else?
> > 
> > Where to begin ... SetVirtualAddressMap() is one massive hack job ...
> > just look at the tiano core implementation.   Basically it has a fixed
> > idea of where all the pointers are and it tries to convert them all to
> > the new address space.  The problem we see in x86 is that this
> > conversion process isn't exhaustive due to implementation cockups, so
> > the post virtual address map image occasionally tries to access
> > unconverted pointers via the old physical address and oopses the kernel.
> 
> And yet it's the only mode in which the firmrware is actually tested 
> against an OS, so we don't have any real choice in the matter.

Agree for x86 ... we just have to cope with the implementations we see
in the field.  However, ARM has much more scope to have the UEFI
implementation developed collaboratively with Linux as the reference
platform.  If we can convince the ARM implementors that
SetVirtualAddressMap is an accident waiting to happen, they might be
more flexible.

James
