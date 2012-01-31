From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 31 Jan 2012 23:40:41 +0900
Subject: [PATCH] ARM: smp: allow get the core count from L2 control on A15
In-Reply-To: <20120131143247.GB31004@mudshark.cambridge.arm.com>
References: <04be01cce011$6b3b3550$41b19ff0$%kim@samsung.com>
 <20120131141313.GA31004@mudshark.cambridge.arm.com>
 <4F27F8E8.1030703@samsung.com>
 <20120131143247.GB31004@mudshark.cambridge.arm.com>
Message-ID: <4F27FD69.7060207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/12 23:32, Will Deacon wrote:
> On Tue, Jan 31, 2012 at 02:21:28PM +0000, Kukjin Kim wrote:
>> On 01/31/12 23:13, Will Deacon wrote:
>>>
>>> This doesn't belong in smp.c but, more importantly, this doesn't work for
>>> multi-cluster configurations at all. Since all A15 implementations will be
>>> on new platforms, the code will be device-tree only and so we should use
>>
>> Why not? As I know, current arm kernel ARMv7 arch can support A15
>> without device-tree. And you know, the core number should be counted by
>> L2 control register. no?
>
> I'll answer these in order:

Hmm, let
>
> 1.) The code doesn't belong in smp.c because it's specific to the A15

Yes, agree. So I just commented in my patch, I'm not sure where it 
should be added at.

> 2.) The architecture code may well support A15, but since there are no
>      platforms in mainline that support A15 yet, then all new platforms will
>      need to be DT-based. That means we can rely on the DT to provide this
>      information.

Well, I will submit EXYNOS5 which has two A15 cores today and I don't 
know why it should be supported only with DT, EXYNOS5 DT supporting will 
be submitted though.

> 3.) The L2 control register only tells you how many cores are hanging off
>      that particular L2. This will be wrong for multi-cluster systems since
>      it will only identify a subset of the cores.

OK, let me check it.

>
>>> I believe Lorenzo posted some patches which you could look at.
>>>
>> OK, Would be better.
>
> Yes, I think it's the only way to solve this problem without adding an
> architected method for enumerating the CPU topology.
>
I'm not sure it is the only way...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
