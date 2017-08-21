From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Mon, 21 Aug 2017 16:16:39 +0200
Subject: [PATCH v7] rockchip/rga: v4l2 m2m support
In-Reply-To: <1501737812-24171-1-git-send-email-jacob-chen@iotwrt.com>
References: <1501737812-24171-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <fe2c1de6-dd6c-378f-8a1e-d790807310b1@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

On 08/03/2017 07:23 AM, Jacob Chen wrote:
> Rockchip RGA is a separate 2D raster graphic acceleration unit. It
> accelerates 2D graphics operations, such as point/line drawing, image
> scaling, rotation, BitBLT, alpha blending and image blur/sharpness
> 
> The drvier is mostly based on s5p-g2d v4l2 m2m driver
> And supports various operations from the rendering pipeline.
>  - copy
>  - fast solid color fill
>  - rotation
>  - flip
>  - alpha blending
> 
> The code in rga-hw.c is used to configure regs according to operations
> The code in rga-buf.c is used to create private mmu table for RGA.
> 
> changes in V7:
> - fix some warning reported by "checkpatch --strict"
> 
> Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>

Can you post the v4l2-compliance output? I gather that there is at least one
colorspace-related error that appears to be a v4l2-compliance bug, so I'd
like to see the exact error it gives. I'll see if I can fix it so this driver
has a clean compliance output.

I apologize that this driver probably won't make 4.14. Too much to review...

I hope to do the v7 review within a week.

Regards,

	Hans
