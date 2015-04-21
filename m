From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Apr 2015 09:32:40 +0100
Subject: [PATCH v3 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX
 termination driver
In-Reply-To: <CAL85gmBFpKU7q31Utr+L_iHDM259kxmsL-0X=7WLB4k5xw65CA@mail.gmail.com>
References: <20150408084448.5f0793b7@why.wild-wind.fr.eu.org>	<cover.1428564115.git.dhdang@apm.com>	<7923ef6ffd60a7c3de3c8c04fe746bbd3c15b5ac.1428564115.git.dhdang@apm.com>	<55280665.9020603@arm.com>	<CADaLNDkrqwnEOX1HgQ7V3-1o4cDJnG4dW1=U4ujod7fUW_PQ0w@mail.gmail.com>	<7a739a984c1b849ae92cb3bb3edc92f2@www.loen.fr>	<CADaLNDmxrpJ-t6fR=DVBzB1q_jp58H94oZnRrxZYtCvDCWJpog@mail.gmail.com>	<20150415091655.02361cdc@arm.com>	<CADaLNDkuXpMVanyPD1oMOK-uvdt+vK2+UabgUxvaK9bBZDmdKg@mail.gmail.com>	<5530DD9D.9020808@arm.com>	<CADaLNDkAu4o6YQkw528+1npWAa_CeX-ZfFED0zWRsz+WAfwf6A@mail.gmail.com>	<55310050.7000003@arm.com>
 <CAL85gmBFpKU7q31Utr+L_iHDM259kxmsL-0X=7WLB4k5xw65CA@mail.gmail.com>
Message-ID: <55360B28.1060703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/04/15 19:51, Feng Kan wrote:

> Is it possible to use the pci_msi_create_default_irq_domain for the X-Gene MSI
> driver. Or is this going to be removed in the future. Thanks

This is not the preferred way. pci_msi_create_default_irq_domain is only
there for legacy purposes, so that we can lookup an MSI without
specifying the domain. New code shouldn't have to rely on it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
