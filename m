From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 28 Sep 2010 15:12:48 +0900
Subject: [PATCH] ARM: S5PV210: Add Torbreck board support
In-Reply-To: <004c01cb5ed1$bb44b890$31ce29b0$%kim@samsung.com>
References: <1285463130-14227-1-git-send-email-chlrbgh0@gmail.com>
	<AANLkTik5SkqjEz5Ymtg6RvwfrU0i8XzhPQq3Un7gMbP=@mail.gmail.com>
	<AANLkTik1YAd8W75DzrDmfhFYG-JE8__Tu4uq83RKsioC@mail.gmail.com>
	<004c01cb5ed1$bb44b890$31ce29b0$%kim@samsung.com>
Message-ID: <AANLkTikOtyxq7GzO4m5YUQK=MOUD_OAQ4ZVKpNnQBt5x@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 28, 2010 at 2:55 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> ??? wrote:
> Hi,
>
> Welcome to Linux mainline ;-)
> I have some comments about your patches.
>
> Firstly could you please use English character in the representing name in e-mail client not Korean character :-)
> And make sure it's text type.
>
>>Hi,
>>Thank you for your interesting.
>>On Mon, Sep 27, 2010 at 11:58 AM, Kyungmin Park <kmpark@infradead.org> wrote:
>
> (snip)
>
>>> +#define TORBRECK_UFCON_DEFAULT (S3C2410_UFCON_FIFOMODE | ? ? ? \
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?S5PV210_UFCON_TXTRIG4 | ? ? ? ?\
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?S5PV210_UFCON_RXTRIG4)
>>Any reason to use TRIG4? just use the full trigger e.g., 256.
>>
>>Okay, I'll fix it.
>>
> Hmm...Kyungmin, any reason to use full trigger here?
>
> It depends on board...so it doesn't matter TRIG4 or anything else if there is no problem on your board.
> It means the maximum value is not best condition...only depends on your situation/condition.

So I ask ANY REASON to use TRIG4?
And my opinions,
First. it's not true for all UARTs. it's only valid on UART0.
Second, "the maximum value is not best condition" then why Spec said
"increase the FIFO size for performance".

>
>>> +
>>> +static struct s3c2410_uartcfg torbreck_uartcfgs[] __initdata = {
>>> + ? ? ? [0] = {
>>> + ? ? ? ? ? ? ? .hwport ? ? ? ? = 0,
>>> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= 0,
>>There's no code for flags, please remove it all.
>>
>>Okay, I'll remove it.
>>
> I think no need to modify it.
> Actually I said many times about this...
>
> And as Ben Dooks said in other patch, the format will be changed soon.

I always listen "will be changed" so until that time use the correct code.
Don't add the meaningless codes.

Thank you,
Kyungmin Park
>
>>> + ? ? ? ? ? ? ? .ucon ? ? ? ? ? = TORBRECK_UCON_DEFAULT,
>>> + ? ? ? ? ? ? ? .ulcon ? ? ? ? ?= TORBRECK_ULCON_DEFAULT,
>>> + ? ? ? ? ? ? ? .ufcon ? ? ? ? ?= TORBRECK_UFCON_DEFAULT,
>>> + ? ? ? },
>>> + ? ? ? [1] = {
>>> + ? ? ? ? ? ? ? .hwport ? ? ? ? = 1,
>>> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= 0,
>>> + ? ? ? ? ? ? ? .ucon ? ? ? ? ? = TORBRECK_UCON_DEFAULT,
>>> + ? ? ? ? ? ? ? .ulcon ? ? ? ? ?= TORBRECK_ULCON_DEFAULT,
>>> + ? ? ? ? ? ? ? .ufcon ? ? ? ? ?= TORBRECK_UFCON_DEFAULT,
>>> + ? ? ? },
>>> + ? ? ? [2] = {
>>> + ? ? ? ? ? ? ? .hwport ? ? ? ? = 2,
>>> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= 0,
>>> + ? ? ? ? ? ? ? .ucon ? ? ? ? ? = TORBRECK_UCON_DEFAULT,
>>> + ? ? ? ? ? ? ? .ulcon ? ? ? ? ?= TORBRECK_ULCON_DEFAULT,
>>> + ? ? ? ? ? ? ? .ufcon ? ? ? ? ?= TORBRECK_UFCON_DEFAULT,
>>> + ? ? ? },
>>> + ? ? ? [3] = {
>>> + ? ? ? ? ? ? ? .hwport ? ? ? ? = 3,
>>> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= 0,
>>> + ? ? ? ? ? ? ? .ucon ? ? ? ? ? = TORBRECK_UCON_DEFAULT,
>>> + ? ? ? ? ? ? ? .ulcon ? ? ? ? ?= TORBRECK_ULCON_DEFAULT,
>>> + ? ? ? ? ? ? ? .ufcon ? ? ? ? ?= TORBRECK_UFCON_DEFAULT,
>>> + ? ? ? },
>>> +};
>>> +
>
> (snip)
>
>>> --
>>> 1.5.6.3
>>>
> If possible, please use later version git.
> It doesn't mean latest git is best...
> This is just private opinion. :-)
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
