From: olof@lixom.net (Olof Johansson)
Date: Fri, 19 May 2017 00:00:37 -0700
Subject: [PATCH 2/2] arm64: defconfig: enable options needed for QCom
 DB410c board
In-Reply-To: <CAL_JsqK3jkQawSLigy1hMDTc5M6VSSsUomjMom-WFSKtWJzjsQ@mail.gmail.com>
References: <20170517215230.15108-1-robh@kernel.org>
 <20170517215230.15108-2-robh@kernel.org>
 <CAL_JsqK3jkQawSLigy1hMDTc5M6VSSsUomjMom-WFSKtWJzjsQ@mail.gmail.com>
Message-ID: <20170519070037.GD9628@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 08:01:53AM -0500, Rob Herring wrote:
> On Wed, May 17, 2017 at 4:52 PM, Rob Herring <robh@kernel.org> wrote:
> > Enable Qualcomm drivers needed to boot Dragonboard 410c with HDMI. This
> > enables support for clocks, regulators, and USB PHY.
> >
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: John Stultz <john.stultz@linaro.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  arch/arm64/configs/defconfig | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index d916fc316698..5b94e3d24c16 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -303,6 +303,7 @@ CONFIG_MFD_CROS_EC_I2C=y
> >  CONFIG_MFD_EXYNOS_LPASS=m
> >  CONFIG_MFD_HI655X_PMIC=y
> >  CONFIG_MFD_MAX77620=y
> > +CONFIG_MFD_QCOM_RPM=y
> 
> According to Bjorn, this one is for 8064, so this hunk can be dropped.

That made the clk and regulator controllers drop out of the refreshed
defconfig too, since dependencies aren't met. Seems like the correct thing.


-Olof
