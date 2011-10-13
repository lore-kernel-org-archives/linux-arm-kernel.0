From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 13 Oct 2011 08:55:22 -0700
Subject: [PATCH] ARM: tegra: update defconfig
In-Reply-To: <1318478219-9462-1-git-send-email-olof@lixom.net>
References: <1318478219-9462-1-git-send-email-olof@lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173BE1A05A@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Wednesday, October 12, 2011 9:57 PM:
> Refresh tegra_defconfig:
> 
> New options enabled: RTC, SPI, USB and USB_STORAGE together with
> corresponding tegra drivers. Also enable some of the common usb ethernet
> adapters.
> 
> Finally, enable new merged boards (Ventana) and the generic devicetree board.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

This transitively enables USE_OF by default. For Tegra, that's a good
thing. However, it does mean we won't be able to detect code that only
compiles with USE_OF enabled, which might affect other platform's
buildability if we're talking about core code. I'm not sure if we should
be concerned about this or not, or if ARM should select USE_OF now?

-- 
nvpublic
