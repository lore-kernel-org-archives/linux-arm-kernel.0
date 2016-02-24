From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 24 Feb 2016 12:06:52 +0000
Subject: [PATCH] arm/arm64: KVM: Feed initialized memory to MMIO accesses
In-Reply-To: <20160224114044.GA18451@cbox>
References: <1455723260-23793-1-git-send-email-marc.zyngier@arm.com>
 <20160224114044.GA18451@cbox>
Message-ID: <56CD9CDC.2020100@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/02/16 11:40, Christoffer Dall wrote:
> On Wed, Feb 17, 2016 at 03:34:20PM +0000, Marc Zyngier wrote:
>> On an MMIO access, we always copy the on-stack buffer info
>> the shared "run" structure, even if this is a read access.
>> This ends up leaking up to 8 bytes of uninitialized memory
>> into userspace.
> 
> I think it only leaks 'len' bytes to userspace ;)
> 
>>
>> An obvious fix for this one is to only perform the copy if
>> this is an actual write.
> 
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Thanks. I've pushed this onto master, with a view of sending a PR to
Paolo this evening (hopefully the last one for this cycle).

	M.
-- 
Jazz is not dead. It just smells funny...
