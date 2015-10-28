From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 28 Oct 2015 16:57:30 +0900
Subject: [GIT PULL 4/5] Late Samsung driver updates for v4.4
In-Reply-To: <000101d11155$1f8d6eb0$5ea84c10$@samsung.com>
References: <562AA40E.4050407@kernel.org> <562AA603.7040600@kernel.org>
 <56307B33.90608@samsung.com> <000101d11155$1f8d6eb0$5ea84c10$@samsung.com>
Message-ID: <56307FEA.6090207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.10.2015 16:49, Pavel Fedin wrote:
>  Hello!
> 
>> The question is - do you prefer us to send a following up patch or to
>> fix it by amending the commit?
>>
>> Here is a fix which can be squashed into these two commits:
> 
>  By the way, since we are discussing fixing these commits...
>  After hardcoded SROMc handling has been removed, Exynos5410-based machines stopped handling it entirely, because the description
> has never been added to exynos5410.dtsi (which does not include exynos5.dtsi). Shouldn't the description be added there too?

No, it is not needed.
The Exynos5410 in current form does not have suspend capability. During
boot you should see in dmesg:
	Failed to find PMU node
coming from mach-exynos/suspend.c.

In suspend.c there is no compatible for Exynos5410.

Best regards,
Krzysztof
