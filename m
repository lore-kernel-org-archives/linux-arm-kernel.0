From: huawei.libin@huawei.com (libin)
Date: Thu, 22 Oct 2015 08:55:43 +0800
Subject: [PATCH] arm64: ftrace: function_graph: dump real return addr in
 call trace
In-Reply-To: <20151020153227.GL11226@e104818-lin.cambridge.arm.com>
References: <1444911155-17480-1-git-send-email-huawei.libin@huawei.com>
 <6277407.jveniKQDxt@wuerfel> <20151015125133.GA29301@arm.com>
 <20151015101812.7cb6e917@gandalf.local.home>
 <20151020153227.GL11226@e104818-lin.cambridge.arm.com>
Message-ID: <5628340F.5080902@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015/10/20 23:32, Catalin Marinas ??:
> On Thu, Oct 15, 2015 at 10:18:12AM -0400, Steven Rostedt wrote:
>> On Thu, 15 Oct 2015 13:51:33 +0100
>> Will Deacon <will.deacon@arm.com> wrote:
>>
>>> Is this the same old problem caused by e306dfd06fcb ("ARM64: unwind: Fix
>>> PC calculation")? I've said previously that I'm happy to revert that if
>>> we're the only architecture with this behaviour, but Akashi resisted
>>> because there are other issues with ftrace that he was hoping to address
>>> and they would resolve this too.
>>
>> Just a reference, but this patch is pretty much exactly what x86
>> currently has. I wonder if I should make that function generic for all
>> archs to use.
>>
>> If you accept this patch, I can look at what archs do and pull out the
>> common code and place it into the core code and have the archs call
>> that instead.
>
> The difference I see from the sh and x86 version is that we have this -4
> on arm64, introduced by e306dfd06fcb as Will mentioned above (it seemed
> to have caused more problems that it solved). I think we should revert
> that commit first just to be in line with other architectures and then
> apply additional fixes as needed.
>
> Question for Li Bin: is your patch still needed if we revert commit
> e306dfd06fcb?
>

It still be needed, but it can be implemented in generic for all archs
as Steve suggested.

Thanks,
Li Bin

> Thanks.
>
