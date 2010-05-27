From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Thu, 27 May 2010 22:54:40 +0200
Subject: [PATCH v3] i.MX27: add suspend to RAM support
In-Reply-To: <20100527201600.GF25921@n2100.arm.linux.org.uk>
References: <1274942000-3580-1-git-send-email-eric@eukrea.com>	<1274969635-2212-1-git-send-email-eric@eukrea.com>	<20100527194305.GB25921@n2100.arm.linux.org.uk>	<4BFED0AC.6000604@eukrea.com>
	<20100527201600.GF25921@n2100.arm.linux.org.uk>
Message-ID: <4BFEDC10.4090204@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 27/05/2010 22:16, Russell King - ARM Linux a ?crit :
> On Thu, May 27, 2010 at 10:06:04PM +0200, Eric B?nard wrote:
>> Do you think I should also fix this warning ?
>>
>> ./linux-2.6/scripts/checkpatch.pl
>> 0001-i.MX27-add-suspend-to-RAM-support.patch
>> WARNING: struct platform_suspend_ops should normally be const
>> #72: FILE: arch/arm/mach-mx2/pm-imx27.c:35:
>> +static struct platform_suspend_ops mx27_suspend_ops = {
>
> It's trivial enough to fix, and doesn't cause any issues by doing so,
> so I'd suggest adding the const.
>
well now this triggers the following warning so forget the patch v4, 
checkpatch seems wrong on this case :
   CC      arch/arm/mach-mx2/pm-imx27.o
arch/arm/mach-mx2/pm-imx27.c: In function 'mx27_pm_init':
arch/arm/mach-mx2/pm-imx27.c:42: warning: passing argument 1 of 
'suspend_set_ops' discards qualifiers from pointer target type

Eric
