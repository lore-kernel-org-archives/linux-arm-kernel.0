From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 6 Dec 2016 17:53:46 +0800
Subject: [bug report v4.8] fs/locks.c: kernel oops during posix lock
 stress test
In-Reply-To: <20161201113031.GB5813@arm.com>
References: <CACVXFVPsHjh3CWjdUrKB_r6=hkXK=qS3wpykbacdKe1rzz1H8Q@mail.gmail.com>
 <20161201113031.GB5813@arm.com>
Message-ID: <CACVXFVMyo98x7PF69TXMDKv53ag-3SjYL1FLNS=VSOA5Tje4EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Thu, Dec 1, 2016 at 7:30 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Nov 28, 2016 at 11:10:14AM +0800, Ming Lei wrote:
>> When I run stress-ng via the following steps on one ARM64 dual
>> socket system(Cavium Thunder), the kernel oops[1] can often be
>> triggered after running the stress test for several hours(sometimes
>> it may take longer):
>>
>> - git clone git://kernel.ubuntu.com/cking/stress-ng.git
>> - apply the attachment patch which just makes the posix file
>> lock stress test more aggressive
>> - run the test via '~/git/stress-ng$./stress-ng --lockf 128 --aggressive'
>>
>>
>> From the oops log, looks one garbage file_lock node is got
>> from the linked list of 'ctx->flc_posix' when the issue happens.
>>
>> BTW, the issue isn't observed on single socket Cavium Thunder yet,
>> and the same issue can be seen on Ubuntu Xenial(v4.4 based kernel)
>> too.
>
> FWIW, I've been running this on Seattle for 24 hours with your patch applied
> and not seen any problems yet. That said, Thomas did just fix an rt_mutex
> race which only seemed to pop up on Thunder, so you could give those
> patches a try.
>
>   https://lkml.kernel.org/r/20161130205431.629977871 at linutronix.de

I applied the patch against Ubuntu Yakkety kernel(v4.8 based), and run
the test again on one dual-socket Cavium ThunderX system, and the
issue can still be triggered.

So looks not a same issue with David Daney's.

Anyway, thank you for providing this input!

Thanks,
Ming
