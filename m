From: lukma@denx.de (Lukasz Majewski)
Date: Mon, 6 Mar 2017 17:01:51 +0100
Subject: [PATCH 2/5] ARM: dts: am335x-boneblack: Enable 1GHz OPP for cpu
In-Reply-To: <1488813822-26042-3-git-send-email-d-gerlach@ti.com>
References: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
 <1488813822-26042-3-git-send-email-d-gerlach@ti.com>
Message-ID: <20170306170151.0bb30576@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Mar 2017 09:23:39 -0600
Dave Gerlach <d-gerlach@ti.com> wrote:

> Although all PG2.0 silicon may not support 1GHz OPP for the MPU, older
> Beaglebone Blacks may have PG2.0 silicon populated and these
> particular parts are guaranteed to support the OPP, so enable it for
> PG2.0 on am335x-boneblack only.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Reviewed-by: Lukasz Majewski <lukma@denx.de>

> ---
>  arch/arm/boot/dts/am335x-boneblack.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts
> b/arch/arm/boot/dts/am335x-boneblack.dts index
> 77273df1a028..935ed17d22e4 100644 ---
> a/arch/arm/boot/dts/am335x-boneblack.dts +++
> b/arch/arm/boot/dts/am335x-boneblack.dts @@ -15,3 +15,14 @@
>  	model = "TI AM335x BeagleBone Black";
>  	compatible = "ti,am335x-bone-black", "ti,am335x-bone",
> "ti,am33xx"; };
> +
> +&cpu0_opp_table {
> +	/*
> +	 * All PG 2.0 silicon may not support 1GHz but some of the
> early
> +	 * BeagleBone Blacks have PG 2.0 silicon which is guaranteed
> +	 * to support 1GHz OPP so enable it for PG 2.0 on this board.
> +	 */
> +	oppnitro at 1000000000 {
> +		opp-supported-hw = <0x06 0x0100>;
> +	};
> +};




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
