From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 29 May 2011 20:15:12 -0600 (MDT)
Subject: [PATCHv2 2/2] OMAP: add omap_device_reset()
In-Reply-To: <1306514427.1905.27.camel@deskari>
References: <1306481908-7386-1-git-send-email-tomi.valkeinen@ti.com>
	<1306481908-7386-3-git-send-email-tomi.valkeinen@ti.com>
	<4DDF9B5D.7060408@ti.com> <1306500367.1905.18.camel@deskari>
	<4DDFB8AF.1080800@ti.com> <1306514427.1905.27.camel@deskari>
Message-ID: <alpine.DEB.2.00.1105292006330.8973@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 May 2011, Tomi Valkeinen wrote:

> However, VENC doesn't use the standard syscontrol mechanism, so that 
> cannot be done via omap_device interface anyway.

struct omap_hwmod_class has a .reset function pointer for this purpose.  
It's already been necessary to deal with the I2C IP block:

   https://patchwork.kernel.org/patch/804072/

If all that's needed are the steps in 4430 TRM Rev. T Section 10.6.5.1.2.3 
"Subsequence--Video Encoder Software Reset", then it should be possible to 
handle this internal reset with hwmod code.

- Paul
