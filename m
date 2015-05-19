From: jbagg@lenbrook.com (Jonathan Bagg)
Date: Tue, 19 May 2015 15:13:49 -0400
Subject: imx6 sata cdrom driver issue
In-Reply-To: <15678294.L2fz4hMtva@wuerfel>
References: <5539101D.1020909@lenbrook.com> <15678294.L2fz4hMtva@wuerfel>
Message-ID: <555B8B6D.2070500@lenbrook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-04-24 03:58 AM, Arnd Bergmann wrote:
> On Thursday 23 April 2015 11:30:37 Jonathan Bagg wrote:
>> Spam Status: CRM114
>> On arm imx6, running mainline 3.19, mounting a SATA CDROM fails aprox
>> 1/20 times with this error....
>>
>> root at freescale /tmp$ mount /dev/sr0 test/
>> UDF-fs: warning (device sr0): udf_fill_super: No partition found (2)
>> mount: mounting /dev/sr0 on test/ failed: Invalid argument
>>
>> I've tried several disks and dvd drivers.  They all experience this
>> issue.  The same disks mount 100% of the time on an x86 machine.  Once
>> mounted, I can read data without issue.  Also tried a HDD on the same
>> SATA link, no issue.
>>
>> Sometimes the kernel will dump out the attached backtrace on the mount
>> command.
>>
> My best guess is that something in the error handling of
> drivers/ata/ahci_imx.c causes a reset of the entire bus and that
> triggers the other bugs. Can you instrument that error handling to
> see what's going on?
>
> 	Arnd
Adding my co-worker Kevin who has done a few experiments in the kernel

-- 
Jonathan Bagg
Embedded Systems Developer
NAD Electronics | Lenbrook Industries Limited
633 Granite Court, Pickering, Ontario, Canada L1W 3K1 | 905-831-0799 ext 4478 | http://www.nadelectronics.com
