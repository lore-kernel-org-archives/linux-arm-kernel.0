From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Dec 2014 20:42:56 +0100
Subject: [PATCHv1] rtc: bcm-iproc: Add support for Broadcom iproc rtc
In-Reply-To: <1418757750-3628-1-git-send-email-arun.ramamurthy@broadcom.com>
References: <1418757750-3628-1-git-send-email-arun.ramamurthy@broadcom.com>
Message-ID: <7947905.aK8KkUx4sY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 December 2014 11:22:30 arun.ramamurthy at broadcom.com wrote:
> +       rtc: iproc_rtc at 0x03026000 {
> +               compatible = "brcm,iproc-rtc";
> +               reg =   spru_bbl:               <0x03026000 0xC>,
> +                       crmu_pwr_good_status:   <0x0301C02C 0x14>,
> +                       crmu_bbl_auth:          <0x03024C74 0x8>;
> +               interrupts = spru_rtc_periodic: <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +                            spru_alarm:        <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;

The reg properties look really random, could it be that the registers
are really part of some other device that contains multiple functions?

Also, what do you use the labels for?

	Arnd
