From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Jan 2018 12:28:09 +0000
Subject: [PATCH v2 08/16] arm/arm64: KVM: Advertise SMCCC v1.1
In-Reply-To: <20180130002328.GB9418@n2100.armlinux.org.uk>
References: <20180129174559.1866-1-marc.zyngier@arm.com>
 <20180129174559.1866-9-marc.zyngier@arm.com>
 <20180130002328.GB9418@n2100.armlinux.org.uk>
Message-ID: <9099a76f-2235-59e6-e7eb-b924fa4bbf54@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/01/18 00:23, Russell King - ARM Linux wrote:
> On Mon, Jan 29, 2018 at 05:45:51PM +0000, Marc Zyngier wrote:
>> The new SMC Calling Convention (v1.1) allows for a reduced overhead
>> when calling into the firmware, and provides a new feature discovery
>> mechanism.
>>
>> Make it visible to KVM guests.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  Documentation/virtual/kvm/arm/psci.txt | 12 +++++++-----
>>  arch/arm/kvm/handle_exit.c             |  2 +-
>>  arch/arm64/kvm/handle_exit.c           |  2 +-
>>  include/kvm/arm_psci.h                 |  2 +-
>>  include/linux/arm-smccc.h              | 13 +++++++++++++
>>  virt/kvm/arm/psci.c                    | 24 +++++++++++++++++++++++-
>>  6 files changed, 46 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/virtual/kvm/arm/psci.txt b/Documentation/virtual/kvm/arm/psci.txt
>> index 2e49a4e9f084..aafdab887b04 100644
>> --- a/Documentation/virtual/kvm/arm/psci.txt
>> +++ b/Documentation/virtual/kvm/arm/psci.txt
>> @@ -13,7 +13,7 @@ a migration causes a different PSCI version to be exposed out of the
>>  blue to an unsuspecting guest.
>>  
>>  In order to remedy this situation, KVM exposes a set of "firmware
>> -pseuodo-registers" that can be manipulated using the GET/SET_ONE_REG
>> +pseudo-registers" that can be manipulated using the GET/SET_ONE_REG
> 
> This should surely be in patch 7?

Indeed. Thanks for the heads up.

	M.
-- 
Jazz is not dead. It just smells funny...
