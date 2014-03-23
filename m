From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 23 Mar 2014 21:23:23 +0100
Subject: [PATCH 7/8] tty/serial: add arm64 semihosting earlycon
In-Reply-To: <alpine.LFD.2.11.1403231559160.1291@knanqh.ubzr>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
 <1395436128-11244-8-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.11.1403231559160.1291@knanqh.ubzr>
Message-ID: <14193198.1gAJ7xnz7b@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 23 March 2014 16:04:41 Nicolas Pitre wrote:
> On Fri, 21 Mar 2014, Rob Herring wrote:
> 
> > From: Rob Herring <robh@kernel.org>
> > 
> > Add earlycon support for the arm64 semihosting debug serial interface.
> > This allows enabling a debug console when early_params are processed.
> > This is based on the arm64 earlyprintk smh support and is intended to
> > replace it.
> > 
> > This is named arm rather than arm64 in hopes it will be used for both,
> > but only arm64 is supported ATM.
> 
> It can't be used for both as the semihosting calls themselves need 
> assembly code and this is not compatible with the equivalent ARM32 
> calls.  So I'd suggest naming this "arm64" to avoid potential confusion.

How about using an compile-time conditional to put both inline assemblies
in there? While the driver is rather trivial to start with, I don't see
a point in duplicating it either.

	Arnd
