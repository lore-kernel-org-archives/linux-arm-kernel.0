From: balbi@ti.com (Felipe Balbi)
Date: Tue, 21 Aug 2012 13:47:45 +0300
Subject: [PATCH 3/4] arm/dts: omap5-evm: Add keypad support
In-Reply-To: <1345545940-2232-4-git-send-email-sourav.poddar@ti.com>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
 <1345545940-2232-4-git-send-email-sourav.poddar@ti.com>
Message-ID: <20120821104744.GV10347@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 04:15:39PM +0530, Sourav Poddar wrote:
> Add keypad data node in omap5-evm.
> 
> Based on I2C support patch for omap5, which has been
> already posted as a different series.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Tested on omap5430 sdp with 3.5 custom kernel.
> 
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>

after fixing my only comment below, you can add my:

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/omap5-evm.dts |   95 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 95 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
> index 200c39a..6473983 100644
> --- a/arch/arm/boot/dts/omap5-evm.dts
> +++ b/arch/arm/boot/dts/omap5-evm.dts
> @@ -18,3 +18,98 @@
>  		reg = <0x80000000 0x40000000>; /* 1 GB */
>  	};
>  };
> +
> +&i2c5 {
> +	clock-frequency = <400000>;
> +
> +	smsc at 38 {
> +		compatible = "smsc";
> +		reg = <0x38>;
> +		clock = <0x13>;
> +		keypad {
> +			compatible = "smsc,keypad";
> +			interrupt-parent = <&gpio5>;
> +			interrupts = <23>; /* gpio line 151 */
> +			keypad,num-rows = <8>;
> +			keypad,num-columns = <16>;
> +			linux,keymap = < 0x20041 /*KEY_F7*/

please add spaces around /* and */ so it's easier to read. Ditto to all
others.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/89f15343/attachment-0001.sig>
