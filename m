From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Sun, 11 Dec 2016 09:58:33 +0100
Subject: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21, i.MX27
 and i.MX31 SoCs
In-Reply-To: <20161211010648.6591-1-vz@mleia.com>
References: <20161211010648.6591-1-vz@mleia.com>
Message-ID: <CAM=E1R4Mr_QG1H9S8vriBvMRrWE8frYgQpXB2EZ=1d2U-pRaiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Excellent!

On 11 December 2016 at 02:06, Vladimir Zapolskiy <vz@mleia.com> wrote:
> Power down counter enable/disable bit switch is located in WMCR
> register, but watchdog controllers found on legacy i.MX21, i.MX27 and
> i.MX31 SoCs don't have this register. As a result of writing data to
> the non-existing register on driver probe the SoC hangs up, to fix the
> problem add more OF compatible strings and on this basis get
> information about availability of the WMCR register.
>
> Fixes: 5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on boot")
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---

Tested-by: Magnus Lilja <lilja.magnus@gmail.com>

(Tested on i.MX31 without device tree)

/Magnus
