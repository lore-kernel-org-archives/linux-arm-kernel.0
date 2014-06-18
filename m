From: Mohit.KUMAR@st.com (Mohit KUMAR DCG)
Date: Wed, 18 Jun 2014 18:14:28 +0800
Subject: [PATCH v2 0/8] Add Keystone PCIe controller driver
In-Reply-To: <1402426287-31157-1-git-send-email-m-karicheri2@ti.com>
References: <1402426287-31157-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB6619C5F8169D1@EAPEX1MAIL1.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Murali,

> -----Original Message-----
> From: Murali Karicheri [mailto:m-karicheri2 at ti.com]
> Sent: Wednesday, June 11, 2014 12:21 AM
> To: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> linux-pci at vger.kernel.org; devicetree at vger.kernel.org; linux-
> doc at vger.kernel.org
> Cc: Murali Karicheri; Santosh Shilimkar; Russell King; Grant Likely; Rob Herring;
> Mohit KUMAR DCG; Jingoo Han; Bjorn Helgaas; Pratyush ANAND; Richard
> Zhu; Kishon Vijay Abraham I; Marek Vasut; Arnd Bergmann; Pawel Moll;
> Mark Rutland; Ian Campbell; Kumar Gala; Randy Dunlap
> Subject: [PATCH v2 0/8] Add Keystone PCIe controller driver
> 
> This patch adds a PCIe controller driver for Keystone SoCs. This is based on v1
> of the series posted to the mailing list.
> 

1. I think your first patch is OK which handles platform specific ATU implementation.

2. For MSI part, I think you just need to add two new callbacks with pp-ops, something similar to:
pp->ops->msi_set
pp->ops->msi_clear

With these two platform specific callbacks you should be able to manage MSI handling.
So idea is that dw_msi code uses pp->ops->msi_set/clear if platform define these,
otherwise use dw_msi_set/clear (which you need to refactor from existing code)

So other than your keystone changes we expect 3 patches:
--  1st same as you sent 1/8: for ATU handeling
-- 2nd to refactor dw_msi_set/clear: refactor from existing code
-- 3rd to use pp->ops->msi_set/clear if defined.

Pls let us know for any issue or have different opinion.

Regards
Mohit



 
> 
> --
> 1.7.9.5
