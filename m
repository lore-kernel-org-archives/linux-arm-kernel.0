From: mattjreimer@gmail.com (Matt Reimer)
Date: Thu, 17 Jun 2010 09:54:19 -0700
Subject: Hung kernel on SD writeback while suspending to RAM
In-Reply-To: <4C1A4C74.1040008@eukrea.com>
References: <AANLkTikHHcnJygPWKAlDk4NWGBE_fxexeLt3WO0xea0M@mail.gmail.com>
	<4C1A4C74.1040008@eukrea.com>
Message-ID: <AANLkTiml6DjWuP-_YEu3J6qRNYbogM52wa8mSHIuqY-z@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 17, 2010 at 9:25 AM, Eric B?nard <eric@eukrea.com> wrote:
> Hi,
>
> Le 15/06/2010 09:58, Alex Gonzalez a ?crit :
>>
>> I am looking into suspend to RAM on a Freescale MX51 running a 2.6.31
>> kernel. The
>> system suspends and resumes OK except when an SD card is mounted.
>>
>> What happens then is that it finds a page which is being written to disk
>> (writeback flag is set), so it waits forever in uninterruptible state
>> for the write to finish, which never happens.
>>
>> I was expecting the filesystem sync previous to the tasks freezing to
>> have written all page caches to disk.
>>
>> Any suggestion as to how to debug this forward?
>>
> I think you need to enable
> [ ] Assume MMC/SD cards are non-removable (DANGEROUS)
> in order to be able to suspend / resume a mounted SDCard.

Also see the thread "[PATCH] Fix the outstanding issue with hangs on
insert/removal of mmc cards" on linux-mmc:

http://article.gmane.org/gmane.linux.kernel.mmc/2233

Matt
