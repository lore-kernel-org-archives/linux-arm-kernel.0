From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 3 Apr 2013 10:47:21 +0800
Subject: [PATCH] ARM: imx: do not bring up unavailable cores
In-Reply-To: <CAOMZO5AJjz4Z68GxkeCM3rH9p9-z6jaOM35MBSjN-UE_Dk4=eg@mail.gmail.com>
References: <1364913146-26084-1-git-send-email-shawn.guo@linaro.org>
 <20130402151715.GB6608@mudshark.cambridge.arm.com>
 <20130403021348.GK24039@S2101-09.ap.freescale.net>
 <CAOMZO5AJjz4Z68GxkeCM3rH9p9-z6jaOM35MBSjN-UE_Dk4=eg@mail.gmail.com>
Message-ID: <20130403024719.GF27148@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 11:38:26PM -0300, Fabio Estevam wrote:
> On Tue, Apr 2, 2013 at 11:13 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > The bootloader doesn't know the core numbers, unless we have code in
> > bootloader to find it out by reading fuse bit or SCU register that the
> > i.MX6 DualLite has one or two cores available.
> 
> U-boot does read SCU register and can identify Quad/Dual-Lite/Solo/Solo-lite.

Ah, great.  I haven't checked the U-Boot code for some time.  But does
U-Boot remove cpu nodes of those unavailable cores from device tree
before passing it to kernel?

Shawn
