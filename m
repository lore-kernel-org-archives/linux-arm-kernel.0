From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Thu, 25 Oct 2012 11:02:38 +0530
Subject: [PATCH] i2c: omap: re-factor omap_i2c_init function
In-Reply-To: <20121023191124.GB853@arwen.pp.htv.fi>
References: <1351006039-24332-1-git-send-email-shubhrajyoti@ti.com>
 <20121023191124.GB853@arwen.pp.htv.fi>
Message-ID: <5088CEF6.5000606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2012 12:41 AM, Felipe Balbi wrote:
>>
>> >    	return 0;
>> >    }
> another thing, the few places in omap_i2c_xfer_msg() which are currently
> calling omap_i2c_init() should also be converted to call the newly added
> __omap_i2c_init(). We don't need to recalculate any of those clock
> dividers and whatnot.

Yes in fact omap_i2c_init() can be reset - calculate - and __omap_i2c_init.
Then in those places the recalculate can be optimised.
