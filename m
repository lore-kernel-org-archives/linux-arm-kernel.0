From: govindraj.ti@gmail.com (Govindraj)
Date: Wed, 4 May 2011 15:36:58 +0530
Subject: [PATCH v2 07/12] OMAP: Serial: Allow UART parameters to be
	configured from board file
In-Reply-To: <20110504095546.GY2092@atomide.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-8-git-send-email-govindraj.raja@ti.com>
	<20110504095546.GY2092@atomide.com>
Message-ID: <BANLkTimb-AsuXYRm+NV8CD3m=xHwteV7pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 4, 2011 at 3:25 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Govindraj.R <govindraj.raja@ti.com> [110429 05:39]:
>> @@ -250,7 +251,7 @@ static void __init omap_2430sdp_init(void)
>> ? ? ? omap2430_i2c_init();
>>
>> ? ? ? platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
>> - ? ? omap_serial_init();
>> + ? ? omap_serial_init(NULL);
>> ? ? ? omap2_hsmmc_init(mmc);
>> ? ? ? omap2_usbfs_init(&sdp2430_usb_config);
> ...
>
>> ?static inline void board_serial_init(void)
>> ?{
>> - ? ? omap_serial_init();
>> + ? ? omap_serial_init(NULL);
>> ?}
>
> This change seems like "crazy churn" and probably not needed
> if it's always null. Boards using platform_data can use
> omap_serial_init_port instead, right?

We can intiliaze only one uart port with omap_serial_init_port.

omap_serial_init initializes all uart port.

During any client device integration using dma mode
(for example Bluetooth) we can pass the dma config
params based on the board & client device.

--
Govindraj.R


>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
