From: amit.virdi@st.com (Amit Virdi)
Date: Thu, 14 Feb 2013 11:04:54 +0530
Subject: Need advice: unable to mount filesystem
In-Reply-To: <CABYxbz4kxn-4FSMHqp4dHq1JFbaMU1AZ7r6EcHFHYD0kGtZ4Rw@mail.gmail.com>
References: <511B8729.8040908@st.com>
 <CACRpkdb=zgaWkzoMtaWbMZXe_wUyszwsjmRC=03iMPDpU90N4w@mail.gmail.com>
 <CABYxbz4kxn-4FSMHqp4dHq1JFbaMU1AZ7r6EcHFHYD0kGtZ4Rw@mail.gmail.com>
Message-ID: <511C777E.7030007@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/14/2013 8:27 AM, Anil Kumar wrote:
> Hi,
>
> On Wed, Feb 13, 2013 at 6:44 PM, Linus Walleij<linus.walleij@linaro.org>  wrote:
>> On Wed, Feb 13, 2013 at 1:29 PM, Amit Virdi<amit.virdi@st.com>  wrote:
>>
>>> I have tried mounting the filesystem from DDR, that too with no success. One
>>> observation is that before mounting the FS, the kernel throws a warning:
>>> --
>>> Warning: unable to open an initial console.
>>
>> This is not your problem. The kernel screams that all the time, (I once
>> saw that explained and some ugly workaround for).
>>
>> This (from your log) is the real problem:
>>
>> VFS: Cannot open root device "mtdblock3" or unknown-block(31,3): error -14
>> Please append a correct "root=" boot option; here are the available partitions:
>> 1f00              64 mtdblock0  (driver?)
>> 1f01             192 mtdblock1  (driver?)
>> 1f02            2048 mtdblock2  (driver?)
>> 1f03           14080 mtdblock3  (driver?)
>> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(31,3)
>> [<2000cb50>] (unwind_backtrace+0x0/0xf8) from [<2018655c>] (panic+0x8c/0x1d8)
>> [<2018655c>] (panic+0x8c/0x1d8) from [<201f8d58>] (mount_block_root+0x1fc/0x2b8)
>> [<201f8d58>] (mount_block_root+0x1fc/0x2b8) from [<201f90c0>]
>> (prepare_namespace+0x160/0x1b8)
>> [<201f90c0>] (prepare_namespace+0x160/0x1b8) from [<20185984>]
>> (kernel_init+0x8/0xe4)
>> [<20185984>] (kernel_init+0x8/0xe4) from [<20008e98>] (ret_from_fork+0x14/0x3c)
>
> Please try with "rootwait" in bootargs.
>

Tried... no success :-(

I'll now backport to previous versions and see if it works.

Regards
Amit Virdi
