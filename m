From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 14 Oct 2013 09:24:32 +0100
Subject: [PATCH 0/3] virtio-mmio: handle BE guests on LE hosts
In-Reply-To: <20131012182837.GC2089@redhat.com>
References: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
 <20131012182837.GC2089@redhat.com>
Message-ID: <525BAA40.8070103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On 12/10/13 19:28, Michael S. Tsirkin wrote:
> On Fri, Oct 11, 2013 at 03:36:08PM +0100, Marc Zyngier wrote:
>> This small patch series adds just enough kernel infrastructure and
>> fixes to allow a BE guest to use virtio-mmio on a LE host, provided
>> that the host actually supports such madness.
>>
>> This has been tested on arm64, with some fixes to KVM and a set of
>> changes to kvmtool, both which I am posting separately.
>>
>> A branch containing all the relevant changes is at:
>> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/be-on-le-3.12-rc4
>>
>> Cc: Rusty Russell <rusty@rustcorp.com.au>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Pawel Moll <pawel.moll@arm.com>
> 
> We are changing the spec to make everything LE instead of
> the native endian.
> 
> I think that'll fix the issue in a cleaner way.

While I agree that it would solve the issue completely, it would also
break all BE users. Is that really an option?

The whole goal of this series is to implement something that gracefully
falls back to what we have today, not breaking anything in the process.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
