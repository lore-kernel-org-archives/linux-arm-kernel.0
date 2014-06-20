From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 20 Jun 2014 13:29:56 -0400
Subject: [PATCH v2 3/8] PCI: designware: update pcie core driver to work
 with dw hw version 3.65
In-Reply-To: <53A46EE7.6080209@ti.com>
References: <1402426287-31157-1-git-send-email-m-karicheri2@ti.com>
 <1402426287-31157-4-git-send-email-m-karicheri2@ti.com>
 <2CC2A0A4A178534D93D5159BF3BCB6619C5F8168DA@EAPEX1MAIL1.st.com>
 <53A46EE7.6080209@ti.com>
Message-ID: <53A46F94.1020901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 June 2014 01:27 PM, Murali Karicheri wrote:
> On 6/18/2014 3:13 AM, Mohit KUMAR DCG wrote:
>> Hello Murali,
>>
>>> -----Original Message-----
>>> From: Murali Karicheri [mailto:m-karicheri2 at ti.com]
>>> Sent: Wednesday, June 11, 2014 12:21 AM
>>> To: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
>>> linux-pci at vger.kernel.org; devicetree at vger.kernel.org; linux-
>>> doc at vger.kernel.org
>>> Cc: Murali Karicheri; Santosh Shilimkar; Russell King; Grant Likely; Rob Herring;
>>> Mohit KUMAR DCG; Jingoo Han; Bjorn Helgaas; Pratyush ANAND; Richard
>>> Zhu; Kishon Vijay Abraham I; Marek Vasut; Arnd Bergmann; Pawel Moll;
>>> Mark Rutland; Ian Campbell; Kumar Gala; Randy Dunlap
>>> Subject: [PATCH v2 3/8] PCI: designware: update pcie core driver to work
>>> with dw hw version 3.65
>>>
>>> v3.65 version of the dw hw has MSI controller implemented in the application
>>> space. Add a version variable in the port struct to identify v3.65 hardware for
>>> different code treatment. This variable will have DW_V3_65 bit set when
>>> running on this hw version. The host init code is expected to set this version
>>> based on compatibility string dw,snps-pcie-v3.65.
>>>
>>> Some of the MSI specific functions from current DW driver are re-used on
>>> v3.65 hw. However on v3.65, MSI controller registers are in the application
>>> register space and PCIE_MSI_INTR0_ENABLE is not applicable.
>>> Modify assign_irq() to check for version and not execute the code for
>>> PCIE_MSI_INTR0_ENABLE configuration on v3.65 hw. Additionally MSI IRQ
>>> register in application space is written by EP to raise an MSI IRQ. So add a
>>> get_msi_data() function in pcie_host_ops to retrieve the register address in
>>> dw_msi_setup_irq(). v3.65 dw core driver implements this function.
>>>
>>> Also make some of the functions available in dw core driver global and make
>>> their prototypes available in the header file for re-use on v3.65.
>>>
>> - Pls apply MSI specific changes on the top of Lucas patches:
>> [PATCH 0/4] proper multi MSI handling for designware host
>>
>> Thanks
>> Mohit
> Ok. I have pulled in Lucas's patches and use it for my work.

Are those patches already acked and getting into the queue. Please
don't create UN-necessary merge dependencies otherwise.

regards,
Santosh
