From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 30 Oct 2016 16:34:18 +0100
Subject: [PATCH 2/2] ARM: dts: bcm283x: fix typo in mailbox address
In-Reply-To: <1477505640-26658-2-git-send-email-stefan.wahren@i2se.com>
References: <1477505640-26658-1-git-send-email-stefan.wahren@i2se.com>
 <1477505640-26658-2-git-send-email-stefan.wahren@i2se.com>
Message-ID: <6b13e96d-78d1-fcab-4273-803310ae4da6@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 26.10.2016 um 20:14 schrieb Stefan Wahren:
> The address of the mailbox node in the bcm283x.dts has also a typo.

.dts -> .dtsi

"also has" or maybe "has the same typo as in the binding example"?

> So fix it accordingly.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: 05b682b7a3b2 ("ARM: bcm2835: dt: Add the mailbox to the device tree")
> ---
>  arch/arm/boot/dts/bcm283x.dtsi |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index 46d46d8..74dd21b 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -104,7 +104,7 @@
>  			reg = <0x7e104000 0x10>;
>  		};
>  
> -		mailbox: mailbox at 7e00b800 {
> +		mailbox: mailbox at 7e00b880 {
>  			compatible = "brcm,bcm2835-mbox";
>  			reg = <0x7e00b880 0x40>;
>  			interrupts = <0 1>;

Otherwise,

Reviewed-by: Andreas F?rber <afaerber@suse.de>

At one point in time dtc did complain about such mismatches...

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
