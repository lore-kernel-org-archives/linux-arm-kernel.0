From: langabe@gmail.com (Alex Gonzalez)
Date: Fri, 18 Jun 2010 17:28:51 +0200
Subject: Hung kernel on SD writeback while suspending to RAM
In-Reply-To: <4C1A4C74.1040008@eukrea.com>
References: <AANLkTikHHcnJygPWKAlDk4NWGBE_fxexeLt3WO0xea0M@mail.gmail.com>
	<4C1A4C74.1040008@eukrea.com>
Message-ID: <AANLkTilNtj4Q2_-iQw6ncnkmYaO2hZKUTyhbjQlxv9iH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

That indeed did the trick.

The Kconfig help confused me as I was neither removing the card from
the slot or booting from it.

Thanks a lot,
Alex

--------------------------------

If you say Y here, the MMC layer will assume that all cards
stayed in their respective slots during the suspend. The
normal behaviour is to remove them at suspend and
redetecting them at resume.

This option is usually just for embedded systems which use
a MMC/SD card for rootfs. Most people should say N here.


On Thu, Jun 17, 2010 at 6:25 PM, Eric B?nard <eric@eukrea.com> wrote:
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
>
> Eric
>
