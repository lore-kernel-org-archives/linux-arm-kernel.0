From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Oct 2018 12:47:16 +0100
Subject: [PATCH v5 11/17] arm64: docs: document pointer authentication
In-Reply-To: <20181019113556.ljbdmjo5pdw7muvz@mbp>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-12-kristina.martsenko@arm.com>
 <9acb0cd2-66b0-1c41-b1a8-7c70608e9a9b@foss.arm.com>
 <7b0de19b-45b9-f4df-25d1-c7e80fab49dc@arm.com>
 <20181019113556.ljbdmjo5pdw7muvz@mbp>
Message-ID: <05738017-5886-fe4d-e8fd-a834da6b1576@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/10/18 12:35, Catalin Marinas wrote:
> On Tue, Oct 16, 2018 at 05:14:39PM +0100, Kristina Martsenko wrote:
>> On 05/10/2018 10:04, Ramana Radhakrishnan wrote:
>>> On 05/10/2018 09:47, Kristina Martsenko wrote:

[...]

>> The other option is to turn off trapping entirely. However then on a
>> big.LITTLE system with mismatched pointer authentication support
>> instructions will work intermittently on some CPUs but not others.
> 
> That's another case but let's assume we never see such configurations ;).

I'd like to put it on the record that I'm not willing to support such a
configuration. So my ask is that if we detect a system where only some
of the CPUs have pointer authentication support, we either:

1) prevent some of the CPUs from booting (that's harsh)
2) disable KVM (that's easy)

I'm perfectly happy with (2).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
