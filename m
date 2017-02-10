From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Feb 2017 16:40:47 +0100
Subject: [PATCH 4/4] ARM: dts: add PCI to the Gemini DTSI
In-Reply-To: <alpine.LNX.2.00.1702061038590.7077@T420s>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <CACRpkdbrys49Yv5fJ_te2H1mEUqquc1jn2dP-uvkdLixFbtYFA@mail.gmail.com>
 <alpine.LNX.2.00.1702061038590.7077@T420s>
Message-ID: <3236035.PSA6VtheyS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, February 6, 2017 10:55:03 AM CET Hans Ulli Kroll wrote:
> 
> from my IB 4220 sources.
> 
> #define IRQ_PCI_INTA                                   PCI_IRQ_OFFSET + 0
> #ifndef CONFIG_DUAL_PCI
> #define IRQ_PCI_INTB                                   PCI_IRQ_OFFSET + 1
> #define IRQ_PCI_INTC                                   PCI_IRQ_OFFSET + 2
> #define IRQ_PCI_INTD                                   PCI_IRQ_OFFSET + 3
> #else
> #define IRQ_PCI_INTB                                   27
> #define IRQ_PCI_INTC                                   28
> #define IRQ_PCI_INTD                                   29
> #endif
> 
> CONFIG_DUAL_PCI is never used
> IRQ_PCIB - IRQ_PCID or IRQ_PCI_INTB - IRQ_PCI_INTD are also never used.
> 
> 

The source code that Linus quoted earlier had references to 
'IRQ_PCI_INTA +n' though, which is basically the same thing.

	Arnd
