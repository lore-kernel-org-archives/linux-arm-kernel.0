From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 15 Feb 2011 23:12:10 +0800
Subject: [PATCH] ARM: PXA: Make PXA27x/PXA3xx overlay actually work
In-Reply-To: <201102151551.20080.anarsoul@gmail.com>
References: <1296679619-32666-1-git-send-email-anarsoul@gmail.com>
	<201102151358.47203.anarsoul@gmail.com>
	<AANLkTinu2LT4t=f=Y0ZBmT6=nsoiQ9HVVTYmzgLMpDXR@mail.gmail.com>
	<201102151551.20080.anarsoul@gmail.com>
Message-ID: <AANLkTimapyDg0G0k2GfTdQ6RcUs9oUxXmHGMWoDhaZED@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 9:51 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> On Tuesday 15 February 2011 15:36:07 you wrote:
>
>> Then maybe in this way? (I'd rather keep this bit in overlay specific
>> code, and make it valid not only to pxa27x)
>>
>> @@ -925,6 +925,8 @@ static int __devinit pxafb_overlay_init(struct
>> pxafb_info *fbi)
>>
>> ? ? ? ? /* place overlay(s) on top of base */
>> ? ? ? ? fbi->lccr0 |= LCCR0_OUC;
>> + ? ? ? lcd_writel(fbi, LCCR0, fbi->lccr0 & ~LCCR0_ENB);
>> +
>> ? ? ? ? pr_info("PXA Overlay driver loaded successfully!\n");
>> ? ? ? ? return 0;
>
> I tried it, it doesn't work that way (I got garbage on screen). Maybe it's not
> right time to modify LCCR0 reg?
>

I guess that's because OUC bit needs to be set when the panel is
not enabled. But re-enabling here is a bit hackish as well.

I don't mind move the code a bit, but can we separate this change
into another patch from the rest?

Thanks
- eric
