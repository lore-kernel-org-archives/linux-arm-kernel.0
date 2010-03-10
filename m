From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 10 Mar 2010 16:03:24 +0800
Subject: [PATCH] locomo: replace locomo_{readl/writel} macros with
	__raw_{readw/writew}
In-Reply-To: <0D753D10438DA54287A00B027084269763682CE083@AUSP01VMBX24.collaborationhost.net>
References: <BD79186B4FD85F4B8E60E381CAEE1909022427CF@mi8nycmail19.Mi8.com>
	<f17812d71003090526r33325407n250c92b1947d9fcf@mail.gmail.com>
	<0D753D10438DA54287A00B027084269763682CE083@AUSP01VMBX24.collaborationhost.net>
Message-ID: <f17812d71003100003g7f5c4113ofb7d8bddf505de2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 10, 2010 at 9:21 AM, H Hartley Sweeten
<hartleys@visionengravers.com> wrote:
> On Tuesday, March 09, 2010 6:26 AM, Eric Miao wrote:
>> On Tue, Mar 9, 2010 at 8:18 AM, H Hartley Sweeten
>><hartleys@visionengravers.com> wrote:
>>> The locomo_readl and locomo_writel macros are misnamed. Both
>>> use (*(volatile u16 *)(addr)) so they should be a *w variety.
>>>
>>> Instead of renaming the macros just replace them tree wide with
>>> __raw_readw and __raw_writew.
>>>
>>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>> Cc: Eric Miao <eric.y.miao@gmail.com>
>>>
>>
>> Hey Hartley,
>>
>> Could you please rebase this on top of my 'devel' branch? And note
>> locomo_{read,write}l() may also be used in sub-device drivers like
>> keyboard, LEDs and etc.
>
> Eric,
>
> I "think" I found your devel branch on kernel.org. ?Following is the
> rebase.
>
> I also noticed a bug in locomo_suspend. The address is wrong when writing
> to the SPI control register. LOCOMO_SPICT is defined as an offset from
> LOCOMO_SPI, it's not an offset from the locomo base address. I fixed it
> in this patch but it might be better as a separate patch.

A separate patch is definitely welcome. Thanks.
