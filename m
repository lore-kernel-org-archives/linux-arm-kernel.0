From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 04 Aug 2015 16:41:55 +0900
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <20150803133220.46db9839@gandalf.local.home>
References: <12F47692-3010-4886-B87D-3D7820609177@gmail.com>	<20150716113115.45a17f17@gandalf.local.home>	<20150716121658.7982fdf5@gandalf.local.home>	<20150717124054.GE26091@leverpostej>	<20150717090009.720f6bd0@gandalf.local.home>	<77EA0F10-D5F6-48BD-8652-3B979A978659@gmail.com>	<20150717104144.6588b2f7@gandalf.local.home>	<0886A996-40E1-49E9-823C-85E55A858716@gmail.com>	<1357EA74-B972-4B99-ADB0-BC7E8F06DDB5@gmail.com>	<20150720162004.GL9908@arm.com>	<20150803090951.GA10501@arm.com>	<D7BD8A9F-8710-42D5-A0ED-8747D2B6B268@gmail.com>	<20150803125711.65463359@gandalf.local.home>	<24AFDCDB-55DE-4A23-A26A-750B48AC365C@gmail.com>
 <20150803133220.46db9839@gandalf.local.home>
Message-ID: <55C06CC3.5090603@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2015 02:32 AM, Steven Rostedt wrote:
> On Tue, 4 Aug 2015 02:22:16 +0900
> Jungseok Lee <jungseoklee85@gmail.com> wrote:
>
>
>> It would be better to add the snippet when a new version is ready.
>> That way might help to figure out easily why the macro is introduced and how
>> it can be used in architecture code.
>
>
> OK, which ever.

I'm making best efforts to fix the problem, but it seems to me that the current
check_stack() doesn't fit to arm64 due to the differences in stack frame usage
on architectures.
Although my current patch doesn't solve all the issues I've noticed so far,
I'd like to get any comments about whether I'm doing it the right way.
Please take a look at my new vesion (v2) of RFC.

Thanks,
-Takahiro AKASHI


> -- Steve
>
