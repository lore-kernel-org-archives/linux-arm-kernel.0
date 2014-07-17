From: pratyush.anand@st.com (Pratyush Anand)
Date: Thu, 17 Jul 2014 09:01:32 +0530
Subject: [PATCH v5 2/5] PCI: designware: refactor MSI code to work with
 v3.65 dw hardware
In-Reply-To: <1405528686-16539-3-git-send-email-m-karicheri2@ti.com>
References: <1405528686-16539-1-git-send-email-m-karicheri2@ti.com>
 <1405528686-16539-3-git-send-email-m-karicheri2@ti.com>
Message-ID: <20140717033132.GH12278@pratyush-vbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 12:38:03AM +0800, Murali Karicheri wrote:
> Keystone PCI controller is based on v3.65 version of the DW
> PCI h/w that implements MSI controller registers in application
> space compared to the newer version. This requires updates to
> the DW core API to support the PCI controller driver based on
> this old DW hardware. Add msi_irq_set()/clear() API functions to
> allow Set/Clear MSI IRQ enable bit in the application register.
> Also the old h/w uses MSI_IRQ register in application register
> space to raise MSI IRQ to the RC from EP. Current code uses the
> standard mechanism as per PCI spec. So add another API get_msi_data()
> to get the address of this register so that common code can be
> re-used on old h/w.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Acked-by: Mohit Kumar <mohit.kumar@st.com>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 

Reviewed-by: Pratyush Anand <pratyush.anand@st.com>
