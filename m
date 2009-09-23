From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 24 Sep 2009 06:25:46 +0800
Subject: Problem with s3c24xx pwm driver
In-Reply-To: <200909232223.35835.anarsoul@gmail.com>
References: <200909231824.11671.anarsoul@gmail.com>
	<f17812d70909231203v198aafberd00ce35bd7ba7f6b@mail.gmail.com>
	<200909232223.35835.anarsoul@gmail.com>
Message-ID: <f17812d70909231525t594704c5u781e2221481676a0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2009 at 3:23 AM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> ? ????????? ?? 23 ???????? 2009 22:03:17 ????? Eric Miao ???????:
>> Sounds like there are cases where the pwm_enable() and pwm_disable()
>> are not paired? You may want to print out the reference count each time
>> to see if this is true.
>
> And, btw, pwm_enable()/pwm_disable for s3c24xx just sets/clears one bit. It
> doesn't harm to set same bit twice, does it?
>

No, it doesn't.

So my suggestion at the moment is that you may:

1. try dump the registers after pwm_enable() and see if all are setup
correctly,

2. and make sure those registers are write-able at that time (some
SoC doesn't allow register writing when the controller is disabled).
