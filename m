From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 12 Jul 2016 14:16:40 +0200
Subject: [PATCH v2 6/7] spi: s3c64xx: restore removed comments
In-Reply-To: <146827545163.73491.5083923656346798965@resonance>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
 <1467989201-14661-7-git-send-email-andi.shyti@samsung.com>
 <146799464881.73491.7507792367941552864@resonance>
 <57837606.8050906@samsung.com>
 <146827545163.73491.5083923656346798965@resonance>
Message-ID: <5784DFA8.60606@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2016 12:17 AM, Michael Turquette wrote:
> Quoting Sylwester Nawrocki (2016-07-11 03:33:42)
>> On 07/08/2016 06:17 PM, Michael Turquette wrote:

> Sure, but it's only a few lines of code to this, and there are examples
> in the kernel already.
> 
>> Additionally, the "There is half-multiplier before the SPI" comment
>> seems to be obfuscating how the hardware really looks like to me.
>> It talks about multiplier (which reminds me of PLLs with a divider
>> in the feedback loop) while there is a simple divider which should
>> be considered as an integral part of the controller IP block.
>>
>> While we are at it, I'd propose to change this comment to something
>> like:
>>
>> /* The SCLK_SPI clock is divided internally by 2 */
> 
> It's your choice, but debug output would benefit from showing the real
> clock frequency at some point.

OK, it's indeed fairly easy to add a fixed rate divide-by-two clock,
but for the older SoCs we would need to also model the internal mux, gate,
and an 8-bit divider.  Then it becomes a bit bigger task. Anyway it might
be worth to try it, this could let us deprecate the samsung,spi-src-clk
property and for all the SoCs use assigned-clock-parents.

-- 
Thanks,
Sylwester
