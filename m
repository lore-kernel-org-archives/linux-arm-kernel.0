From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 15 Sep 2016 11:33:58 +0100
Subject: [PATCH v4 00/10] ARM: KVM: Support for vgic-v3
In-Reply-To: <20160915091334.GB23629@cbox>
References: <1473691764-29424-1-git-send-email-vladimir.murzin@arm.com>
 <20160915091334.GB23629@cbox>
Message-ID: <57DA7916.4060706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 15/09/16 10:13, Christoffer Dall wrote:
> Hi Valdimir,
> 
> On Mon, Sep 12, 2016 at 03:49:14PM +0100, Vladimir Murzin wrote:
>> Hi,
>>
>> This is an attempt to make use vgic-v3 under arch/arm since
>> save-restore functionality got re-written in C and can be shared
>> between arm/arm64 like it has already been done for vgic-v2 and timer.
>>
>> With this patches I'm able to get 32 core an AArch32 ARMv8 guest boot:
>>
>> ...
>> GICv3: CPU31: found redistributor 703 region 0:0x000000003ffd0000
>> CPU31: thread -1, cpu 3, socket 7, mpidr 80000703
>> Brought up 32 CPUs
>> SMP: Total of 32 processors activated (768.00 BogoMIPS).
>> CPU: All CPU(s) started in SVC mode.
>> ...
>>
>> Additionally, quite lightweight test based on Self IPI guest test[1]
>> has been run with up to 255 cpus.
>>
> I have applied this to kvmarm/queue, fixing up a few trivial conflicts,
> and I have changed the kvm_info message.

Great!

> 
> If you could test the integrated branch with GICv3 on a 32-bit platform,
> that would be great.

I've just pulled kvmarm/queue and started testing.

> 
> I'll give people a few days to give their acks to the non-KVM part of
> the series and will then put it in next.
> 

Thanks!
Vladimir

> Thanks for the work,
> -Christoffer
> 
> 
