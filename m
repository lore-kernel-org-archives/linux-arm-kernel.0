From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 May 2016 12:26:10 +0100
Subject: [PATCH 5/5] RFC spi: sun4i: add DMA support
In-Reply-To: <ba0d6eb37cc4b0d2c46acbf9fcd7d644b3545ce8.1464130597.git.hramrach@gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com>
 <ba0d6eb37cc4b0d2c46acbf9fcd7d644b3545ce8.1464130597.git.hramrach@gmail.com>
Message-ID: <20160530112610.GJ29837@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2016 at 07:25:25PM -0000, Michal Suchanek wrote:

>  - fallback to previous behaviour when DMA initialization fails
> 
>    + this has the problem that when the driver happens to load before the dma
>      driver it will not use dma - can be addressed with a module parameter

No, you should pay attention to the error you are getting and let probe
deferral happen if that's the error you get.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160530/076d2e84/attachment.sig>
