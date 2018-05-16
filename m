From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 16 May 2018 11:39:18 +1000
Subject: linux-next: manual merge of the rockchip tree with the renesas
 tree
In-Reply-To: <20180503083654.625b1f9b@canb.auug.org.au>
References: <20180503083654.625b1f9b@canb.auug.org.au>
Message-ID: <20180516113918.1ccdd8ec@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Thu, 3 May 2018 08:36:54 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Today's linux-next merge of the rockchip tree got a conflict in:
> 
>   arch/arm64/configs/defconfig
> 
> between commits:
> 
>   93f7bfd930c0 ("arm64: defconfig: makes SND_SIMPLE_CARD to module")
>   ddf3fa8b8a16 ("arm64: defconfig: Enable CONFIG_SND_AUDIO_GRAPH_CARD")
> 
> from the renesas tree and commit:
> 
>   e9cfce4195ec ("arm64: defconfig: Enable HID over I2C drivers")
> 
> from the rockchip tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/arm64/configs/defconfig
> index 7930caf5dde4,34037d24fbf4..000000000000
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@@ -158,9 -157,9 +158,10 @@@ CONFIG_BT_HIDP=
>   # CONFIG_BT_LE is not set
>   CONFIG_BT_LEDS=y
>   # CONFIG_BT_DEBUGFS is not set
> + CONFIG_BT_HCIBTUSB=m
>   CONFIG_BT_HCIUART=m
>   CONFIG_BT_HCIUART_LL=y
>  +CONFIG_BT_HCIUART_BCM=y
>   CONFIG_CFG80211=m
>   CONFIG_MAC80211=m
>   CONFIG_MAC80211_LEDS=y
> @@@ -443,8 -447,8 +451,9 @@@ CONFIG_SND_BCM2835_SOC_I2S=
>   CONFIG_SND_SOC_SAMSUNG=y
>   CONFIG_SND_SOC_RCAR=m
>   CONFIG_SND_SOC_AK4613=m
>  -CONFIG_SND_SIMPLE_CARD=y
>  +CONFIG_SND_SIMPLE_CARD=m
>  +CONFIG_SND_AUDIO_GRAPH_CARD=m
> + CONFIG_I2C_HID=m
>   CONFIG_USB=y
>   CONFIG_USB_OTG=y
>   CONFIG_USB_XHCI_HCD=y

This is now a conflict between the renesas tree and the arm-soc tree.

-- 
Cheers,
Stephen Rothwell
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180516/730c2667/attachment.sig>
