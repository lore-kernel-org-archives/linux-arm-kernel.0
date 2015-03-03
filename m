From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 00:29:19 +0100
Subject: [PATCH] ARM: i.MX6Q: Add fixup for RTL8211E Gigabit Ethernet PHY
In-Reply-To: <1425404579-30591-1-git-send-email-rockford@yandex.ru>
References: <1425404579-30591-1-git-send-email-rockford@yandex.ru>
Message-ID: <3988965.hS0GXm2TNL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 March 2015 20:42:59 Andrey Panov wrote:
> +static int rtl8211e_phy_fixup(struct phy_device *dev)
> +{
> +       phy_write(dev, 0x00, 0x3140);
> +       mdelay(10);
> +       phy_write(dev, 0x00, 0x3340);
> +       mdelay(10);
> +
> +       return 0;
> +}
> 

mdelay(10) is rather evil, can you use msleep(10) here instead?

> +               phy_register_fixup_for_uid(PHY_ID_RTL8211E, 0xffffffff,
> +                               rtl8211e_phy_fixup);

How do you ensure that this fixup is only applied on the boards that need
it, rather than all machines that happen to have this phy?

	Arnd
