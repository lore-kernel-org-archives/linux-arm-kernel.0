From: joe@perches.com (Joe Perches)
Date: Thu, 13 Nov 2014 10:28:44 -0800
Subject: [PATCH] dmaengine: pl330: Fix linker error "undefined reference
 to `__aeabi_uldivmod'"
In-Reply-To: <1415902763.1787.8.camel@linaro.org>
References: <1415896047.1787.4.camel@linaro.org>
 <1415898172.4223.1.camel@perches.com> <1415902763.1787.8.camel@linaro.org>
Message-ID: <1415903324.4223.5.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-11-13 at 18:19 +0000, Jon Medhurst (Tixy) wrote:
> There are many ways to code the limiting of the burst width, but as it
> starts out as the data bus width the DMA can handle (maximum 16 bytes)
> then at most we'll be going round the existing while loop 4 times so I
> don't think it's that much overhead, and probably less code size than
> using ffs.

For arm, isn't ffs just a few instruction with no loops?

> And as the driver has been broken for the unaligned memcpy case since
> the day it was added then I can't see that anyone is actually using it
> that way anyway, so all existing users (if any) must already be doing
> bus aligned copies and the current while loop will iterate zero times.

That's probably right, I just don't like reading
while loops where ffs/fls might be suitable.

> That's probably enough bikeshedding from me :-)

;)  Me too.  cheers, Joe
