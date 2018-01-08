From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Mon, 8 Jan 2018 17:48:55 +0100
Subject: [PATCH v2 1/5] pinctrl: imx: use struct imx_pinctrl_soc_info as
 a const
In-Reply-To: <20180106142553.15322-2-stefan@agner.ch>
References: <20180106142553.15322-1-stefan@agner.ch>
 <20180106142553.15322-2-stefan@agner.ch>
Message-ID: <20180108164855.GA6504@t450s.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Sat, Jan 06, 2018 at 03:25:49PM +0100, Stefan Agner wrote:
> For some SoCs the struct imx_pinctrl_soc_info is passed through
> of_device_id.data which is const. Most variables are already const
> or otherwise not written. However, some fields are modified at
> runtime. Move those fields to the dynamically allocated struct
> imx_pinctrl.
> 
> Fixes: b3060044e495 ("pinctrl: freescale: imx7d: make of_device_ids const")
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Cc: Gary Bisson <gary.bisson@boundarydevices.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

This is actually more or less a revert of a previous commit:
b28742be4709 pinctrl: imx: remove const qualifier of imx_pinctrl_soc_info

Note that the idea for this commit was to get dt-overlays working and
able to do pinctrl changes using configfs interface to load an overlay
(using Pantelis patch). Not sure where we stand on loading such overlay
from user-space, is it still something that will happen?

Regards,
Gary
