From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 21 Jul 2011 18:00:05 +0100
Subject: linux-next regression on ARM926
In-Reply-To: <20110721165210.GD20310@n2100.arm.linux.org.uk>
References: <CACRpkdbBrVda2oD42tjrWiG6uHXAdWwpr6cZ7qnSc2KM82XCfw@mail.gmail.com>
	<20110718112757.GV23270@n2100.arm.linux.org.uk>
	<CA+wbFdfNAjqQf4T48_cVbNOb6ac84TQC-2QvHKD43dfRou-i9w@mail.gmail.com>
	<20110719110904.GJ26574@n2100.arm.linux.org.uk>
	<CA+wbFdcifNu1W1BtehSxEMf4G48NhYiCHx+uAGjFuRQ4hr_rLA@mail.gmail.com>
	<20110721134804.GO26574@n2100.arm.linux.org.uk>
	<CA+wbFdeohxm64qpDs+i4TaYBeL0vjqeG6LU0_3VucZ0hvVxCMQ@mail.gmail.com>
	<20110721165210.GD20310@n2100.arm.linux.org.uk>
Message-ID: <CA+wbFddfkSAeg95YpPQ42qTxmfjjfKyop+z0zJxiEvEE3ScMFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 5:52 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jul 21, 2011 at 05:39:06PM +0100, Dave Martin wrote:
>> Did you miss proc-v6, or is that touched by some other patch? ?I
>> already have the relevant patch, so I'm happy to post that if you
>> don't already have it.
>
> Well spotted, I've just corrected that.

I think that should be all of them -- I had hacked up a quick script
to find and change all instances, but proc-v6 was the only one it
touched which wasn't in your series.

I also build-tested the change in several configurations just to be
sure.  It looks sound, so far as I can tell.

>
>> My proc-maros.S patch is slightly different in that it avoids defining
>> the default values twice (i.e., once for !CONFIG_PM_SUSPEND and once
>> for suspend=0); but it's otherwise equivalent.
>>
>> I also took the opportunity to remove the definitions of
>> cpu_<name>_suspend_size for the !CONFIG_PM_SUSPEND case, since this
>> helps to ensure they are not used accidentally. ?That's a more
>> cosmetic change.
>
> The missing symbols for do_suspend/do_resume should be enough on their
> own to catch people using it, so I don't think that's necessary.

OK, agreed.

>> Do you want me to post my whole series anyway, or otherwise can you
>> point me to where you applied the patches so I can filter my series?
>
> I'll push it out later this evening, it'll be part of the devel-stable
> branch so once pushed it becomes immutable.

in that that case I guess I don't have anything to add, so I'll drop
my patches.  Apologies for the last-minute churn...

Thanks
---Dave
