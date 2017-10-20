From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Oct 2017 12:14:08 +0100
Subject: v4.14-rc3/arm64 DABT exception in atomic_inc() / __skb_clone()
In-Reply-To: <EAA60182-6F08-412E-8F8B-FD4B0309A858@gmail.com>
References: <EAA60182-6F08-412E-8F8B-FD4B0309A858@gmail.com>
Message-ID: <20171020111408.edj24tztxdptte5r@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 10:16:08PM -0400, Wei Wei wrote:
> Hi all,

Hi,

> I have fuzzed v4.14-rc3 using syzkaller and found a bug similar to that one [1].
> But the call trace isn?t the same. The atomic_inc() might handle a corrupted 
> skb_buff.
> 
> The logs and config have been uploaded to my github repo [2].
> 
> [1] https://lkml.org/lkml/2017/10/2/216
> [2] https://github.com/dotweiba/skb_clone_atomic_inc_bug

These do look very similar to what I was hitting; all appear to be
misaligned atomics in the same path.

I see that you have some empty repro files in [2]. If you have any
reproducers, would you mind sharing them?

If any of those are smaller or more reliable than the one I was able to
generate [3], it might make it more obvious what's going on, and/or make
it simpler to come up with a plain C reproducer.

Thanks,
Mark.

[3] https://www.kernel.org/pub/linux/kernel/people/mark/bugs/20171002-skb_clone-misaligned-atomic/syzkaller.repro
