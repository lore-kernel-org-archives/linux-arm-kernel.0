From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 08 Jul 2014 16:14:59 +0200
Subject: [PATCH v5 4/5] ARM: EXYNOS: Add platform driver support for Exynos
 PMU
In-Reply-To: <001e01cf9820$18f29440$4ad7bcc0$@samsung.com>
References: <1403705032-14835-1-git-send-email-pankaj.dubey@samsung.com>
 <1403705032-14835-5-git-send-email-pankaj.dubey@samsung.com>
 <53B198EB.80502@samsung.com> <001e01cf9820$18f29440$4ad7bcc0$@samsung.com>
Message-ID: <53BBFCE3.4050806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.07.2014 09:09, Pankaj Dubey wrote:
> On Monday, June 30, 2014 Tomasz Figa wrote:
>> On 25.06.2014 16:03, Pankaj Dubey wrote:
>>> +
>>> +	if (pmu_context->pmu_data && pmu_context->pmu_data->pmu_init)
>>
>> In what conditions pmu_data will be NULL?
>>
> 
> What if we want driver to be probed but no data has been given?
> If driver gets probed it still can act as syscon provider, and other IPs can
> access
> PMU registers, but PMU functionality itself will not be available, for same
> reason
> I have put a check for pmu_data in powerdown_conf also.
> 

Is there any point in probing this driver just to register the syscon?
AFAIK if this driver errors out, the syscon platform driver will take
over and do what we want. That's why we have the second "syscon"
compatible string.

Best regards,
Tomasz
