From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 28 Sep 2011 17:16:05 +0800
Subject: [PATCH 3/6] arm/imx: change mxc_init_l2x0() to an imx31/35 specific
	call
In-Reply-To: <1317201368-6403-1-git-send-email-shawn.guo@linaro.org>
References: <1317201368-6403-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1317201368-6403-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxc_init_l2x0() should really be an imx31/35 specific call.
The patch removes early_initcall from mxc_init_l2x0() and get imx31
and imx35 soc specific function calls mxc_init_l2x0(), so that it's
not necessarily to be called for all imx socs when we build single
image for multiple imx socs.

Thus the function can be renamed to imx3_init_l2x0() and put into
mm-imx3.c.  It also changes the return type from integer to void.
