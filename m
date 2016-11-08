From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 8 Nov 2016 12:21:28 +0100
Subject: [GIT PULL] ARM: OXNAS SoC updates for 4.10
In-Reply-To: <20161107212648.GC2106@localhost>
References: <1305c61f-b1ef-7caf-7788-67e2b907e873@baylibre.com>
 <20161107212648.GC2106@localhost>
Message-ID: <0b12c093-4be4-8f1c-2b46-ffaa54c5520b@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2016 10:26 PM, Olof Johansson wrote:
> On Mon, Oct 31, 2016 at 10:52:53AM +0100, Neil Armstrong wrote:
>> Dear arm-soc maintainers,
>>
>> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
>>
>>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
>>
>> are available in the git repository at:
>>
>>   https://github.com/OXNAS/linux.git tags/oxnas-arm-soc-for-4.10
>>
>> for you to fetch changes up to b3cdb3c5ef514687891f03442f2677850340bcfa:
>>
>>   ARM: oxnas: Add OX820 config and makefile entry (2016-10-31 10:41:33 +0100)
>>
>> ----------------------------------------------------------------
>> - Add SMP support for the Oxford Semiconductor OX820 SoC
>> from http://lkml.kernel.org/r/20161021085848.1754-1-narmstrong at baylibre.com
>>
>> ----------------------------------------------------------------
>> Neil Armstrong (2):
>>       ARM: oxnas: Add OX820 SMP support
>>       ARM: oxnas: Add OX820 config and makefile entry
> 
> Hi Neil,
Hi Olof,

> 
> Sorry for being picky here, please be patient with us. :-)
Seems legit !

> 
> Overall comments on this patch set:
> 
> 1) Copyrights seem to be a bit varied. All 3 new source files have
>    different copyright holders. Only one has yours, one is from 2003, one
>    is also from 2013. Is this expected? Seems like it's worth mentioning
>    in commit messages at least.

Yes, the files comes from various places :
- hotplug.c was taken from versatile by Ma Haijun and left verbatim, so I left the original header
- headsmp.S was taken from the versatile code and adapted by Ma Haijun
- platsmp.c is a mix from versatile code, Ma Haijun code and my code for DT

The two first file were only modified in order to build and pass checkpatch actually.

I tried to find the *real* copyright holders, but it was not easy...

> 
> 2) Please remove the linux/arch/... lines from the top of the files. It's
>    something we've been trying to remove for a while and don't want to
>    introduce more occurrances of.
> 
> I'd say (2) is fine to do incremental, but please provide clarification on (1).
> I could just add that to the merge commit message so don't respin the branch
> yet, depending on what we hear back!
> 

Ok, please tell me if/when I need to send a new pull for the (2) fix.

>>  arch/arm/Makefile             |   1 +
>>  arch/arm/mach-oxnas/Kconfig   |  30 +++++++++++++++++++---------
>>  arch/arm/mach-oxnas/Makefile  |   2 ++
>>  arch/arm/mach-oxnas/headsmp.S |  28 ++++++++++++++++++++++++++
>>  arch/arm/mach-oxnas/hotplug.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-oxnas/platsmp.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> Git tip: If you redirect the output to a file (or pipe through cat), the
> diffstat will be limited to 80 characters and look better in email.
> 
> 
> Thanks,
> 
> -Olof
> 

Thanks,
Neil
