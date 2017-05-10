From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 10 May 2017 20:37:59 +0800
Subject: [PATCH v3 3/3] arm/arm64: signal SIBGUS and inject SEA Error
In-Reply-To: <20170510122055.GE28721@cbox>
References: <CAMj-D2BGTDKpOcMu2ip41_MTTj8VDwvs59Ds7yvLHcD8PeQzhg@mail.gmail.com>
 <5910AAA2.4030304@arm.com> <20170508175416.GA32234@cbox>
 <5911D204.7020304@arm.com> <e8614b38-9c17-bcfc-2239-307ed0f98c94@huawei.com>
 <20170510122055.GE28721@cbox>
Message-ID: <10cdbd75-2b89-c816-e688-91f111687819@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 2017/5/10 20:20, Christoffer Dall wrote:
> On Wed, May 10, 2017 at 05:15:04PM +0800, gengdongjiu wrote:
>> Thanks James's explanation.
>>
>> Hi Christoffer,
>>
>> On 2017/5/9 22:28, James Morse wrote:
>>> Hi Christoffer,
>>>
>>> On 08/05/17 18:54, Christoffer Dall wrote:
>>>> On Mon, May 08, 2017 at 06:28:02PM +0100, James Morse wrote:
>>>> I must admit I am losing track of exactly what this proposed API was
>>>> supposed to do.
>>>
>>> There are two, and we keep jumping between them!
>>> This is about two notification methods APEI has for arm64, 'SEA' and 'SEI'.
>>>
>>> SEA is synchronous and looks like a data abort. Qemu/kvmtool can inject these
>>> today using the KVM_GET/SET_ONE_REG API whenever it wants to.
>>>
>>> SEI uses SError, is asynchronous and can be masked. In addition these need to be
>>> consumed/synchronised by the ESB instruction, even when executed by a guest.
>>> Hardware has the necessary bits to drive all this, we need to expose an API to
>>> drive it.
>>>
>>> (I try to spell them out each time so I don't confuse SEI with something
>>> synchronous!)
>>>
>>>
>>> This patch was about SEA. I think you've answered our question:
>>
>> we are talking about the SEA(synchronous data abort) injection two methods:
>>
>> (1)change vcpu registers in the Qemu/kvmtools and using the KVM_GET/SET_ONE_REG API to set.
> 
> Yes, if this is possible, why would you want something more?
  we will use this method.

> 
>> (2)using existed in-kernel API "kvm_inject_dabt" to inject through IOCTL command from Qemu.
>>
> 
> I'm not really going to consider this, because "use internal API from
> userspace" doesn't work.
> 
> So this should be:
> 
>   (2) Introduce a new API to do X.
  you can ignore the second method, now we will not use it.

> 
> I still think you know what my preference is; use the existing API if at
> all possible.
> 
> Thanks,
> -Christoffer
> 
> .
> 
