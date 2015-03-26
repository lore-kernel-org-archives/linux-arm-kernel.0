From: tyler.baker@linaro.org (Tyler Baker)
Date: Thu, 26 Mar 2015 08:29:21 -0700
Subject: Possible regression in next-20150323 due to "ARM, arm64: kvm: get
 rid of the bounce page"
In-Reply-To: <20150326133631.GB2805@arm.com>
References: <20150324004537.GA24816@verge.net.au>
 <CAKv+Gu-0jPk=KQ4gY32ELc+BVbe=1QdcrwQ+Pb=RkdwO9K3Vkw@mail.gmail.com>
 <20150324161358.GA694@kahuna> <20150326003939.GA25368@verge.net.au>
 <20150326133631.GB2805@arm.com>
Message-ID: <CANMBJr68dsbYvvHUzy6U4m4fEM6nq8dVHBH4kLQ=0c4QNOhLPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 March 2015 at 06:36, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Mar 26, 2015 at 12:39:39AM +0000, Simon Horman wrote:
>> On Tue, Mar 24, 2015 at 11:13:58AM -0500, Nishanth Menon wrote:
>> > I think we now have a new error: (seen with omap2plus_defconfig)
>> > on next-20150324 :
>> > ./arch/arm/kernel/vmlinux.lds:677: undefined symbol `__hyp_idmap_size'
>> > referenced in expression
>> > make: *** [vmlinux] Error 1
>>
>> Thanks, I am seeing that too.
>>
>> My armchair suggestion is that the following should be reverted.
>>
>> e60a1fec44a2f ("ARM: kvm: implement replacement for ld's LOG2CEIL()")
>> 06f75a1f62000 ("ARM, arm64: kvm: get rid of the bounce page")
>
> Can you try again with the latest -next please? We've merged an additional
> patch aimed at sorting this out. Reverting isn't really an option, as
> there's an awful lot of code that depends on the bounce page removal.

Here are the kernelci.org -next results[1], if you click the build
status you can dig down into the build failures. next-20150326 has now
hit a compiler bug, Arnd mentioned he was looking into this issue.

>
> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



[1] http://kernelci.org/job/next/

Tyler
