From: jangra.pankaj9@gmail.com (Pankaj Jangra)
Date: Wed, 26 Sep 2012 23:33:30 +0530
Subject: [PATCH 09/10] ARM: msm: Make proc_comm clock control into a
 platform driver
In-Reply-To: <1348194419-11486-10-git-send-email-sboyd@codeaurora.org>
References: <1348194419-11486-1-git-send-email-sboyd@codeaurora.org>
 <1348194419-11486-10-git-send-email-sboyd@codeaurora.org>
Message-ID: <CADTbHxoNdmAWaZ1dDYz_8zFr6xDxp8NYHPGF_WjYbeTWLmuMQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Its good  you started moving the msm to common clock framework.:)
I hope msm's codeaurora tree will also be moved to CCF soon. :)

On Fri, Sep 21, 2012 at 7:56 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> To move closer to the generic struct clock framework move the
> proc_comm based clock code to a platform driver. The data
> describing the struct clks still live in the devices-$ARCH file,
> but the clock initialization is done at driver binding time.
>
> Cc: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
Reviewed-by: Pankaj Jangra<jangra.pankaj9@gmail.com>

>  arch/arm/mach-msm/board-halibut.c      |  2 +-
>  arch/arm/mach-msm/board-msm7x30.c      |  2 +-
>  arch/arm/mach-msm/board-qsd8x50.c      |  2 +-
>  arch/arm/mach-msm/board-trout.c        |  3 +--
>  arch/arm/mach-msm/clock-pcom.c         | 23 +++++++++++++++++++++--
>  arch/arm/mach-msm/clock-pcom.h         |  5 +++++
>  arch/arm/mach-msm/clock.c              |  2 +-
>  arch/arm/mach-msm/clock.h              |  3 +++
>  arch/arm/mach-msm/devices-msm7x00.c    | 12 ++++++++++--
>  arch/arm/mach-msm/devices-msm7x30.c    | 11 +++++++++--
>  arch/arm/mach-msm/devices-qsd8x50.c    | 11 +++++++++--
>  arch/arm/mach-msm/devices.h            | 15 +++------------
>  arch/arm/mach-msm/include/mach/board.h |  5 -----
>  13 files changed, 65 insertions(+), 31 deletions(-)
>
> diff --git a/arch/arm/mach-msm/board-halibut.c b/arch/arm/mach-msm/board-halibut.c
> index 6ce542e..3c8cfe4 100644
> --- a/arch/arm/mach-msm/board-halibut.c
> +++ b/arch/arm/mach-msm/board-halibut.c
> @@ -59,6 +59,7 @@ static struct platform_device smc91x_device = {
>  };

> +
> +static int __devinit msm_clock_pcom_probe(struct platform_device *pdev)
> +{
> +       struct pcom_clk_pdata *pdata = pdev->dev.platform_data;

Should'nt it be const struct?

> +       msm_clock_init(pdata->lookup, pdata->num_lookups);
> +       return 0;
> +}
> +
--
Pankaj Jangra
