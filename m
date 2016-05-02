From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 May 2016 15:36:08 +0200
Subject: [PATCH v2 1/2] pinctrl: ns2: add pinmux driver support for
 Broadcom NS2 SoC
In-Reply-To: <1461934299-14774-2-git-send-email-yendapally.reddy@broadcom.com>
References: <1461934299-14774-1-git-send-email-yendapally.reddy@broadcom.com>
 <1461934299-14774-2-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <7673779.BeEs3iufq4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 April 2016 08:51:38 Yendapally Reddy Dhananjaya Reddy wrote:
> +static struct pinctrl_ops ns2_pinctrl_ops = {
> +       .get_groups_count = ns2_get_groups_count,
> +       .get_group_name = ns2_get_group_name,
> +       .get_group_pins = ns2_get_group_pins,
> +       .pin_dbg_show = ns2_pin_dbg_show,
> +       .dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
> +       .dt_free_map = pinctrl_utils_dt_free_map,
> +};
> +

This does not build:

drivers/pinctrl/bcm/pinctrl-ns2-mux.c:540:17: error: 'pinctrl_utils_dt_free_map' undeclared here (not in a function)
  .dt_free_map = pinctrl_utils_dt_free_map,
                 ^~~~~~~~~~~~~~~~~~~~~~~~~

Apparently this function got renamed to pinctrl_utils_free_map

	Arnd
