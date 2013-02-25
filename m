From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 25 Feb 2013 20:17:02 +0000
Subject: [PATCH] ARM: head: fix swapper and idmap population with LPAE
 and big-endian
In-Reply-To: <512BC4BE.7050103@gmail.com>
References: <1361805401-8629-1-git-send-email-will.deacon@arm.com>
 <fc39410e45e86f30d1f4fec192f35f64@localhost> <512BC4BE.7050103@gmail.com>
Message-ID: <512BC6BE.7090801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/02/13 20:08, Rob Herring wrote:
> On 02/25/2013 10:05 AM, Marc Zyngier wrote:
>> On Mon, 25 Feb 2013 15:16:41 +0000, Will Deacon <will.deacon@arm.com>
>> wrote:
>>> The LPAE page table format uses 64-bit descriptors, so we need to take
>>> endianness into account when populating the swapper and idmap tables
>>> during early initialisation.
>>>
>>> This patch ensures that we store the two words making up each page table
>>> entry in the correct order when running big-endian.
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>>
>> FWIW, tested as a KVM guest.
> 
> That was a for BE guest on LE host, right? :o

Yep. Actually, a 32bit BE guest on 64bit LE host. Scary, isn't it? ;-)

> Any ideas about much work that would be?

A substantial amount. I have a branch there:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
kvm-arm64/mmio-be

It contains all kind of patches to KVM, virtio and kvmtool. I need to
split things into reviewable bits. And maybe get a life. ;-)

	M.
-- 
Jazz is not dead. It just smells funny...
