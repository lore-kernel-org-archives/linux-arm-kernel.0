From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 16 Oct 2013 16:19:47 +0200
Subject: [GIT PULL] fixes for integer rounding in timer core
In-Reply-To: <20131014073436.GX10079@pengutronix.de>
References: <alpine.DEB.2.02.1309191629040.4089@ionos.tec.linutronix.de>
 <1380052223-24139-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5253D9A1.1080106@pengutronix.de> <20131008153147.GR10079@pengutronix.de>
 <20131014073436.GX10079@pengutronix.de>
Message-ID: <525EA083.2070006@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/2013 09:34, Uwe Kleine-K?nig :
> Hello Linus, hello Ingo,
>
> On Tue, Oct 08, 2013 at 05:31:47PM +0200, Uwe Kleine-K?nig wrote:
>>> What's the status of this patch?
>> I pinged Thomas about it already via irc, but I didn't get a response up
>> to now. It would be great to get that into 3.12. To make it easy for
>> Thomas, here is a pull request that includes the fix and converts
>> at91rm9200 back to clockevents_config_and_register dropping one of the
>> workarounds for the fixed bug.
>>
>> The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:
>>
>>    Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)
>>
>> are available in the git repository at:
>>
>>    git://git.pengutronix.de/git/ukl/linux.git tags/timer-for-tip
>>
>> for you to fetch changes up to b58c4b70121070f45eefa739ecbb58d57da1c4d9:
>>
>>    ARM: at91: rm9200: switch back to clockevents_config_and_register (2013-10-08 16:58:22 +0200)
>>
>> ----------------------------------------------------------------
>> The first patch in this pull request fixes an old integer rounding bug in the
>> timer core that was (and still is) worked around in a few arch's timer code.
>> The second patch drops such a work around now that the core is fixed.
> It would be nice to get that fix into 3.12, but Thomas stopped
> responding nearly a month ago---his last mail in this thread[1] dates back
> to September 20.
>
> Can one of you please take it directly?

I second Uwe in his request (aka +1).

Thanks, bye,


> [1] http://thread.gmane.org/gmane.linux.kernel/1563370/
>> ----------------------------------------------------------------
>> Thomas Gleixner (1):
>>        clockevents: Sanitize ticks to nsec conversion
>>
>> Uwe Kleine-K?nig (1):
>>        ARM: at91: rm9200: switch back to clockevents_config_and_register
>>
>>   arch/arm/mach-at91/at91rm9200_time.c |  7 ++--
>>   kernel/time/clockevents.c            | 65 +++++++++++++++++++++++++++---------
>>   2 files changed, 52 insertions(+), 20 deletions(-)
>>
>> --
>> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
>> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>


-- 
Nicolas Ferre
