From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 8 Jan 2014 10:03:26 -0200
Subject: [PATCH 1/2] Revert "ARM: dts: imx: use dual-fifo sdma script for
 ssi"
In-Reply-To: <1389170756-22351-2-git-send-email-Guangyu.Chen@freescale.com>
References: <1389170756-22351-1-git-send-email-Guangyu.Chen@freescale.com>
 <1389170756-22351-2-git-send-email-Guangyu.Chen@freescale.com>
Message-ID: <CAOMZO5BXssO2BaV01Hn6hWaEP+k8_Bp7NPUKDbJ8-yuG8Eo41Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 8, 2014 at 6:45 AM, Nicolin Chen <Guangyu.Chen@freescale.com> wrote:
> This reverts commit b1d27c79c8377df1880447375deffa3bb82c7bd3.
>
> Previously we switched the SSI scriprt to dual-fifo mode to reduce playback
> underrun issue, which is only included by SDMA firmware version 2. However,
> there are quite a lot people still using version 1 or default firmware in
> the ROM code of SoC while these two kinds of firmwares do not support the
> dual-fifo script and the audio function on their platform would be broken.
>
> Thus this patch provisionally reverts the dual-fifo script to the original
> single fifo script to meet all kinds of users' requirements, including the
> version 1/2 or inner ROM firmware.
>
> Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
> Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>

Thanks, Nicolin.

This fixes audio playback without additional SDMA firmware:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
