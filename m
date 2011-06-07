From: prakity@marvell.com (Philip Rakity)
Date: Tue, 7 Jun 2011 08:04:57 -0700
Subject: [PATCH v3 2/4] mmc: support sdhci-pxav2.c
In-Reply-To: <BANLkTinsk0AzBYd+fO9Oz1RO9smNzJTsTA@mail.gmail.com>
References: <1307094606-8692-1-git-send-email-zhangfei.gao@marvell.com>
	<1E53FF9F-5C6A-4AA2-B441-DD712C5D6715@marvell.com>
	<BANLkTik9an1N8914nC5MVL7+nHh+NhDNAA@mail.gmail.com>
	<201106070917.41691.arnd@arndb.de>
	<BANLkTinsk0AzBYd+fO9Oz1RO9smNzJTsTA@mail.gmail.com>
Message-ID: <A5ADAC80-98EE-4184-A958-965A3EC275F9@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jun 7, 2011, at 12:31 AM, Eric Miao wrote:

>> How about changing the title of the option though? A user will
>> usually not know if he is using the v2 or v3 controller without
>> reading the help text. If you change it to
>> 
>> config MMC_SDHCI_PXAV2
>>        tristate "Marvell PXA168 SD Host Controller support (PXAV2)"
>>        default CPU_PXA168

change to
>>        tristate "Marvell PXA9xx SD Host Controller support (PXAV2)"

the pxa168 will not work in all cases with the V2 code.  It needs IO_ACCESSORS for readw and
a callback to sdhci.c to delay then time between transfers.  Once V2 code is mainline
I will resubmit the pxa168 code.


>> 
>> config MMC_SDHCI_PXAV3
>>        tristate "Marvell MMP2/PX9XX SD Host Controller support (PXAV3)"
>>        default CPU_MMP2 || CPU_PXA910
>> 
> 
> Yeah, the above is much cleaner/simpler.
> 
>> you increase the chances of users getting the configuration right.
>> 
>>        Arnd
>> 
>> BTW, both of you: Please always remove the lines that you don't refer to
>> when you reply to an email. It's very annoying having to scroll through
>> dozens of lines of citations to see what you are actually writing.
>> 
