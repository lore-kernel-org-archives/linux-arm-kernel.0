From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jun 2016 23:06:26 +0200
Subject: [PATCH] arm/arm64/irqchip/pci: fix PCI_MSI dependencies
In-Reply-To: <20160615210211.GA17504@localhost>
References: <8531046.3ceRqUA835@wuerfel> <20160615210211.GA17504@localhost>
Message-ID: <6064404.Y6hC1iYELB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 15, 2016 4:02:11 PM CEST Bjorn Helgaas wrote:
> I applied this to pci/msi, minus the crypto change that looks unrelated:
> 
> > @@ -1038,6 +1038,8 @@ source "arch/arm64/Kconfig.debug"
> >  source "security/Kconfig"
> >  
> >  source "crypto/Kconfig"
> > +if CRYPTO
> >  source "arch/arm64/crypto/Kconfig"
> > +endif

Indeed, thanks for catching this!

	Arnd
