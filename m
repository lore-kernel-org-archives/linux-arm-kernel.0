From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 25 Aug 2011 18:57:16 +0200
Subject: [PATCH 2/2] V4L: mx3-camera: prepare to support multi-size buffers
In-Reply-To: <Pine.LNX.4.64.1108251843350.17190@axis700.grange>
References: <1314211292-10414-1-git-send-email-g.liakhovetski@gmx.de>
	<Pine.LNX.4.64.1108251838090.17190@axis700.grange>
	<Pine.LNX.4.64.1108251843350.17190@axis700.grange>
Message-ID: <201108251857.16865.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

On Thursday 25 August 2011 18:46:03 Guennadi Liakhovetski wrote:
> Prepare the mx3_camera friver to support the new VIDIOC_CREATE_BUFS and
> VIDIOC_PREPARE_BUF ioctl()s. The .queue_setup() vb2 operation must be
> able to handle buffer sizes, provided by the caller, and the
> .buf_prepare() operation must not use the currently configured frame
> format for its operation, which makes it superfluous for this driver.
> Its functionality is moved into .buf_queue().

You're moving the ichan->dma_chan.device->device_prep_slave_sg() call from 
.buf_prepare() to .buf_queue(). Is that call cheap ? Otherwise it would be 
better to keep the .buf_prepare() callback.

-- 
Regards,

Laurent Pinchart
