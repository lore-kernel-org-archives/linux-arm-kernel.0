From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 20 Jun 2011 09:43:13 -0300
Subject: [PATCH] ARM: mach-imx/mx31_3ds: Fix IOMUX for SPI1 signals
In-Reply-To: <20110620072658.GQ23771@pengutronix.de>
References: <1308242572-5158-1-git-send-email-fabio.estevam@freescale.com>
	<20110620072658.GQ23771@pengutronix.de>
Message-ID: <BANLkTikeJ2vB1YW4+P0cgcLsAy7hP2Yc1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Jun 20, 2011 at 4:26 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Thu, Jun 16, 2011 at 01:42:52PM -0300, Fabio Estevam wrote:
>> The LCD on the mx31_3ds board is connected to CSPI1.
>
> From the description I would say you remove exactly the setup we want
> instead of adding it. Can you explain a bit more?

Sure, the original code was assuming that the CSPI1 pins on the
MX31PDK were the primary pin function, which is incorrect.

On MX31PDK board these are the pins that provide CSPI1 functionality:

DSR_DCE1 (ALT mode 1) --> CSPI1_CLK
RI_DCE1 (ALT mode 1) --> CSPI1_RDY

DTR_DTE1  -->CSI1_MOSI
DSR_DTE1 --> CSPI1_MISO
DTR_DCE2 ---> CSPI1_SS2

The 3 IOMUX settings above are done via GPR as per Table A-1 of the MX31RM.

So the patch I sent fixes the CSPI1 IOMUX and makes the LCD to be functional.

I think we haven't seen this before because probably Redboot was doing
the IOMUX for us. After I switched to U-boot I was not able to get the
LCD to work and now with this patch it is working fine. FSL BSP also
does the IOMUX in the same way.

If you prefer I can post a v2 of this patch with a better explanation
on the commit message.

Regards,

Fabio Estevam
