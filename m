From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 23 Mar 2014 17:48:48 -0400 (EDT)
Subject: [PATCH 7/8] tty/serial: add arm64 semihosting earlycon
In-Reply-To: <14193198.1gAJ7xnz7b@wuerfel>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
 <1395436128-11244-8-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.11.1403231559160.1291@knanqh.ubzr>
 <14193198.1gAJ7xnz7b@wuerfel>
Message-ID: <alpine.LFD.2.11.1403231742430.1291@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 23 Mar 2014, Arnd Bergmann wrote:

> On Sunday 23 March 2014 16:04:41 Nicolas Pitre wrote:
> > On Fri, 21 Mar 2014, Rob Herring wrote:
> > 
> > > From: Rob Herring <robh@kernel.org>
> > > 
> > > Add earlycon support for the arm64 semihosting debug serial interface.
> > > This allows enabling a debug console when early_params are processed.
> > > This is based on the arm64 earlyprintk smh support and is intended to
> > > replace it.
> > > 
> > > This is named arm rather than arm64 in hopes it will be used for both,
> > > but only arm64 is supported ATM.
> > 
> > It can't be used for both as the semihosting calls themselves need 
> > assembly code and this is not compatible with the equivalent ARM32 
> > calls.  So I'd suggest naming this "arm64" to avoid potential confusion.
> 
> How about using an compile-time conditional to put both inline assemblies
> in there? While the driver is rather trivial to start with, I don't see
> a point in duplicating it either.

Sure.  But it can be trivially renamed at that point.

Or, even better would be to add the ARM calls right away.  And of course 
ARM in Thumb mode has yet another call convention.

The printascii and printch code in arch/arm/kernel/debug.S for
CONFIG_DEBUG_SEMIHOSTING can be copied almost as is.


Nicolas
