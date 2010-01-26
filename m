From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 26 Jan 2010 06:54:48 -0500
Subject: [PATCH 01/01] regulator: support max8649
In-Reply-To: <20100126110420.GI15759@rakim.wolfsonmicro.main>
References: <771cded01001120041ue24edabk8e4638ef7151c947@mail.gmail.com>
	<771cded01001120051l44fd76bx80d2fd4b6f60bd0b@mail.gmail.com>
	<20100112115156.GA546@rakim.wolfsonmicro.main>
	<771cded01001250301q465a9f8ma484f597ae9a292f@mail.gmail.com>
	<20100125135628.GB26613@rakim.wolfsonmicro.main>
	<771cded01001252226k342723b3p3ea235fe79c46843@mail.gmail.com>
	<20100126110420.GI15759@rakim.wolfsonmicro.main>
Message-ID: <771cded01001260354y7c7db25bqa8bbfe000e0c0380@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 6:04 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jan 26, 2010 at 01:26:08AM -0500, Haojian Zhuang wrote:
>
> This all looks good except...
>
>> +static int max8649_enable_time(struct regulator_dev *rdev)
>> +{
>
> ...
>
>> + ? ? return (voltage / step);
>
> I'd expect the time taken to enable to be the voltage multipled by the
> step size rather than divided by the step size?
>

I don't agree at this point. The unit of step is uV/uSec. The function
should return uSec. So voltage divided by the step is more reasonable.

Others are updated.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-regulator-enable-max8649-regulator-driver.patch
Type: text/x-patch
Size: 13589 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100126/a97b8c41/attachment.bin>
