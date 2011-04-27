From: andreiw@motorola.com (Andrei Warkentin)
Date: Wed, 27 Apr 2011 13:58:41 -0500
Subject: since when does ARM map the kernel memory in sections?
In-Reply-To: <201104272050.10644.pwaechtler@mac.com>
References: <BANLkTin0NMo7ZDrnTmBghYeRC9wxJu7zrw@mail.gmail.com>
	<20110427131905.GF5832@shareable.org>
	<201104271532.24898.arnd@arndb.de>
	<201104272050.10644.pwaechtler@mac.com>
Message-ID: <BANLkTi=mUrEkKRY8xSDGLtWW_yQ0tGPXAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 1:50 PM, Peter Waechtler <pwaechtler@mac.com> wrote:
> Am Mittwoch, 27. April 2011, 15:32:24 schrieb Arnd Bergmann:
>> On Wednesday 27 April 2011, Jamie Lokier wrote:
>> > Imho, only if there's a use for it. ?If this is about whole partitions
>> > picking up random data corruption, versus not doing so, then I suggest
>> > the choice of "Reliable Write" vs. "Unreliable Write" be a mount
>> > option or hdparm-style block device option.
>> >
>> > If there are tighter guarantees, such as "Unreliable Write" corruption
>> > being limited to the written naturally aligned 1MB blocks (say), and
>> > it was genuinely faster, that would be really valuable information to
>> > pass up to filesystems - and to userspace - as you can structure
>> > reliability around that in lots of ways.
>>
>> In all the SDHC cards that I have seen, the corruption should be local to
>> an erase block of the size that is supposedly found in
>> /sys/block/mmcblk*/device/preferred_erase_size, which is typically 4 MB.
>>
>> However, I don't think that the standard actually guarantees this and,
>> worse, some cards that I have seen actually lie about the erase block
>> size and claim that it is 4 MB when it is actually 1.5, 2, 3 or 8 MB.
>>
>> For eMMC devices, I don't think we can read the erase block size.
>>
> I have to check, but I think to remember that it can be calculated by values
> provided in CSD/ ex CSD or whatever that acronym was... 4 or 8MB sounds
> familiar to me (and my problem).
>

Yep, there are ERASE_GRP_SIZE and ERASE_GRP_MULT in the CSD, and then
their high-capacity
variant in EXT_CSD (HC_ERASE_GRP_SIZE).

A
