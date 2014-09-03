From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Sep 2014 13:14:54 +0200
Subject: [PATCH v4 1/4] ethernet: arc: Add support for Rockchip SoC layer
 device tree bindings
In-Reply-To: <1409740036-8117-1-git-send-email-romain.perier@gmail.com>
References: <1409740036-8117-1-git-send-email-romain.perier@gmail.com>
Message-ID: <3774938.44qiV4hEoE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 10:27:13 Romain Perier wrote:
> +static const struct emac_rockchip_soc_data emac_rockchip_dt_data[] = {
> +       { .grf_offset = 0x154 }, /* rk3066 */
> +       { .grf_offset = 0x0a4 }, /* rk3188 */
> +};
> +
> +static const struct of_device_id emac_rockchip_dt_ids[] = {
> +       { .compatible = "rockchip,rk3066-emac", .data = &emac_rockchip_dt_data[0] },
> +       { .compatible = "rockchip,rk3188-emac", .data = &emac_rockchip_dt_data[1] },
> +       { /* Sentinel */ }
> +};
> +
> 

One last question: is this the location given as .grf_offset the
only thing in grf that is potentially of concern to this driver?

If it is, you can change the binding to include the register number
in the syscon reference, like

	rockchip,grf = <&grf 0x154>;

and then read it from there, to simplify the code needed to get the
number from the device id.

	Arnd
