From: ben@smart-cactus.org (Ben Gamari)
Date: Thu, 03 Dec 2015 11:30:16 +0100
Subject: [PATCH 02/12] clk: samsung: exynos5420: add cpu clock
 configuration data and instantiate cpu clock
In-Reply-To: <565FDC5A.1010504@samsung.com>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
 <1449091167-20758-3-git-send-email-ben@smart-cactus.org>
 <565FDC5A.1010504@samsung.com>
Message-ID: <874mfz4yfb.fsf@smart-cactus.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:

> On 03.12.2015 06:19, Ben Gamari wrote:
>> From: Thomas Abraham <thomas.ab@samsung.com>
>> 
>> With the addition of the new Samsung specific cpu-clock type, the
>> arm clock can be represented as a cpu-clock type. Add the CPU clock
>> configuration data and instantiate the CPU clock type for Exynos5420.
>> 
>> Changes by Bartlomiej:
>> - split Exynos5420 support from the original patches
>> - moved E5420_[EGL,KFC]_DIV0() macros to clk-exynos5420.c
>> 
>> Changes by Ben Gamari:
>> - Rebased
>
> If only rebasing then you should retain the Lukasz's review tag. He
> doesn't have to review it again, right? :)

Yep, very true.

>> +static const struct exynos_cpuclk_cfg_data exynos5420_eglclk_d[] __initconst = {
>> +	{ 1800000, E5420_EGL_DIV0(3, 7, 7, 4), },
>> +	{ 1700000, E5420_EGL_DIV0(3, 7, 7, 3), },
>> +	{ 1600000, E5420_EGL_DIV0(3, 7, 7, 3), },
>> +	{ 1500000, E5420_EGL_DIV0(3, 7, 7, 3), },
>> +	{ 1400000, E5420_EGL_DIV0(3, 7, 7, 3), },
>> +	{ 1300000, E5420_EGL_DIV0(3, 7, 7, 2), },
>> +	{ 1200000, E5420_EGL_DIV0(3, 7, 7, 2), },
>> +	{ 1100000, E5420_EGL_DIV0(3, 7, 7, 2), },
>> +	{ 1000000, E5420_EGL_DIV0(3, 6, 6, 2), },
>> +	{  900000, E5420_EGL_DIV0(3, 6, 6, 2), },
>> +	{  800000, E5420_EGL_DIV0(3, 5, 5, 2), },
>> +	{  700000, E5420_EGL_DIV0(3, 5, 5, 2), },
>> +	{  600000, E5420_EGL_DIV0(3, 4, 4, 2), },
>> +	{  500000, E5420_EGL_DIV0(3, 3, 3, 2), },
>> +	{  400000, E5420_EGL_DIV0(3, 3, 3, 2), },
>> +	{  300000, E5420_EGL_DIV0(3, 3, 3, 2), },
>> +	{  200000, E5420_EGL_DIV0(3, 3, 3, 2), },
>> +	{  0 },
>
> The vendor code (Galaxy S5 with Exynos5422) sets pclk_dbg divider to 7.
> In the same time APLL divider is only 1.
>
> For the ACLK divider (of KFC below) the vendor sets 3, not 2.
>
> The values also don't match the Exynos5420 from Note 3.
>
> The Exynos5800 apparently has values more similar to 5422.
>
> The question is: for which exact model this is? We can of course choose
> the safest values here but probably these would be with the highest
> dividers?
>
I'm afraid I can't comment here. Thomas, perhaps you could offer some
insight?

Cheers,

- Ben
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 472 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151203/8e177acc/attachment.sig>
