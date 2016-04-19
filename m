From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 19 Apr 2016 10:19:11 +0200
Subject: [PATCH] pinctrl-exynos5440: Use off-stack memory for
 pinctrl_gpio_range
In-Reply-To: <CA+Ln22Fcdp=W1A7ZY5nNNkUqHWfTTepVBS+SzjdoeO2HDJGpuQ@mail.gmail.com>
References: <1461039222-26592-1-git-send-email-andrew@aj.id.au>
 <CA+Ln22Fcdp=W1A7ZY5nNNkUqHWfTTepVBS+SzjdoeO2HDJGpuQ@mail.gmail.com>
Message-ID: <5715E9FF.6080000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2016 09:24 AM, Tomasz Figa wrote:
> Hi Andrew,
> 
> 2016-04-19 13:13 GMT+09:00 Andrew Jeffery <andrew@aj.id.au>:
>> The range is registered into a linked list which can be referenced
>> throughout the lifetime of the driver. Ensure the range's memory is useful
>> for the same lifetime by adding it to the driver's private data structure.
>>
>> The bug was introduced in the driver's initial commit, which was present in
>> v3.10.
>>
>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> Fixes: f0b9a7e521fa ("pinctrl: exynos5440: add pinctrl driver for Samsung EXYNOS5440 SoC")
>> Cc: stable at vger.kernel.org
>> ---
>> This is my first contribution to the kernel, so hopefully I've followed all the
>> relevant documentation. If not, please let me know and point me in the right
>> direction!
>>
>> I don't have the means to test the patch, but it compiles. Someone with
>> appropriate hardware should probably give it a spin.
>>
> 
> Thanks for the patch. Good catch, I wonder how this even worked. Just
> one minor nitpick below.
> 
> Unfortunately I don't have any platform based on this SoC to test, so
> I'll defer to Krzysztof or Sylwester to handle this.

We don't have this board neither, it is not so popular and apparently
not many people are using it because such bug remained unnoticed.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
