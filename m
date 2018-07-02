From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 1 Jul 2018 22:00:21 -0300
Subject: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
In-Reply-To: <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
 <20180701093402.GN4348@dragon>
 <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
 <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
 <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5D8v4KM9S4ooHTDbA+vc8BZN_eO_wDuOPA+8Hcq-SmLDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Sun, Jul 1, 2018 at 9:57 PM, Anson Huang <anson.huang@nxp.com> wrote:

> Just want to know how to handle such case? The kernel patch will never
> be applied or is there any way to make kernel patch and dtb patch applied
> together to avoid any breakage?

We always want to avoid breaking a working dtb when it is used with a
newer kernel.

In this case we need to revert the kernel patch as it causes
regression with old dtbs.
