From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Sep 2014 12:41:01 +0200
Subject: [PATCH v3 5/8] arm64: dts: Add initial device tree support for
 EXYNOS7
In-Reply-To: <1410430852-3491-6-git-send-email-ch.naveen@samsung.com>
References: <1410430852-3491-1-git-send-email-ch.naveen@samsung.com>
 <1410430852-3491-6-git-send-email-ch.naveen@samsung.com>
Message-ID: <27455049.omNFrla0xU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 September 2014 15:50:49 Naveen Krishna Chatradhi wrote:
> +       aliases {
> +               serial0 = &serial_0;
> +               serial1 = &serial_1;
> +               serial2 = &serial_2;
> +               serial3 = &serial_3;
> +       };
> +

Please move the aliases from the exynos7.dtsi file into the
exynos7-espresso.dts file, and only list the ones that are
present, starting with alias 0, like

	aliases {
		serial0 = &serial_2;
	};

If the machine has only one serial port, it should be the first
alias.

	Arnd
