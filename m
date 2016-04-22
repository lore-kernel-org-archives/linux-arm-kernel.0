From: james.morse@arm.com (James Morse)
Date: Fri, 22 Apr 2016 16:32:37 +0100
Subject: [PATCH v7 17/16] arm64: hibernate: Refuse to hibernate if the
 boot cpu is offline
In-Reply-To: <20160422104150.GD2998@e104818-lin.cambridge.arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1460565110-26341-1-git-send-email-james.morse@arm.com>
 <20160422104150.GD2998@e104818-lin.cambridge.arm.com>
Message-ID: <571A4415.4060301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/04/16 11:41, Catalin Marinas wrote:
> On Wed, Apr 13, 2016 at 05:31:50PM +0100, James Morse wrote:
>> It is important to hibernate/resume on the same CPU, otherwise we may
>> change the cpu order or restore a big cpu's register state on a little
>> cpu.
>>
>> We know cpu 0 is the cpu the firmware booted us on last time, refuse to
>> hibernate if it has been hotplugged out. Follow x86's example by registering
>> a pm notifier that is called before processes are frozen and devices are
>> stopped.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> I think for the time being we should just go ahead with this patch (with
> Lorenzo's suggestion for the commit log):
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks,


> Subsequently we could look at what Mark suggested on using MPIDR to
> hibernate/resume on CPU other than 0.

I was going to squash this into one of the previous patches, but as there is a
better-way(tm), I will leave it as it is so we can revert it later.


James
