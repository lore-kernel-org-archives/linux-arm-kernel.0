From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 13 Apr 2011 11:35:58 -0600
Subject: [PATCH] ARM: add DT support to the S3C SDI driver
In-Reply-To: <20110413172547.GA27819@dandreoli.com>
References: <20110413172547.GA27819@dandreoli.com>
Message-ID: <20110413173558.GF2254@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2011 at 07:25:47PM +0200, Domenico Andreoli wrote:
> From: Domenico Andreoli <cavokz@gmail.com>
> 
> This patch adds DeviceTree support to the S3C SDI driver.
> 
> It implements all the configurations of the platform driver except the
> set_power() callback and the ocr_avail mask.
> 
> Signed-off-by: Domenico Andreoli <cavokz@gmail.com>
> 
> ---
> 
> ocr_avail is a bit mask that could be easily ported to DT. If there
> is not any better (or readable) way to render it in DT, I will
> straightforwardly implement it.
> 
> set_power() instead deserves some more considerations. Current
> implementations boil down to gpio on/off settings, its DT implementation
> is again straightforward. Problem would arise if any board requires
> some naive implementation, would it require a different of_device_id
> with proper .data set?

It would be better to think out the binding a bit more, but I'd need
to know more details about what is possible.

g.
