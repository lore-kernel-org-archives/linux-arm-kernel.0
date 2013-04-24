From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 24 Apr 2013 14:46:44 +0100
Subject: [PATCH v3 29/32] arm64: KVM: 32bit guest fault injection
In-Reply-To: <20130423230214.GM20569@gmail.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-30-git-send-email-marc.zyngier@arm.com>
 <20130423230214.GM20569@gmail.com>
Message-ID: <5177E244.9000404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/13 00:02, Christoffer Dall wrote:
> On Mon, Apr 08, 2013 at 05:17:31PM +0100, Marc Zyngier wrote:
>> Add fault injection capability for 32bit guests.
> 
> looks ok, but seems we are duplicating some functionality here, but I
> realize it may not be that easy to share due to different define names
> for things like PSR_X_BIT...  Did you look further into this?

I did, but as you noticed, the namespaces are different. We could
probably define a set of KVM_AARCH32_* symbols, but I'm not sure it
would be any nicer though.

	M.
-- 
Jazz is not dead. It just smells funny...
