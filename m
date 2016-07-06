From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 6 Jul 2016 20:49:21 +0100
Subject: [PATCH v6 00/18] Add support for FDMA DMA controller and slim
 core rproc found on STi chipsets
In-Reply-To: <1467823249.8360.28.camel@perches.com>
References: <1467795276-21725-1-git-send-email-peter.griffin@linaro.org>
 <1467823249.8360.28.camel@perches.com>
Message-ID: <20160706194921.GA7213@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

On Wed, 06 Jul 2016, Joe Perches wrote:

> On Wed, 2016-07-06 at 09:54 +0100, Peter Griffin wrote:
> > This patchset adds support for the Flexible Direct Memory Access (FDMA) core
> > found on STi chipsets from STMicroelectronics. The FDMA is a slim core CPU
> > with a dedicated firmware. It is a general purpose DMA controller supporting
> > 16 independent channels and data can be moved from memory to memory or between
> > memory and paced latency critical real time targets.
> []
> > ?include/linux/remoteproc/st_slim_rproc.h??????????|??53 ++
> 
> Is this directory really necessary?

Yes, I believe so.

> 
> Why shouldn't this file be local to drivers/remoteproc/?

Because it has to be included by the various client drivers which are based
around the slim core IP. Currently drivers/dma/st_fdma.c but also in the future
LDVB demux driver.

regards,

Peter.
