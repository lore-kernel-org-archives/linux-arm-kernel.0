From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 16 Sep 2011 12:42:23 +0530
Subject: [RFC PATCH 02/11] regulator: Fix error check in
	set_consumer_device_supply
In-Reply-To: <20110915133337.GI7988@opensource.wolfsonmicro.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
	<1316085727-15023-2-git-send-email-rnayak@ti.com>
	<1316085727-15023-3-git-send-email-rnayak@ti.com>
	<20110915133337.GI7988@opensource.wolfsonmicro.com>
Message-ID: <4E72F6D7.6090302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 September 2011 07:03 PM, Mark Brown wrote:
> On Thu, Sep 15, 2011 at 04:51:58PM +0530, Rajendra Nayak wrote:
>> The parameters to set_consumer_device_supply() can be considered
>> invalid (and hence it could return -EINVAL) if nether consumer_dev nor
>> consumer_dev_name are passed, not when *both* are passed.
>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>
> No, passing both is a clear bug on the part of the caller - the two ways
> of specifying the device are not supposed to be used together.

Got it, I'll just drop this one.
