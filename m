From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 29 May 2018 10:16:24 +0200
Subject: linux-next: manual merge of the irqchip tree with the arm-soc tree
In-Reply-To: <c306fbd9-21d9-5345-e820-52bc23d1b7c7@arm.com>
References: <20180529155257.5ae48830@canb.auug.org.au>
 <1bedc0b7-21f9-1e15-a11c-3de06e81b5ba@st.com>
 <c306fbd9-21d9-5345-e820-52bc23d1b7c7@arm.com>
Message-ID: <b01f3226-5bb8-071a-e825-73bec913ffa8@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc

On 05/29/2018 09:47 AM, Marc Zyngier wrote:
> On 29/05/18 08:41, Alexandre Torgue wrote:
>> Hi Stephen
>>
>> On 05/29/2018 07:52 AM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Today's linux-next merge of the irqchip tree got a conflict in:
>>>
>>>     arch/arm/boot/dts/stm32mp157c.dtsi
>>>
>>> between commit:
>>>
>>>     3c00436fdb20 ("ARM: dts: stm32: add USBPHYC support to stm32mp157c")
>>>
>>> from the arm-soc tree and commit:
>>>
>>>     5f0e9d2557d7 ("ARM: dts: stm32: Add exti support for stm32mp157c")
>>>
>>> from the irqchip tree.
>>>
>>> I fixed it up (see below) and can carry the fix as necessary. This
>>> is now fixed as far as linux-next is concerned, but any non trivial
>>> conflicts should be mentioned to your upstream maintainer when your tree
>>> is submitted for merging.  You may also want to consider cooperating
>>> with the maintainer of the conflicting tree to minimise any particularly
>>> complex conflicts.
>>>
>>
>> Thanks for the fix (I will reorder nodes in a future patch). My opinion
>> is that all STM32 DT patches should come through my STM32 tree. It is my
>> role to fix this kind of conflicts. I thought it was a common rule
>> (driver patches go to sub-system maintainer tree and DT to the Machine
>> maintainer). For incoming next-series which contain DT+driver patches I
>> will indicate clearly that I take DT patch. I'm right ?
> Happy to oblige. Can you make sure you sync up with Ludovic and define
> what you want to do?

Sorry I don't understand your reply. I just say that for series 
containing DT patches + drivers patches, to my point of view it is more 
safe that driver patches are taken by sub-system maintainer (you in this 
case) and that I take DT patches in my tree.

> 
> In the meantime, I'm dropping the series altogether.
> 
Why? We could keep it as Stephen fixed the merge issue.

> Thanks,
> 
> 	M.
> 
