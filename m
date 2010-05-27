From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Thu, 27 May 2010 22:06:04 +0200
Subject: [PATCH v3] i.MX27: add suspend to RAM support
In-Reply-To: <20100527194305.GB25921@n2100.arm.linux.org.uk>
References: <1274942000-3580-1-git-send-email-eric@eukrea.com>	<1274969635-2212-1-git-send-email-eric@eukrea.com>
	<20100527194305.GB25921@n2100.arm.linux.org.uk>
Message-ID: <4BFED0AC.6000604@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Le 27/05/2010 21:43, Russell King - ARM Linux a ?crit :
> On Thu, May 27, 2010 at 04:13:55PM +0200, Eric B?nard wrote:
>> +#include<linux/kernel.h>
>> +#include<linux/suspend.h>
>> +#include<asm/io.h>
>
> linux/io.h
>
OK sorry for this one, you already told me this at the first review and
I forget to fix it.

> (checkpatch.pl will tell you this, although the general rule that "if
> there's a linux/foo.h and an asm/foo.h, linux/foo.h should be used"
> doesn't always apply - there are some exceptions.)
>
In fact checkpatch only returned the following warning (which I didn't
fixed as I didn't found any platform_suspend_ops which is const).
Do you think I should also fix this warning ?

./linux-2.6/scripts/checkpatch.pl 
0001-i.MX27-add-suspend-to-RAM-support.patch
WARNING: struct platform_suspend_ops should normally be const
#72: FILE: arch/arm/mach-mx2/pm-imx27.c:35:
+static struct platform_suspend_ops mx27_suspend_ops = {

total: 0 errors, 1 warnings, 54 lines checked

0001-i.MX27-add-suspend-to-RAM-support.patch has style problems, please 
review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

Eric
