From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jun 2013 19:32:22 +0100
Subject: [PATCH 1/4] Documentation: arm: [U]EFI runtime services
In-Reply-To: <1372345486.2522.23.camel@dabdike>
References: <51CA2B03.4080106@wwwdotorg.org>
 <CACxGe6vsBKnbipR-Zd1T9Ox1J2ugFmShrGXGUzPa_=D9TJvFQw@mail.gmail.com>
 <20130626135311.GA9078@rocoto.smurfnet.nu>
 <20130626135933.GQ22026@console-pimps.org> <1372257499.2168.5.camel@dabdike>
 <20130627013219.GA346@srcf.ucam.org>
 <CACxGe6uFkbuJ3BxM=A0Lu=jZQ79Ba8SmNsdBdTOO13szTfTZ=Q@mail.gmail.com>
 <1372314821.557.33.camel@dabdike>
 <CACxGe6uyMjT8HGb16+eqgCwZEDOuC6nkORvej2uGra3oCnyLwg@mail.gmail.com>
 <1372345486.2522.23.camel@dabdike>
Message-ID: <20130627183222.GE4283@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 08:04:46AM -0700, James Bottomley wrote:
> That's what the x86_64 proposal from Borislav Petkov does.  We alter the
> page tables before calling into the UEFI hooks to make sure both the
> physical and virtual addresses work.  Your problem on ARM with this
> approach is that you're a VI platform, not a PI platform like intel, so

Let me correct that.  Historically, ARM has had virtual indexed caches,
and some of its caches still are (eg, the instruction cache).  Some
data caches might still be technically indexed by virtual address but
as the virtual index uses the address bits below the page size, it's
equivalent to a physically indexed cache.

>From ARMv7, practially all data caches now do not suffer from aliasing
with themselves.  We do still suffer from data <-> instruction, and
cache <-> dma incoherence though.
