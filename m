From: eric@anholt.net (Eric Anholt)
Date: Tue, 01 Dec 2015 15:03:51 -0800
Subject: [PATCH RFC 4/4] ARM: bcm2835: assign pins to sdhci pinctrl
In-Reply-To: <1447949176-21926-5-git-send-email-stefan.wahren@i2se.com>
References: <1447949176-21926-1-git-send-email-stefan.wahren@i2se.com>
 <1447949176-21926-5-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87d1upu5yg.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Finally this patch assign all relevant pins to the sdhci pinctrl.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/bcm2835-rpi-a-plus.dts |    4 ++++
>  arch/arm/boot/dts/bcm2835-rpi-b-plus.dts |    4 ++++
>  arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts |    4 ++++
>  arch/arm/boot/dts/bcm2835-rpi-b.dts      |    4 ++++
>  4 files changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
> index 50be11d..4d562d9 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
> +++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
> @@ -28,3 +28,7 @@
>  		brcm,function = <BCM2835_FSEL_ALT0>;
>  	};
>  };
> +
> +&sdhci {
> +	pinctrl-0 = <&sdhci_alt3>;
> +};

[...]

What effect does this have?  Does this change any pinmuxing at boot?  If
so, is it just resetting things from what the firmware has set to what
we expect it to be?  Does it enable card detection on the Pi B?

As far as the whole series, I really like the improved description in
patch 2, and patch 3 seems like a good idea, too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151201/432834ea/attachment.sig>
