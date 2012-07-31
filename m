From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 31 Jul 2012 23:16:19 +0000
Subject: [RFC 20/22] ARM: keystone: introducing TI Keystone platform
In-Reply-To: <1343775898-28345-21-git-send-email-cyril@ti.com>
References: <1343775898-28345-1-git-send-email-cyril@ti.com>
 <1343775898-28345-21-git-send-email-cyril@ti.com>
Message-ID: <201207312316.19592.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 31 July 2012, Cyril Chemparathy wrote:
> Texas Instruments Keystone family of multicore devices now includes an
> upcoming slew of Cortex A15 based devices.  This patch adds basic definitions
> for a new Keystone sub-architecture in ARM.
> 
> Subsequent patches in this series will extend support to include SMP and take
> advantage of the large physical memory addressing capabilities via LPAE.
> 
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

And some nitpicking:
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 debug earlyprintk lpj=50000 rdinit=/bin/ash rw root=/dev/ram0 initrd=0x85000000,9M";
> +	};

This command line should not really be here. Most of what you put in it is not
generic to the platform at all.

In order to select the console, use an alias for the serial device.

> +
> +static void __init keystone_map_io(void)
> +{
> +	iotable_init(io_desc, sizeof(io_desc)/sizeof(struct map_desc));
> +}

Use the ARRAY_SIZE macro here.

	Arnd
