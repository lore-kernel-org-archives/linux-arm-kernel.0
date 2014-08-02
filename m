From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sat, 02 Aug 2014 04:17:51 +0200
Subject: [PATCH v6 05/10] ARM: dts: Fill in bootargs for exynos5250-snow
In-Reply-To: <1406940750-15880-6-git-send-email-afaerber@suse.de>
References: <1406940750-15880-1-git-send-email-afaerber@suse.de>
 <1406940750-15880-6-git-send-email-afaerber@suse.de>
Message-ID: <53DC4A4F.8060009@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas,

Sorry for missing your v5.

On 08/02/2014 02:52 AM, Andreas F?rber wrote:
>  
>  	chosen {
> +		bootargs = "console=tty1";
>  	};

While I agree with you that having a chosen node with a default bootargs is
better than having an empty one, I second Doug that this bootargs is not very
useful.

If you want to add a bootargs in the DTS I think that it should be a complete
kernel command line that allows to boot a system. I would at least add a root
parameter and possibly another console for the serial port. So if
CMDLINE_FROM_BOOTLOADER is not set then the DT can be used to specify the
bootargs instead of using whatever was set in CONFIG_CMDLINE which probably
won't be relevant for every system on a multi-platform kernel.

But I think that is safe to rely on the bootloader to set the bootargs and after
all having a hardcoded bootargs in the DTS is not much better than having a
hardcoded CONFIG_CMDLINE since as Doug said it is hard to make assumptions about
what would be the most common options.

Personally I would just drop this change and as I said before remove the empty
chosen node on a follow up patch but I don't have a strong opinion either.

Best regards,
Javier
