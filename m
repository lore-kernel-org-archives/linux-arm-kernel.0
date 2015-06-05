From: lznuaa@gmail.com (Zhi Li)
Date: Fri, 5 Jun 2015 11:38:31 -0500
Subject: [PATCH v2 1/2] watchdog: imx2_wdt: add external reset support via
 'ext-reset-output' dt prop
In-Reply-To: <1433448960-9257-2-git-send-email-tharvey@gateworks.com>
References: <1432853677-5150-1-git-send-email-tharvey@gateworks.com>
 <1433448960-9257-1-git-send-email-tharvey@gateworks.com>
 <1433448960-9257-2-git-send-email-tharvey@gateworks.com>
Message-ID: <CAHrpEqRPGkVh5XKUVxSMH7NrHv0v2P5i30zCdAJ4-h=zhJP_TQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 4, 2015 at 3:15 PM, Tim Harvey <tharvey@gateworks.com> wrote:
> +       /* Generate internal chip-level reset if WDOG times out */
> +       if (!wdev->ext_reset)
> +               val &= ~IMX2_WDT_WCR_WRE;
> +       /* Or if external-reset assert WDOG_B reset only on time-out */
> +       else
> +               val |= IMX2_WDT_WCR_WRE;

I think you can always enable IMX2_WDT_WCR_WRE.
So needn't ext_reset.

If you don't config WDOG_B pin mux,  WDOG_B do nothing.

best regards
Frank Li
