From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 20 Dec 2013 22:08:38 +0100
Subject: [PATCH] ARM: dts: add clock provider for mshc node for Exynos4412
 SOC
In-Reply-To: <52B4AC28.3070404@samsung.com>
References: <1358764755-21470-1-git-send-email-thomas.abraham@linaro.org>
 <000201cefd7f$d8b7c840$8a2758c0$%jun@samsung.com>
 <52B4AC28.3070404@samsung.com>
Message-ID: <1610394.o1Af0FOyXz@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Saturday 21 of December 2013 05:44:24 Kukjin Kim wrote:
> On 12/20/13 21:34, Seungwon Jeon wrote:
> > Clock lookup information is required as driver can manipulate
> > clock rate properly.
> >
> > Signed-off-by: Seungwon Jeon<tgih.jun@samsung.com>
> > ---
> >   arch/arm/boot/dts/exynos4412.dtsi |    2 ++
> >   1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> > index ec1b166..9cbe59a 100644
> > --- a/arch/arm/boot/dts/exynos4412.dtsi
> > +++ b/arch/arm/boot/dts/exynos4412.dtsi
> > @@ -41,5 +41,7 @@
> >   		interrupts =<0 77 0>;
> >   		#address-cells =<1>;
> >   		#size-cells =<0>;
> > +		clocks =<&clock 301>,<&clock 149>;
> > +		clock-name = "biu", "ciu";
> >   	};
> >   };
> 
> Applied, thanks.

I'm afraid you should not have applied this patch. More than this is
needed for correct support of DW-MSHC on Exynos 4x12 and I already
posted a series doing so more than a week ago.

Please refer to this thread:
http://thread.gmane.org/gmane.linux.kernel.samsung-soc/25493

Best regards,
Tomasz
