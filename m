From: cphealy@gmail.com (Chris Healy)
Date: Wed, 20 Jun 2018 21:22:20 -0700
Subject: [PATCH v4] ARM: dts: imx51-zii-rdu1: fix touchscreen pinctrl
In-Reply-To: <20180620203500.28309-1-nick@shmanahar.org>
References: <CAOMZO5BTMRJmrjM7X3-7Qi1wuciOnLZhAUuWN27Dtoc0cZXVSA@mail.gmail.com>
 <20180620203500.28309-1-nick@shmanahar.org>
Message-ID: <CAFXsbZr-HJE54c0BC5=d1tStByA5ytGhSSZMirNKE03JzGCDXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 1:35 PM, Nick Dyer <nick@shmanahar.org> wrote:
> The pinctrl settings were incorrect for the touchscreen interrupt line, causing
> an interrupt storm. This change has been tested with both the atmel_mxt_ts and
> RMI4 drivers on the RDU1 units.
>
> The value 0x4 comes from the value of register IOMUXC_SW_PAD_CTL_PAD_CSI1_D8
> from the old vendor kernel.
>
> Signed-off-by: Nick Dyer <nick@shmanahar.org>
> Fixes: ceef0396f367 ("ARM: dts: imx: add ZII RDU1 board")
> Cc: <stable@vger.kernel.org> # 4.15+
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Changes in v4:
> - Add reviewed by Fabio
> Changes in v3:
> - Update commit message to add source of 0x4 value, fixes tag and CC stable
> Changes in v2:
> - Use hex, only alter IRQ line config

Tested on an RDU1 with Synaptics touchscreen successfully.  No
interrupt store any longer...

Tested-by: Chris Healy <cphealy@gmail.com>
