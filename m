From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 30 Jul 2013 15:40:25 -0600
Subject: [PATCH] ARM: kexec: validate CPU hotplug support
In-Reply-To: <51E958CC.5070906@wwwdotorg.org>
References: <1373582931-11956-1-git-send-email-swarren@wwwdotorg.org>
 <51E958CC.5070906@wwwdotorg.org>
Message-ID: <51F832C9.9000900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/2013 09:18 AM, Stephen Warren wrote:
> On 07/11/2013 04:48 PM, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Architectures should fully validate whether kexec is possible as part of
>> machine_kexec_prepare(), so that user-space's kexec_load() operation can
>> report any problems. Performing validation in machine_kexec() itself is
>> too late, since it is not allowed to return.
>>
>> Prior to this patch, ARM's machine_kexec() was testing after-the-fact
>> whether machine_kexec_prepare() was able to disable all but one CPU.
>> Instead, modify machine_kexec_prepare() to validate all conditions
>> necessary for machine_kexec_prepare()'s to succeed. BUG if the validation
>> succeeded, yet disabling the CPUs didn't actually work.
> 
> Russell, does this look good to put into the ARM patch tracker?

I put this in the patch tracker since I assume that no response means no
objection.
