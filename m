From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Jan 2014 20:20:28 -0200
Subject: imx6 wand board lockdep warnings on boot
In-Reply-To: <CAGa+x84Oko25r+xE_Z3wrY_dVCrMcF5AKvbBBMcbyvAMTOSoqg@mail.gmail.com>
References: <CAGa+x84Oko25r+xE_Z3wrY_dVCrMcF5AKvbBBMcbyvAMTOSoqg@mail.gmail.com>
Message-ID: <CAOMZO5DpuDnEnoNm5pbyQnU0Hd37Lkc5Q4H0VCFNM0mKf7nMZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 7:52 PM, Kevin Hilman <khilman@linaro.org> wrote:
> For awhile now, the wand boards have had some noisy lockdep warnings
> during boot, but I'm not sure if anyone is looking into them.  I see
> it on the wand-solo and wand-quad, but not the dual.  Full boot logs
> for all three are attached from v3.13.

This has been fixed by this commit:

commit a974862faee199cba3ff36b5a148df5fd34bd1e7
Author: Dong Aisheng <b29396@freescale.com>
Date:   Thu Dec 26 15:23:53 2013 +0800

    mmc: sdhci-esdhc-imx: fix access hardirq-unsafe lock in atomic context

,which is in Linus' tree now.

It is also marked as 3.13 stable.

Regards,

Fabio Estevam
