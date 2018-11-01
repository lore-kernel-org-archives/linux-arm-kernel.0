From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 1 Nov 2018 12:56:42 -0300
Subject: [PATCH V3 09/10] dts: fsl: add imx7ulp evk support
In-Reply-To: <VI1PR04MB422242A027713CC447446D6780CE0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <1540996688-23681-1-git-send-email-aisheng.dong@nxp.com>
 <1540996688-23681-10-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5AZejEAHeB0hQ9T5U2ZJ7MXK=BYm8jY+yyZjbDHo4utGA@mail.gmail.com>
 <VI1PR04MB422242A027713CC447446D6780CE0@VI1PR04MB4222.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5BmqQE4wohBwE65f667cxF8LOcSJ=jECDXLADXbK9OEZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 1, 2018 at 12:49 PM A.s. Dong <aisheng.dong@nxp.com> wrote:

> This seems a bit confusing to me.
> That GPIO is used to control the SD card power on/off. So it's naturally a
> GPIO regulator. Looking at exist IMX dts, you will find all similar board doing
> like this. Pwrseq seems more like to be used for WiFi/eMMC card.
> Am I missed something?

As per the board schematics the name of the signal is SD0_nRST, where
RST means "reset".

There is even this note in the schematics: "ROM Code will reset the SD
power during boot up through SD_RST".

eMMC reset is better handled by 'reset-gpios' property from pwrseq.
