From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Mar 2014 11:20:27 +0000
Subject: [PATCH 2/3] ARM: STi: stih416-b2020: Explicitly include STiH416
 Pinctrl bindings
In-Reply-To: <531EEADF.5060001@st.com>
References: <1394533324-20299-1-git-send-email-lee.jones@linaro.org>
 <1394533324-20299-2-git-send-email-lee.jones@linaro.org>
 <531EEADF.5060001@st.com>
Message-ID: <20140311112027.GD21216@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >At the moment we're relying on inheriting them from DTSI files which
> >we're including Ideally we should be specifying these for ourselves.
> >
> >Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >---
> >  arch/arm/boot/dts/stih416-b2020-revE.dts | 1 +
> >  1 file changed, 1 insertion(+)
> >
> >diff --git a/arch/arm/boot/dts/stih416-b2020-revE.dts b/arch/arm/boot/dts/stih416-b2020-revE.dts
> >index bcb9d00..4168b019 100644
> >--- a/arch/arm/boot/dts/stih416-b2020-revE.dts
> >+++ b/arch/arm/boot/dts/stih416-b2020-revE.dts
> >@@ -8,6 +8,7 @@
> >   */
> >  /dts-v1/;
> >  #include "stih416.dtsi"
> >+#include "stih416-pinctrl.dtsi"
> Isn't this file already included in stih416.dtsi?

It is, but it's being inherited. I'm unsure if the DT rules are
different, but in *.c files #includes should be added explicitly in
the file they are used.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
