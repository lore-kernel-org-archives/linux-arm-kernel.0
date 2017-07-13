From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 13 Jul 2017 18:48:37 +0800
Subject: [RFC] PCI: dwc: designware: allow customize unroll registers'
 readl/writel
Message-ID: <20170713184837.541ccf26@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joao, Jingoo,

Now, the PCIE_GET_ATU_OUTB_UNR_REG_OFFSET macro is defined as:

/* Register address builder */
#define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)        \
                        ((0x3 << 20) | ((region) << 9))

I have one question: where does the (0x3 << 20) come from? 2MB space, a bit
large. And I didn't find it in the databook. Is it platform specific?
If yes, I want to cook one patch to customize unroll registers' readl/writel.

And how does (0x3 << 20) enable DBI2 access?

Thanks in advance,
Jisheng
