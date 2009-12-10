From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 9 Dec 2009 22:57:59 -0500
Subject: [PATCH V2 07/09] led: enable led in 88pm860x
In-Reply-To: <20091209151432.GC32223@rakim.wolfsonmicro.main>
References: <771cded00912090516v25ca013ah6595020e6b3624d7@mail.gmail.com>
	<20091209151432.GC32223@rakim.wolfsonmicro.main>
Message-ID: <771cded00912091957n7662b62bv519f10ed9f992c75@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 9, 2009 at 10:14 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Dec 09, 2009 at 08:16:21AM -0500, Haojian Zhuang wrote:
>
>> + ? ? period = on + *delay_off;
>> + ? ? if (period < LED_BLINK_PERIOD_MIN)
>> + ? ? ? ? ? ? period = LED_BLINK_PERIOD_MIN;
>> + ? ? if (period > LED_BLINK_PERIOD_MAX)
>> + ? ? ? ? ? ? period = LED_BLINK_PERIOD_MAX;
>
> If the hardware can't support the blink settings requested the driver
> ought to return an error - there's a software fallback which will blink
> the LED using a timer instead.
>

Now return an error directly.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0007-led-enable-led-in-88pm860x.patch
Type: text/x-patch
Size: 10021 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091209/a660e74a/attachment.bin>
