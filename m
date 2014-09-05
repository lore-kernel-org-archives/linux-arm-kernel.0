From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 4 Sep 2014 22:26:08 -0300
Subject: [PATCH 5/6] ARM: dts: imx28-tx28: Fix display duplicate name
 warning
In-Reply-To: <20140905005710.GG10809@dragon>
References: <1409851379-5330-1-git-send-email-fabio.estevam@freescale.com>
 <1409851379-5330-5-git-send-email-fabio.estevam@freescale.com>
 <20140905005710.GG10809@dragon>
Message-ID: <CAOMZO5CcPKujdvT_Oz65swN87Y+AaKqFUpVi64bQK19kYdCyMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 4, 2014 at 9:57 PM, Shawn Guo <shawn.guo@freescale.com> wrote:

>   DTC     arch/arm/boot/dts/imx28-tx28.dtb
> ERROR (path_references): Reference to non-existent node or label "display"

Ops, I missed this hunk in the aliases section:

--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -21,7 +21,7 @@
        aliases {
                can0 = &can0;
                can1 = &can1;
-               display = &display;
+               display = &display0;

Will send a v2.
