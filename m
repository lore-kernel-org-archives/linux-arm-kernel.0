From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 13 Nov 2017 12:30:35 +0100
Subject: [PATCH v2 1/2] ARM: dts: exynos: Switch to dedicated Odroid-XU3
 sound card binding
In-Reply-To: <20171110171417.qbnn7gsihor2fwng@kozik-lap>
References: <20171103165446.15438-1-s.nawrocki@samsung.com>
 <CGME20171103165539epcas1p48cc87811574dace9dfe91d8e9ec6f7ca@epcas1p4.samsung.com>
 <20171103165446.15438-2-s.nawrocki@samsung.com>
 <20171110171417.qbnn7gsihor2fwng@kozik-lap>
Message-ID: <6ffab0bd-abc7-be8a-38f0-695269271427@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2017 06:14 PM, Krzysztof Kozlowski wrote:
> On Fri, Nov 03, 2017 at 05:54:45PM +0100, Sylwester Nawrocki wrote:
>> The new sound card DT binding is used for Odroid XU3 in order
>> to properly support the HDMI audio path.
>> Clocks configuration is changed so the I2S controller is now the bit
>> and the frame clock master with EPLL as the root clock source.
>
> Patch looks good but I do not understand this last sentence. What did
> you want to say?

Which part is hard to understand exactly? Perhaps this is clearer?

"Clocks configuration is changed so the I2S controller is now the bit
clock and the frame clock master.  The EPLL output clock is now the 
audio root clock adjusted to each audio sample rate."

Previously the CODEC's internal PLL was used for generating the I2S
bit and frame clocks accorrding to each audio sample rate.

-- 
Regards,
Sylwester
