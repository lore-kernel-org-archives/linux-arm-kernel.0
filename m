From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 26 Apr 2018 14:24:26 -0300
Subject: [PATCH V4 3/6] ARM: dts: imx6sx-sabreauto: add IO expander
 max7310 support
In-Reply-To: <DB5PR04MB13205A0A7134C969748560B4F58E0@DB5PR04MB1320.eurprd04.prod.outlook.com>
References: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
 <1524634571-5914-3-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5Dm6rcEe=zAJ9_nqKce3g2tdyWPqb=Uv-N5nfc_96jc-g@mail.gmail.com>
 <AM3PR04MB13150654494B8D251988F76CF58E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AZLbUoL7FWgUFA7qc3q3wcz9UBLSQhMXXkUJeiRz8X4A@mail.gmail.com>
 <DB5PR04MB13205A0A7134C969748560B4F58E0@DB5PR04MB1320.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5DWeYCbWn9LEi1e+tc4gZsjBBpXtiwzmwLbYp=E4TERrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 3:31 AM, Anson Huang <anson.huang@nxp.com> wrote:

> I searched the mail I sent, I can NOT found where I said "MAX7310 controls the ethernet phy"....

Initially you passed:  pinctrl-assert-gpios = <&max7322 0
GPIO_ACTIVE_HIGH> inside the fec1 node.

Then I explained that 'pinctrl-assert-gpios' is not a valid property
in mainline. It only exists in NXP vendor tree.

Then you explained:

"Sorry, I made a mistake here, the MAX7320 IO0 is for adjusting FEC1's voltage"

> There are MAX7310 users, it is just because currently those users are NOT enabled, so I can
> NOT verify them. MAX7310 is an independent I2C device, why we can NOT enable it first?
> I tested it from sysfs interface, we can control the MAX7310's IO output via echo different value
> to GPIO value, that means MAX7310 itself as an IO expander chip is working just fine, similar with PMIC,
> it is a I2C device, can be enabled independently, then consumers can be added later when they are enabled.
> Just my personal opinion, thanks.

Right, but if FEC needs max7322 IO0 at level 1 then better describe it in dts.
