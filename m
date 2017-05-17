From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 17 May 2017 15:02:28 -0300
Subject: imx7: mmc_select_hs200 failed, error -74
In-Reply-To: <AM4PR0401MB232411A003DC9F9D2F9CAEA490E70@AM4PR0401MB2324.eurprd04.prod.outlook.com>
References: <CAOMZO5ByTR1C4qUdc+hBcGTFVf-NH2gS5PmH3=w5-TrAoDQVUA@mail.gmail.com>
 <CAOMZO5AXb3-YGc7hGRP_OY8C-Go0pBECbDoQo1SUB1i=t1Xi4w@mail.gmail.com>
 <AM4PR0401MB232411A003DC9F9D2F9CAEA490E70@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5BeE_Lm+VM8d9TKv0b21cL6dVNYgBai3wBjjm=bssXWCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haibo,

On Tue, May 16, 2017 at 11:10 PM, Bough Chen <haibo.chen@nxp.com> wrote:

> Hi Fabio,
>
> Can you open the mmc debug and show the full log?
> By the way, you should first make sure whether the eMMC chip you used support HS200, and double
> check whether the vccq voltage is 1.8v or 1.2v, HS200 mode can't work on 3.3v I/O voltage.

The imx7s warp board supplies 3.15V to VCCQ eMMC pins, so it cannot
work in HS200 mode as you said.

In this case it should still be able to work in DDR52 mode though.

Please see the patch I sent:
http://marc.info/?l=linux-mmc&m=149495763808805&w=2
