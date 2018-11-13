From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Nov 2018 14:35:18 +0100
Subject: [PATCH v12 0/2] Initial Allwinner V3s CSI Support
In-Reply-To: <1540886988-27696-1-git-send-email-yong.deng@magewell.com>
References: <1540886988-27696-1-git-send-email-yong.deng@magewell.com>
Message-ID: <20181113133518.6nnh4m37s6awfw6d@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

On Tue, Oct 30, 2018 at 04:09:48PM +0800, Yong Deng wrote:
> I can't make v4l2-compliance always happy.
> The V3s CSI support many pixformats. But they are not always available.
> It's dependent on the input bus format (MEDIA_BUS_FMT_*). 
> Example:
> V4L2_PIX_FMT_SBGGR8: MEDIA_BUS_FMT_SBGGR8_1X8
> V4L2_PIX_FMT_YUYV: MEDIA_BUS_FMT_YUYV8_2X8
> But I can't get the subdev's format code before starting stream as the
> subdev may change it. So I can't know which pixformats are available.
> So I exports all the pixformats supported by SoC.
> The result is the app (v4l2-compliance) is likely to fail on streamon.
> 
> This patchset add initial support for Allwinner V3s CSI.
> 
> Allwinner V3s SoC features a CSI module with parallel interface.
> 
> This patchset implement a v4l2 framework driver and add a binding 
> documentation for it. 

I've tested this version today, and I needed this patch to make it
work on top of v4.20:
http://code.bulix.org/9o8fw5-503690?raw

Once that patch applied, my tests were working as expected.

If that make sense, could you resubmit a new version with these merged
so that we can try to target 4.21?

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181113/4cf77f66/attachment.sig>
