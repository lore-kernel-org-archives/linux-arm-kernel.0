From: linux.amoon@gmail.com (Anand Moon)
Date: Fri, 23 Nov 2018 15:32:07 +0530
Subject: [PATCHv2] ARM: dts: exynos: update the usbdrd_phy suspend clk
In-Reply-To: <CAJKOXPcphirR=+25evzVxHGv1g_4xNfPv3gazXWOes1G6iBt5g@mail.gmail.com>
References: <20181120185536.1159-1-linux.amoon@gmail.com>
 <CAJKOXPcphirR=+25evzVxHGv1g_4xNfPv3gazXWOes1G6iBt5g@mail.gmail.com>
Message-ID: <CANAwSgSQV9VKEXaVfh-bfg5FggiRiOX+v5crCBMSMpy6sQN=Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Thu, 22 Nov 2018 at 13:24, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, 20 Nov 2018 at 19:55, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > As per FSYS usbdrd_phy clk setting CLK_SCLK_USBD300/1 binds
> > to SUSPEND_CLK so correct update the suspend clk.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > [0] https://lkml.org/lkml/2017/10/6/12
> > changes from previous patch
> > fix the order of clk and update the commit message
> >
> > FSYS block show in user manual
> >
> > CLKMUX_USBDRD300/1----CLKDIV_USBDRD300/1----SCLK_USBDRD300/1-----SUSPEND_CLK
> >                    |
> >                    |--CLKDIV_USBPHY300/1----SCLK_USBPHY300/1-----USBDRD30_PHY_0/1
>
> Your new clock - SCLK_USBD301 - is not mentioned here. I don't get the
> reason behind this change.
>
> Best regards,
> Krzysztof
>

As far as I could figure your from fsys clk  structure

CLK_SCLK_USBD300/1              SUSPEND_CLK
CLK_SCLK_USBPHY300/1          PHY CLK
CLK_USBD300/1                        DWC3 CLK

I sill have some dough from the schematic of Odroid XU4
we have two clk *USB_CLK* and *RTC_CLK* which is not
configure and used.

Best Regards
-Anand
