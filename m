From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 12 Jun 2014 15:17:56 -0600
Subject: [PATCH 1/2] ARM: tegra: tamonten: add the base board regulators
In-Reply-To: <1402585885-28247-1-git-send-email-alban.bedel@avionic-design.de>
References: <1402585885-28247-1-git-send-email-alban.bedel@avionic-design.de>
Message-ID: <539A1904.2000601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2014 09:11 AM, Alban Bedel wrote:
> Currently the Tamonten DTS define a fixed regulator for the 5V supply.
> However this regulator is in fact on the base board. Fix this by
> properly defining the regulators found on the base boards.

> diff --git a/arch/arm/boot/dts/tegra20-medcom-wide.dts b/arch/arm/boot/dts/tegra20-medcom-wide.dts

> +	board_regulators {

The name "board_regulators" encodes both type ("regulators") and
identify ("board": the regulators on the board). DT node names are
suposed to contain type but not identity information.

The way this is done in other Tegra DTs is to have a regulators node in
both the board and module DT files, and use different ranges of reg
values for the board and module; e.g. 0..99 for module and 100.. for the
board or similar.

Other than that, this patch looks fine.
