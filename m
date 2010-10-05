From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 5 Oct 2010 17:46:58 +0900
Subject: [PATCH 0/7] ARM: S5PC210: I2C devices support and Universal board
	updates
In-Reply-To: <001401cb6468$ed8d06d0$c8a71470$%kim@samsung.com>
References: <20100930044814.GA16892@july>
	<AANLkTiknkbts6AtiBpqceSDqEXsE9E+qpMKJx2fzygB6@mail.gmail.com>
	<001401cb6468$ed8d06d0$c8a71470$%kim@samsung.com>
Message-ID: <AANLkTik022VftXnVXgxEKkATnafPV2U8ZFOQqd+2jXNC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 5, 2010 at 5:40 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kyungmin Park wrote:
>>
>> Hi,
>>
> Hi,
>
>> I think we made some conclusion. first apply the current style and
>> improve it later for consistency.
>>
> Yeah, we should decide for this.
>
> However, it's expected following problem with current I2C style.
>
> Suppose A board want to use only I2C0, 1, 2, 3, 4, 7 as I2C and B board want
> to use all of I2C channels as I2C. If use one kernel image for A and B,
> maybe selected all I2C channels. It can be happened the some problem about
> I2C5 and I2C6 on A board when it used for other purpose.

It's handled by platform_device id. Even though turn on all I2C. A
board don't register 5 or 6 then no configure any GPIOs.

>
> Of course can happen regardless of number of I2C channel, but if more I2C
> channels, the probability can be increased.
>
> Anyway I know Mr. Han is preparing I2C patches for it and almost done.
> How about continuing discussion for this after submitting it?
>
> I think we have some time that talk about this issue.
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
