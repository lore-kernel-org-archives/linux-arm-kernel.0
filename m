From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Jan 2015 15:34:25 +0100
Subject: Use armv8 instructions to optimize ARM32 crypto
In-Reply-To: <1420723794.21522.6.camel@mtksdaap41>
References: <1420452722.4402.70.camel@mtksdaap41>
 <1420723794.21522.6.camel@mtksdaap41>
Message-ID: <2161528.hd6uXvZTsx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 January 2015 21:29:54 hong-rong hsu wrote:
> Excuse me, add more reviewers.
> 
> On Mon, 2015-01-05 at 18:12 +0800, hong-rong hsu wrote:
> > Hi,
> > 
> > We are engineers from Mediatek. We have a patch to optimize ARM32 kernel
> > crypto performance by armv8 instructions. Do you have interest in it?
> > 
> > It may be helpful for some projects which running 32-bit kernel at
> > armv8. Do you suggest that we maintain it at the main-stream :-)? (ex.
> > add aes-armv8.S in arch/arm/crypto/ folder)

It sounds like this is just an additional driver, so that should not
be a problem.

A slight concern that I have is that we don't really support ARMv8
in 32-bit mode. There are a few differences between v7 and v8, and
building the kernel with -march=armv8 will currently result in build
warnings for deprecated assembler instructions, IIRC.

	Arnd
