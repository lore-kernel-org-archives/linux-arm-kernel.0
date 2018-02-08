From: robh@kernel.org (Rob Herring)
Date: Thu, 8 Feb 2018 14:21:36 -0600
Subject: [PATCH V3 2/2] thermal: imx: add i.MX7 thermal sensor support
In-Reply-To: <1517818347-7436-2-git-send-email-Anson.Huang@nxp.com>
References: <1517818347-7436-1-git-send-email-Anson.Huang@nxp.com>
 <1517818347-7436-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180208202136.rpghc2dpcd42zqvn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 05, 2018 at 04:12:27PM +0800, Anson Huang wrote:
> This patch adds i.MX7 thermal sensor support, most
> of the i.MX7 thermal sensor functions are same with
> i.MX6 except the registers offset/layout, so we move
> those registers offset/layout definitions to soc data
> structure.
> 
> i.MX7 uses single calibration data @25C, the calibration
> data is located at OCOTP offset 0x4F0, bit[17:9], the
> formula is as below:
> 
> Tmeas = (Nmeas - n1) + 25; n1 is the fuse value for 25C.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> ---
> changes since V2:
> 	Add bindind doc changes in this patch according to review comments.
>  .../devicetree/bindings/thermal/imx-thermal.txt    |   9 +-

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/thermal/imx_thermal.c                      | 314 ++++++++++++++++-----
>  2 files changed, 254 insertions(+), 69 deletions(-)
