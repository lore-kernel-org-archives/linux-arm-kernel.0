From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 May 2010 21:16:00 +0100
Subject: [PATCH v3] i.MX27: add suspend to RAM support
In-Reply-To: <4BFED0AC.6000604@eukrea.com>
References: <1274942000-3580-1-git-send-email-eric@eukrea.com>
	<1274969635-2212-1-git-send-email-eric@eukrea.com>
	<20100527194305.GB25921@n2100.arm.linux.org.uk>
	<4BFED0AC.6000604@eukrea.com>
Message-ID: <20100527201600.GF25921@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 27, 2010 at 10:06:04PM +0200, Eric B?nard wrote:
> Le 27/05/2010 21:43, Russell King - ARM Linux a ?crit :
>> On Thu, May 27, 2010 at 04:13:55PM +0200, Eric B?nard wrote:
> OK sorry for this one, you already told me this at the first review and
> I forget to fix it.

np.

>> (checkpatch.pl will tell you this, although the general rule that "if
>> there's a linux/foo.h and an asm/foo.h, linux/foo.h should be used"
>> doesn't always apply - there are some exceptions.)
>>
> In fact checkpatch only returned the following warning (which I didn't
> fixed as I didn't found any platform_suspend_ops which is const).

It seems to be classified as a "--subjective" check - I suspect because
there's some variance between arch maintainers on their policy on this
issue, and also because there are some exceptions as I've said above.

Eg, we have asm/memory.h, and there is a linux/memory.h, but the two
are completely unrelated - so the checkpatch warnings about "use
linux/memory.h rather than asm/memory.h" are rather misleading.

> Do you think I should also fix this warning ?
>
> ./linux-2.6/scripts/checkpatch.pl  
> 0001-i.MX27-add-suspend-to-RAM-support.patch
> WARNING: struct platform_suspend_ops should normally be const
> #72: FILE: arch/arm/mach-mx2/pm-imx27.c:35:
> +static struct platform_suspend_ops mx27_suspend_ops = {

It's trivial enough to fix, and doesn't cause any issues by doing so,
so I'd suggest adding the const.
