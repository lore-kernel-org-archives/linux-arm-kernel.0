From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 25 Jun 2015 16:22:22 -0700
Subject: [PATCH v2 1/2] watchdog: imx2_wdt: add external reset support via
 'ext-reset-output' dt prop
In-Reply-To: <CAHrpEqRPGkVh5XKUVxSMH7NrHv0v2P5i30zCdAJ4-h=zhJP_TQ@mail.gmail.com>
References: <1432853677-5150-1-git-send-email-tharvey@gateworks.com>
 <1433448960-9257-1-git-send-email-tharvey@gateworks.com>
 <1433448960-9257-2-git-send-email-tharvey@gateworks.com>
 <CAHrpEqRPGkVh5XKUVxSMH7NrHv0v2P5i30zCdAJ4-h=zhJP_TQ@mail.gmail.com>
Message-ID: <CAJ+vNU2HvGy3_1fkzFnkMr1L8B7cAfJ+M3bVMfiG+hYW1EvPzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 5, 2015 at 9:38 AM, Zhi Li <lznuaa@gmail.com> wrote:
> On Thu, Jun 4, 2015 at 3:15 PM, Tim Harvey <tharvey@gateworks.com> wrote:
>> +       /* Generate internal chip-level reset if WDOG times out */
>> +       if (!wdev->ext_reset)
>> +               val &= ~IMX2_WDT_WCR_WRE;
>> +       /* Or if external-reset assert WDOG_B reset only on time-out */
>> +       else
>> +               val |= IMX2_WDT_WCR_WRE;
>
> I think you can always enable IMX2_WDT_WCR_WRE.
> So needn't ext_reset.
>
> If you don't config WDOG_B pin mux,  WDOG_B do nothing.
>
> best regards
> Frank Li

Frank,

No - If you generate both an IMX6 internal reset and an external
reset, the external reset signal is released immediately after the
IMX6 goes into reset which may be too quick for whatever hardware you
have that routed to.

Tim
