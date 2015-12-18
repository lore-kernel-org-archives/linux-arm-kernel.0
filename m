From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Dec 2015 22:44:28 +0100
Subject: [PATCH 3/3] arm: dts: bcm5301x: Add syscon based reboot in DT
In-Reply-To: <1450474676-10210-3-git-send-email-jonmason@broadcom.com>
References: <1450474676-10210-1-git-send-email-jonmason@broadcom.com>
 <1450474676-10210-3-git-send-email-jonmason@broadcom.com>
Message-ID: <2180042.V6T2Tnxp6B@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 December 2015 16:37:56 Jon Mason wrote:
> +       cru: cru at 1800c184 {
> +               compatible = "syscon";
> +               reg = <0x1800c184 0xc>;
> +       };

It's unusual for a device to start at such an odd address. Are you sure
it's not a larger device starting at 0x1800c000 or 0x18000000?

Also, please provide a more specific compatible string based on the
name of the device in the data sheet. The node name in contrast should
be more generic, e.g.

	cru: system-controller at 1800c000 {
		compatible = "brcm,bcm53010-cru", "syscon";
		reg = <0x1800c000 0x400>; /* whatever the data sheet says */
	};


	Arnd
