From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu, 12 Jul 2018 22:15:28 -0700
Subject: [PATCH 1/2] ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line
 pinumx config
In-Reply-To: <CAOMZO5DfHqKjF6xykJtoC-aA-ATWM6mCZR0VzPVpSDOt-Fs6bQ@mail.gmail.com>
References: <20180712023337.30112-1-andrew.smirnov@gmail.com>
 <20180712023337.30112-2-andrew.smirnov@gmail.com>
 <CAOMZO5DfHqKjF6xykJtoC-aA-ATWM6mCZR0VzPVpSDOt-Fs6bQ@mail.gmail.com>
Message-ID: <CAHQ1cqEXBfs1B6Jr1NvUY6WoyX9oG=0haJpiTLVH7t-37ht10Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2018 at 6:37 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Andrey,
>
> On Wed, Jul 11, 2018 at 11:33 PM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>
> > +       pinctrl_switch: switchgrp {
> > +               fsl,pins = <
> > +                       MX51_PAD_AUD3_BB_CK__GPIO4_20           0xc5
>
> The i.MX51 Reference Manual states that 0xa5 is the default reset
> value for the register IOMUXC_SW_PAD_CTL_PAD_AUD3_BB_CK.
>
> By reading your commit log I had the impression you wanted to provide
> the default value explicitly.
>
> Please clarify.

I wanted to avoid relying on defaults be it register reset values or
settings that bootloader left us with. Default value of 0xa5 works,
but, given how the pin is IRQ_TYPE_LEVEL_HIGH, I though it would be
better to configure it to have a pulldown. Do you want me to add that
to commit log?

Thanks,
Andrey Smirnov
