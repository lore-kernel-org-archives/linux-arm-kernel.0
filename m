From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 8 Jan 2014 10:03:51 -0200
Subject: [PATCH 2/2] dma: imx-sdma: Assign a default script number for ROM
 firmware cases
In-Reply-To: <1389170756-22351-3-git-send-email-Guangyu.Chen@freescale.com>
References: <1389170756-22351-1-git-send-email-Guangyu.Chen@freescale.com>
 <1389170756-22351-3-git-send-email-Guangyu.Chen@freescale.com>
Message-ID: <CAOMZO5AY1RaxFUcO0r7=Db8Hp_U6oPHSDke0Y0thhEKi5OGCdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 8, 2014 at 6:45 AM, Nicolin Chen <Guangyu.Chen@freescale.com> wrote:
> i.MX series have inner firmware in its ROM code: when SDMA isn't provided
> any firmware from Kernel or rootfs, the default inner ROM firmware will be
> activated. However the current driver doesn't assign any script number to
> this situation, and those platform running in this case would be broken.
>
> Thus this patch adds a default script number when no external firmware being
> loaded so that people would continue to be able to use basic scripts to run
> their platform without any firmware.
>
> Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
> Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>

Thanks, Nicolin.

This fixes audio playback without additional SDMA firmware:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
