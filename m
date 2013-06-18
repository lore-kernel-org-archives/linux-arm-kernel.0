From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 18:16:26 +0200
Subject: [PATCH v3 10/12] ARM: mvebu: Relocate Armada 370/XP DeviceBus
 device tree nodes
In-Reply-To: <1371554737-25319-11-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371554737-25319-11-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <201306181816.26530.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Ezequiel Garcia wrote:
> 
> +               devbus-bootcs {
> +                       compatible = "marvell,mvebu-devbus";
> +                       reg = <0xffff0001 0x10400 0x8>;
> +                       ranges = <0 MBUS_ID(0x01, 0x2f) 0 0xffffffff>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       clocks = <&coreclk 0>;
> +                       status = "disabled";
> +               };

This is a violation of the binding as far as I can tell, since you don't specify ranges
to access the 0xffff0001 0x10400 address. However, as I explained in my comment for
the binding, I think you should clarify the binding and leave the implementation
as you have it here.

	Arnd
