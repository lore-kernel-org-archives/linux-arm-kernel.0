From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 23 Nov 2018 17:50:20 +0000
Subject: [RESEND PATCH v3 2/2] PCI: uniphier: Add UniPhier PCIe host
 controller support
In-Reply-To: <20181120211531.3607.4A936039@socionext.com>
References: <1539667641-26024-3-git-send-email-hayashi.kunihiko@socionext.com>
 <20181119161653.GA32232@e107981-ln.cambridge.arm.com>
 <20181120211531.3607.4A936039@socionext.com>
Message-ID: <20181123174754.GA9772@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 09:15:31PM +0900, Kunihiko Hayashi wrote:

[...]

> > > +static int uniphier_pcie_link_up(struct dw_pcie *pci)
> > 
> > This function returns a bool value, make it return a bool.
> 
> This function is registered in struct dw_pcie_ops.link_up, that is defined
> in pcie-designware.h as follows:
> 
>        int     (*link_up)(struct dw_pcie *pcie);
> 
> Changing the return type of this function makes type mismatch,
> so I think it's difficult to change it.

You are right, it is fine.

Thanks,
Lorenzo
