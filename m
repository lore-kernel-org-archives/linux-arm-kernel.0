From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 25 Jan 2010 06:01:41 -0500
Subject: [PATCH 01/01] regulator: support max8649
In-Reply-To: <20100112115156.GA546@rakim.wolfsonmicro.main>
References: <771cded01001120041ue24edabk8e4638ef7151c947@mail.gmail.com>
	<771cded01001120051l44fd76bx80d2fd4b6f60bd0b@mail.gmail.com>
	<20100112115156.GA546@rakim.wolfsonmicro.main>
Message-ID: <771cded01001250301q465a9f8ma484f597ae9a292f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 6:51 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jan 12, 2010 at 03:51:09AM -0500, Haojian Zhuang wrote:
>
>> Enable Maxim max8649 regulator driver.
>
> This seems basically fine but there's a few relatively minor issues
> below, mostly coding style rather than anything serious.
>
>
>> + ? ? if (pdata->ramp_timing) {
>> + ? ? ? ? ? ? info->ramp_timing = pdata->ramp_timing;
>> + ? ? ? ? ? ? max8649_set_bits(info->i2c, MAX8649_RAMP, MAX8649_RAMP_MASK,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?info->ramp_timing << 5);
>> + ? ? }
>
> You might want to implement the new enable_time() API for this.
>

This ramp timing is the time interval of each step on adjusting
voltage. I just want to control the timing in initialization.
enable_time() is only called before enabling regulator. And I don't
understand what would be done in enable_time().

Others are updated in this attached patch.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-regulator-enable-max8649-regulator-driver.patch
Type: text/x-patch
Size: 13015 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100125/0b788f4a/attachment.bin>
