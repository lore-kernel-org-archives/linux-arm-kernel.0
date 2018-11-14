From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Wed, 14 Nov 2018 12:54:13 +0200
Subject: [PATCH v12 0/2] Initial Allwinner V3s CSI Support
In-Reply-To: <1540886988-27696-1-git-send-email-yong.deng@magewell.com>
References: <1540886988-27696-1-git-send-email-yong.deng@magewell.com>
Message-ID: <20181114105413.4gcfwt4cmchh6zsf@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Applied with this diff from Maxime:

<URL:http://code.bulix.org/vf7b6g-504515?raw>

The MAINTAINERS entry was also moved to the first patch.

Thanks!

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi
