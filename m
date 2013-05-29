From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 May 2013 16:27:20 +0200
Subject: [PATCH V3 3/3] ARM: mmc: bcm281xx SDHCI driver (dt mods)
In-Reply-To: <1369790016-13270-3-git-send-email-csd@broadcom.com>
References: <1369790016-13270-1-git-send-email-csd@broadcom.com>
 <1369790016-13270-3-git-send-email-csd@broadcom.com>
Message-ID: <201305291627.20984.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 May 2013, Christian Daudt wrote:
> +       sdio0: sdio at 0x3f180000 {
> +               max-frequency = <48000000>;
> +               status = "okay";
> +       };
> +

On a general note, there is no need to duplicate both the label and the
name here, one of the two is enough. The easiest way to write this
in a board file is

&sdio {
	max-frequency = <48000000>;
	status = "okay";
};

Your version is not wrong though, so

Acked-by: Arnd Bergmann <arnd@arndb.de>
