From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 02 Dec 2014 14:53:08 +0000
Subject: [PATCH] ARM: imx6: fix bogus use of irq_get_irq_data
In-Reply-To: <20141202144759.GO2411@dragon>
References: <1417453443-9179-1-git-send-email-marc.zyngier@arm.com>
 <20141202144759.GO2411@dragon>
Message-ID: <547DD254.4090704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 02/12/14 14:48, Shawn Guo wrote:
> On Mon, Dec 01, 2014 at 05:04:03PM +0000, Marc Zyngier wrote:
>> The imx6 PM code seems to be quite creative in its use of irq_data,
>> using something something that is very much a hardware interrupt
>> number where we expect a virtual one.  Yes, it worked so far, but
>> that's only cheer luck, and it will definitely explode in 3.19.
>>
>> Fix it by using a pair of helper functions that deal with the
>> actual hardware.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Arnd, Olof,
> 
> To avoid a non-booting 3.19-rc1 on i.MX6, please apply it for 3.19-rc1.

The previous patch (ARM: imx: irq: fix buggy usage of irq_data irq
field) should also be applied (you cannot apply one without the other
anyway).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
