From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 27 Sep 2011 10:59:38 +0530
Subject: [RFC PATCH 3/3] ARM: mm: add l2x0 suspend/resume support
In-Reply-To: <20110926171452.GC11647@e102568-lin.cambridge.arm.com>
References: <1317047561-11020-1-git-send-email-lorenzo.pieralisi@arm.com>	<1317047561-11020-4-git-send-email-lorenzo.pieralisi@arm.com>	<20110926150645.GN22455@n2100.arm.linux.org.uk>
	<20110926171452.GC11647@e102568-lin.cambridge.arm.com>
Message-ID: <4E815F42.6010102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lorenzo,

On Monday 26 September 2011 10:44 PM, Lorenzo Pieralisi wrote:
> On Mon, Sep 26, 2011 at 04:06:45PM +0100, Russell King - ARM Linux wrote:
>> On Mon, Sep 26, 2011 at 03:32:41PM +0100, Lorenzo Pieralisi wrote:
>>> Context is saved once for all at boot time, along with the L2 physical address
>>> and cache type.
>>
>> Why is this assembly code?  As Barry's previous patch shows, it's
>> entirely possible to save all the state required at init time from
>> the existing C code without needing any additional functions.
>>
> 
I too didn't like this approach.

The platforms which needs to take care of security needs to take
care of the L2 on their own and this code doesn't help them.

Other platform which wants to use the L2 code, looks like are
fine to use the C-version which saves registers in init and restores
it in resume path whenever needed. The patch which was posted
on that was good enough. Regarding turning OFF MMU is really
not necessary unless and until some hardware's are buggy. In that
case, instead of adding that un-necessary code in generic code,
it's better to patch only that buggy SOC code.

Regards
Santosh
