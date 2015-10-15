From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 16:18:39 +0200
Subject: [PATCH v3 09/12] dts/ls2080a: Update Simulator DTS to add support
 of various peripherals
In-Reply-To: <1444891672-32117-10-git-send-email-bhupesh.sharma@freescale.com>
References: <1444891672-32117-1-git-send-email-bhupesh.sharma@freescale.com>
 <1444891672-32117-10-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <6141791.soHsjI1RN1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 12:17:49 Bhupesh Sharma wrote:
> +
> +&esdhc {
> +       status = "disabled";
> +};
> +
> +&ifc {
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       status = "disabled";
> +};
> +
> +&i2c1 {
> +       status = "disabled";
> +};
> +
> +&i2c2 {
> +       status = "disabled";
> +};

The more common way to do this is to turn off all optional HW blocks in the
.dtsi file and then overide the ones that are connected on a particular board
by overriding the status to "ok" there.

	Arnd
