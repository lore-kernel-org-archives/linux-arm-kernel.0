From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 2 Jul 2018 20:14:49 -0300
Subject: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
In-Reply-To: <1530526335.15665.13.camel@nxp.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
 <20180701093402.GN4348@dragon>
 <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
 <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
 <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8v4KM9S4ooHTDbA+vc8BZN_eO_wDuOPA+8Hcq-SmLDw@mail.gmail.com>
 <AM3PR04MB1315C7C7CFF990615732FFBCF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AM5VRS7UiWuvAQ8vvTB8OM+iwofuYrbsL_yB9e0Z9Kyg@mail.gmail.com>
 <AM3PR04MB13155B8D567ABEF7EF03249AF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5BdtxKjQge5ONpnjr1yNVeTJf4u8Gh-fPqpHz7G9ipOTg@mail.gmail.com>
 <1530526335.15665.13.camel@nxp.com>
Message-ID: <CAOMZO5AxsvOhWi47goBm7YuqiLEhZ5fgK4BtCqg_hyLtdWfqfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Sun, Jul 1, 2018 at 11:12 PM, Robin Gong <yibin.gong@nxp.com> wrote:

> But in fact, the original dts is not correct without 'regulator-always-
> on'since SW4 is the critical DDR power rail, although, it's kept on in
> the previous kernel by no switches enable/disable interfaces provided
> in pfuze driver. Adding new property which can be done totally by the
> common 'regulator-always-on' is not a good choice. Keep the dts patch
> adding 'regulator-always-on' ahead of pfuze driver pach adding
> enable/disable interface is enough for such case I think.

We really want to avoid  breaking old dtb's running a new kernel.
