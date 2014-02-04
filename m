From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Feb 2014 20:50:43 +0100
Subject: [PATCH] arm64: Add architecture support for PCI
In-Reply-To: <CAL_JsqLN4RjVzNCfZ50K44RcP61Z8zFOVnpY1+CfVFz_QnSBEg@mail.gmail.com>
References: <1391453028-23191-1-git-send-email-Liviu.Dudau@arm.com>
 <13031998.NR888KZWhk@wuerfel>
 <CAL_JsqLN4RjVzNCfZ50K44RcP61Z8zFOVnpY1+CfVFz_QnSBEg@mail.gmail.com>
Message-ID: <201402042050.43837.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 February 2014, Rob Herring wrote:
> > Here is how a sane person would read SBSA to create a compliant
> > implementation:
> 
> s/sane/software/

> > Here is how a crazy person would read the same sentence in the SBSA:
> 
> s/crazy/hardware/

Not much of a difference, apparently ...

> My money is on the latter. I think non-PCI implementations of xHCI
> interfaces will be common. This was certainly the case at Calxeda in
> what was believed to be a SBSA compliant SOC.

I just looked up the EHCI and xHCI specs and am shocked to see that
the PCI config space access for both is an optional part of the
spec, so that assertion may well have been correct.

On the other hand, it does seem impossible to create a compliant
AHCI implementation without making it show up as a PCI function,
so any SBSA compliant SoC that contains AHCI already has to have
all the bits for doing the same on USB.

> However, I think PCI
> device or not is the least of the issues and all the other examples
> you list are the difficult ones to deal with.

Agreed. But if they get the difficult problems right, it's
trivial to also do the PCI config space either in the way
that Jason described, or as a separate PCI domain. In the worst
case, it could still be faked up by a secure-mode firmware
catching all config space accesses.

	Arnd
