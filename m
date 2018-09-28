From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 28 Sep 2018 10:51:16 -0700
Subject: [PATCH 0/3] ARM/PSCI: Fix THUMB2_KERNEL entry points
In-Reply-To: <c68b01ab-9077-73cc-8356-25a4e3a909f0@arm.com>
References: <20180927192711.26455-1-f.fainelli@gmail.com>
 <c68b01ab-9077-73cc-8356-25a4e3a909f0@arm.com>
Message-ID: <26239d41-0d58-43fd-89e9-1576c84f89f2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2018 01:08 AM, Robin Murphy wrote:
> On 2018-09-27 8:27 PM, Florian Fainelli wrote:
>> Hi all,
>>
>> While playing with THUMB2_KERNEL on ARCH_BRCMSTB, several issues came up
>> which are addressed by these 3 patches.
> 
> Hmmm, PSCI looks to explicitly support Thumb entrypoints ("T32 support"
> in section 6.4.3 of DEN0022D), so these changes smell a little of
> papering over a more fundamental problem, which is presumably either
> that Thumb symbols are not being resolved correctly, or that the
> firmware you're using has a bug.

Yes, I clearly missed that during the internal review of our
implementation and missed it again prior to submitting those patches,
shame on me.

The last patch is valid because it addresses a problem on 32-bit only
platforms which do not have a PSCI firmware at that point.

Thanks!
-- 
Florian
