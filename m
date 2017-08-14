From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 Aug 2017 15:22:07 +0800
Subject: [PATCH 1/3] bus: kconfig: Enable SUNXI RSB for arm64
In-Reply-To: <1502516443-4740-1-git-send-email-jteki@openedev.com>
References: <1502516443-4740-1-git-send-email-jteki@openedev.com>
Message-ID: <CAGb2v65zgxtLXPqvGFVAKwfbPJ8BauzmJNBTa=Gvw+JbAOFNTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 12, 2017 at 1:40 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
>
> Sunxi arm64 doesn't have separate configs for
> h5 and a64 so enable SUNXI_RSB bus for ARM64.

The commit message is missing a lot of details. It assumes the
reader knows about the A64 SoC and that it uses the RSB bus to
communicate with the PMIC.

Applied for 4.14 with the following commit message:

bus: sunxi-rsb: Enable by default for ARM64

Allwinner's A64 SoC uses the "Reduced Serial Bus" to communicate with
its companion PMIC.

Since arm64 does not have separate defconfigs for each platform or
processor family, enable this driver by default for ARM64 as well.
Note that the Kconfig symbol already depends on ARCH_SUNXI.

ChenYu

>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
