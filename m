From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 20 Jun 2013 19:39:59 +0100
Subject: [PATCH v2] ARM/KVM: save and restore generic timer registers
In-Reply-To: <20130620183221.GE4563@lvm>
References: <1370963819-26165-1-git-send-email-andre.przywara@linaro.org>
 <51C2D528.90805@arm.com> <20130620170923.GA4563@lvm>
 <51C339BD.2080600@arm.com> <20130620183221.GE4563@lvm>
Message-ID: <51C34C7F.6030309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/13 19:32, Christoffer Dall wrote:

>> So there is just one thing we absolutely need to make sure here: no vcpu
>> can run before they've all had their timer restored, and hence a stable
>> cntvoff. Otherwise two vcpus will have a different view of time.
>>
>> Can we guarantee this?
>>
> 
> Do we need to?  User space is free to modify time and all sort of other
> registers at any point during VM execution - it will just break the
> guest that it's running.
> 
> I think the key here is that we expect the VM to be stopped for all
> save/restore operations (we can enforce it if we want to, which I am
> going to for the VGIC state, because we don't want to interfere with
> consistent state being written to the hardware).

If that's what we expect, then it's fine by me.

	M.
-- 
Jazz is not dead. It just smells funny...
