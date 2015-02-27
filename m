From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Feb 2015 21:33:34 +0100
Subject: [PATCH 2/3] dtb: change binding name to match with newer firmware
 DT
In-Reply-To: <1425067710-14879-3-git-send-email-isubramanian@apm.com>
References: <1425067710-14879-1-git-send-email-isubramanian@apm.com>
 <1425067710-14879-3-git-send-email-isubramanian@apm.com>
Message-ID: <4061014.S4PDWltU3G@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 February 2015 12:08:29 Iyappan Subramanian wrote:
> diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> index f1ad9c2..a857794 100644
> --- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
> +++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> @@ -622,7 +622,7 @@
>                 };
>  
>                 sgenet0: ethernet at 1f210000 {
> -                       compatible = "apm,xgene-enet";
> +                       compatible = "apm,xgene1-sgenet";
>                         status = "disabled";
>                         reg = <0x0 0x1f210000 0x0 0xd100>,
>                               <0x0 0x1f200000 0x0 0Xc300>,
> 

This will break booting the new dtb on older kernels, right?

You should normally list the most generic model in addition to the
specific one.

	Arnd
