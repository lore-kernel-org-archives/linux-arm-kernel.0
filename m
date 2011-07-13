From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 13 Jul 2011 09:40:35 -0700
Subject: [PATCH 2/3] mach-ux500: export System-on-Chip information via
	sysfs
In-Reply-To: <4E1D4F88.3070501@linaro.org>
References: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>	<1310476090-9807-2-git-send-email-lee.jones@linaro.org>	<4E1C7650.6010700@codeaurora.org>
	<4E1D4F88.3070501@linaro.org>
Message-ID: <4E1DCA83.7010204@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2011 12:55 AM, Lee Jones wrote:
> On 12/07/11 17:29, Saravana Kannan wrote:
>> Can you please make this code as part of soc_device_register? Otherwise,
>> every SoC that wants to add its own set of attributes will have to
>> repeat this code.
>
> That's the idea.
>
> I initially had it all as part of soc_device_register, but Arnd told me
> to remove it in this patch-set.
>
> See here:
>
> On 17/04/11 19:36, Arnd Bergmann wrote:
>> For the nonstandard attributes, I would recommend having the individual
>> drivers call device_create_file, in order to discourage the use of
>> device specific attribute names.

Arnd,

I don't think forcing individual driver to call device_create_file() is 
really going to be much of a discouragement. If someone thinks they need 
to export some info, they are going to do it and end up with repeated 
code. The only real discouragement in my opinion would be code review.

Can we please pull the creation of extra attributes into the common code?

Thanks,
Saravana

>
> Hence all of these are the _standard_ attributes:
>
>>> +    .get_machine_fn  = ux500_get_machine,
>>> +    .get_family_fn   = ux500_get_family,
>>> +    .get_soc_id_fn   = ux500_get_soc_id,
>>> +    .get_revision_fn = ux500_get_revision,
>
> And this is the _non standard_ one:
>>> +    __ATTR(process,  S_IRUGO, ux500_get_process,  NULL),
>
> Which is subsequently added by the platform.
>
> Kind regards,
> Lee
>


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
