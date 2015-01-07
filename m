From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 7 Jan 2015 14:26:04 -0200
Subject: [PATCH 1/3] ARM: imx6: Mask mmdc_ch1 handshake for periph2_sel
 and mmdc_ch1_axi_podf
In-Reply-To: <1420559265-7333-1-git-send-email-p.zabel@pengutronix.de>
References: <1420559265-7333-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <CAOMZO5A9rzuR8axX0O05w1aqfTZhHaL3j+1KTgUiarFOoP8qYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Tue, Jan 6, 2015 at 1:47 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> MMDC CH1 is not used on i.MX6Q, so the handshake needed to change the parent
> of periph2_sel or the divider of mmdc_ch1_axi_podf will never succeed.
> Disable the handshake mechanism to allow changing the frequency of mmdc_ch1_axi,
> allowing to use it as a possible source for the LDB DI clock.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks for working on this series. It looks great.

I am adding Christian on Cc as he could reproduce the bug quickly on
his setup. Maybe he could give his Tested-by?

On my board it takes a long time to reproduce the ldb clock lock-up issue.

Thanks
