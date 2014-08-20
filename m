From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 20 Aug 2014 11:25:55 +0800
Subject: [PATCH v2 08/18] ARM64 / ACPI: Get the enable method for SMP
 initialization in ACPI way
In-Reply-To: <1408476326.22761.134.camel@smoke>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>		
 <1407166105-17675-9-git-send-email-hanjun.guo@linaro.org>	
 <1408388212.22761.100.camel@smoke> <53F33EDC.3090203@linaro.org>
 <1408476326.22761.134.camel@smoke>
Message-ID: <53F41543.4090602@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-8-20 3:25, Geoff Levand wrote:
> Hi Hanjun,
> 
> On Tue, 2014-08-19 at 20:11 +0800, Hanjun Guo wrote:
>> On 2014-8-19 2:56, Geoff Levand wrote:
> 
>>> 	message = acpi_disabled ? dn->full_name : "";
>>>
>>> 	...
>>> 	
>>> 	pr_warn("CPU %d: %s unsupported enable-method property: %s\n",
>>> 				cpu, message, enable_method)
>>
>> In ACPI, there is no enable-method property, it is a term from, so I think the
>> message printed can be separated.
> 
> I think it better to have a single message that can cover all
> than to have separate messages.  Wouldn't the enable method be
> "acpi-parking" or "acpi-psci"?  Then something like this would
> work:
> 
> 	pr_warn("CPU %d: %s Unsupported enable method: %s\n", cpu, message, enable_method);

Thanks for the suggestion, I will update it in next version.

Thanks
Hanjun
