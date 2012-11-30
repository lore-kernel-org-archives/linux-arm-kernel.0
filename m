From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 30 Nov 2012 12:34:22 -0700
Subject: [PATCH V7 1/7] kbuild: centralize .dts->.dtb rule
In-Reply-To: <50B8D86E.1080109@gmail.com>
References: <1354058956-7199-1-git-send-email-swarren@wwwdotorg.org>
 <50B8D86E.1080109@gmail.com>
Message-ID: <50B90A3E.4080203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2012 09:01 AM, Rob Herring wrote:
> On 11/27/2012 05:29 PM, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> All architectures that use cmd_dtc do so in almost the same way. Create
>> a central build rule to avoid duplication. The one difference is that
>> most current uses of dtc build $(obj)/%.dtb from $(src)/dts/%.dts rather
>> than building the .dtb in the same directory as the .dts file. This
>> difference will be eliminated arch-by-arch in future patches.
>>
>> MIPS is the exception here; it already uses the exact same rule as the
>> new common rule, so the duplicate is removed in this patch to avoid any
>> conflict. arch/mips changes courtesy of Ralf Baechle.
>>
>> Update Documentation/kbuild to remove the explicit call to cmd_dtc from
>> the example, now that the rule exists in a centralized location.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: Olof Johansson <olof@lixom.net>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Jonas Bonn <jonas@southpole.se>
>> Cc: linux at lists.openrisc.net
>> Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
>> Cc: linux-c6x-dev at linux-c6x.org
>> Cc: Mark Salter <msalter@redhat.com>
>> Cc: Michal Simek <monstr@monstr.eu>
>> Cc: microblaze-uclinux at itee.uq.edu.au
>> Cc: Chris Zankel <chris@zankel.net>
>> Cc: linux-xtensa at linux-xtensa.org
>> Cc: Max Filippov <jcmvbkbc@gmail.com>
>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> This is based on next-20121126.
>>
> 
> I'll apply the series but I need a stable base. Looks like xtensa has
> the dependency. Or I can just drop xtensa.

I was assuming this series would be applied for 3.9, hence hadn't
rebased it onto anything stable yet. Are you wanting to apply it
earlier? If so, I'll look into how it fits on top of 3.7-rc7.
