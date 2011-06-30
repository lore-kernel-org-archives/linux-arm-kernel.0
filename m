From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Thu, 30 Jun 2011 11:21:44 +0530
Subject: [PATCH v2 3/3] ARM: EXYNOS4: Add EPLL clock operations
In-Reply-To: <BANLkTim2pK5qKwQ5fmJxRHmNHCU=oJtf3A@mail.gmail.com>
References: <1308655463-8787-1-git-send-email-ch.naveen@samsung.com>
	<1308655463-8787-4-git-send-email-ch.naveen@samsung.com>
	<BANLkTim_0yj8hSefv5BUg5Z1vLh5SWhqjA@mail.gmail.com>
	<BANLkTim2pK5qKwQ5fmJxRHmNHCU=oJtf3A@mail.gmail.com>
Message-ID: <BANLkTi=aGo3WPaftzBxR=Jy6oHAzt+Yhbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Seungwhan,

On 22 June 2011 13:31, Seungwhan Youn <claude.youn@gmail.com> wrote:
> Hi Naveen,
>
> On Wed, Jun 22, 2011 at 3:51 PM, Naveen Krishna Ch
> <naveenkrishna.ch@gmail.com> wrote:
>> Hi Every one,
>>
>> 1. Both S5P6440 and S5P6450 uses PLL90XX for EPLL.
>> ?However, the same epll_ops is duplicated in the following files
>> ?arch/arm/mach-s5p64x0/clock-s5p6440.c
>> ?arch/arm/mach-s5p64x0/clock-s5p6450.c
>>
>> ?Please find attached patch which moves it to the common clock.c
>> ?Attachment: "0001-ARM-S5P64X0-Move-duplicated-epll-code.patch"
>>
>> 2. Also, S5PV210, C110, C100, 6450/6440 and EXYNOS4 define their own
>> ?epll_ops.
>>
>> ?The following attachment consolidates the same on the basis of PLL types
>> ?"Eg: PLL90XX. PLL46XX, PLL45XX and PLL65XX"
>>
>> ?Kindly, review the approach and comment.
>> ?Attachment: "0001-ARM-Samsung-organize-duplicated-EPLL-code.patch"
>
> I think this is a good try to clean-up Samsung platform's PLL settings. :)
> But one thing that I concern is 'epll_div' values are not a common
> value, it depends on board because of these values come from outer xtl
> which was selected by OM on board side. So, I wonder if you want to
> make PLL as a common platform, you may solve these 'epll_div' values
> to be correct. For example, you may calculate 'epll_div' values with
> formula which is in user manual or set 'epll_div' values in board
> specific file not platform file.

Thanks for your comments.

So far i was not lucky in finding out a generic way of deriving the
epll_div values.
And it doesn't seem to
1. Save lines of code or
2. Consolidate the PLL code.

Any suggestions for a simpler implementation are welcome.

>
> ? ? ? ?claude
>


-- 
Shine bright,
(: Nav :)
