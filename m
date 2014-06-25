From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 25 Jun 2014 02:11:41 +0200
Subject: [PATCH v4 10/11] ARM: EXYNOS: Add platform driver support for
 Exynos PMU.
In-Reply-To: <007a01cf8f9f$7909c850$6b1d58f0$@samsung.com>
References: <1399704998-13321-1-git-send-email-pankaj.dubey@samsung.com>
 <1399704998-13321-11-git-send-email-pankaj.dubey@samsung.com>
 <53A07719.7050206@samsung.com> <007a01cf8f9f$7909c850$6b1d58f0$@samsung.com>
Message-ID: <53AA13BD.9060800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.06.2014 13:28, Pankaj Dubey wrote:
> On Tuesday, June 17 2014, Tomasz Figa wrote:
>> On 10.05.2014 08:56, Pankaj Dubey wrote:

[snip]

>>> +
>>> +	ret = platform_driver_register(&exynos_pmu_driver);
>>> +	if (ret < 0)
>>> +		goto out;
>>> +
>>> +	exynos_pmu_pdev = platform_device_register_simple("exynos-pmu", -1,
>>> +			NULL, 0);
>>
>> Hmm, I don't see the point of making this a platform driver only to
> register respective
>> platform device few lines below. If you take into account the patch for
> syscon I
>> posted as a reply to patch 06/11, you will be able to make this a normal
> platform
>> driver that binds to DT node directly and then register a syscon in probe
> function
>> above.
>>
> 
> Well I updated PMU to be a syscon provider using your patch. It worked well.
> I have following two points to mention here:
> 
> 1: For making PMU a normal platform driver, other than making PMU a syscon
> provider we need to change PMU's DT binding. Basically we need to remove
> "syscon"
> as second compatibility string. I hope this should not be an issue.

I don't see the reason for this. Could you elaborate on this?

I know that the way Linux currently handles multiple compatible strings
is broken, but despite this, if you just make sure your platform driver
registers before syscon platform driver, it should be fine.

> 
> 2: I can see for your syscon patch Arnd has some comments, hopefully we can
> address
> his concern.
> 

Yes. I will get to it after sorting out few other things from my queue.
Or you can do it if you want - the purpose of that RFC patch was just to
show the idea I had in my mind.

Best regards,
Tomasz
