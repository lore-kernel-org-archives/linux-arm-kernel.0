From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 16 Nov 2018 12:10:43 +0000
Subject: [PATCH] PCI: armada8k: add support for gpio controlled reset
 signal
In-Reply-To: <20181003133543.t7laclm5wbj2olhq@sapphire.tkos.co.il>
References: <405efb21a4600efad10413fcf4c72aacce180125.1538570983.git.baruch@tkos.co.il>
 <20181003132811.GC427@lunn.ch>
 <20181003133543.t7laclm5wbj2olhq@sapphire.tkos.co.il>
Message-ID: <20181116121043.GC3228@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2018 at 04:35:43PM +0300, Baruch Siach wrote:
> Hi Andrew,
> 
> On Wed, Oct 03, 2018 at 03:28:11PM +0200, Andrew Lunn wrote:
> > On Wed, Oct 03, 2018 at 03:49:43PM +0300, Baruch Siach wrote:
> > > This commit adds support for the gpio reset signal binding as described
> > > in the designware-pcie.txt DT binding document. Both the documented
> > > 'reset-gpio' property name, and the more standard 'reset-gpios' name are
> > > supported.
> > 
> > I don't know this code at all, so maybe a dumb question. Why support
> > the old none-standard binding of reset-gpio on new hardware? I'm
> > assuming reset-gpio is marked a deprecated and reset-gpios is
> > recommended?
> 
> This is all hidden behind the devm_gpiod_get_optional() call that only sees 
> the "reset" string. The generic code supports both the new property name and 
> also the older one for backward compatibility. This patch changes nothing in 
> this regard.
> 
> The designware-pcie.txt document mentions the older 'reset-gpio' name. So I 
> mentioned that name as well in the commit log.

I need Thomas' ACK to proceed with this patch.

Thanks,
Lorenzo
