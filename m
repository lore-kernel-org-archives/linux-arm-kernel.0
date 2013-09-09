From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 9 Sep 2013 14:20:09 +0200
Subject: [PATCHv3 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <1378454907-22728-2-git-send-email-Li.Xiubo@freescale.com>
References: <1378454907-22728-1-git-send-email-Li.Xiubo@freescale.com>
 <1378454907-22728-2-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20130909122008.GC22197@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 06, 2013 at 04:08:24PM +0800, Xiubo Li wrote:
> The FTM PWM device can be found on Vybrid VF610 Tower and Layerscape LS-1 SoCs.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
>  drivers/pwm/Kconfig       |  10 +
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-fsl-ftm.c | 505 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 516 insertions(+)
>  create mode 100644 drivers/pwm/pwm-fsl-ftm.c

This looks pretty good to me. I noticed that you didn't Cc Sascha who
commented on this a lot. Can you please resend with him Cc'ed to make
sure he sees this version of the series?

One thing jumped out at me, so I've commented on it below, but I will go
over the patch more carefully after you resend.

[...]
> diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
[...]
> +static int fsl_counter_clock_enable(struct fsl_pwm_chip *fpc)
> +{
[...]
> +	switch (fpc->counter_clk_select) {
> +	case FSL_COUNTER_CLK_SYS:
> +		reg |= FTMSC_CLKSYS;
> +		break;
> +	case FSL_COUNTER_CLK_FIX:
> +		reg |= FTMSC_CLKFIX;
> +		break;
> +	case FSL_COUNTER_CLK_EXT:
> +		ret |= FTMSC_CLKEXT;

s/ret/reg/

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130909/708ca3ac/attachment.sig>
