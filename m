From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Jan 2014 14:44:24 +0100
Subject: [PATCH v4 2/3] ARM: mvebu: Add quirk for i2c
In-Reply-To: <52CD55D5.6020703@free-electrons.com>
References: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com>
 <201401081352.57361.arnd@arndb.de> <52CD55D5.6020703@free-electrons.com>
Message-ID: <5524929.csF5lYbH6h@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 January 2014 14:42:45 Gregory CLEMENT wrote:
> You means something like the following code ?
> 
> static void __init armada_370_xp_dt_init(void)
>  {
> +       if (of_machine_is_compatible("plathome,openblocks-ax3-4"))
> +               i2c_quirk();
>         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }

Yes, that looks like a good way to do it.

	Arnd
