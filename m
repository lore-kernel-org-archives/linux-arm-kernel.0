From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Fri, 15 Jul 2016 10:14:43 +0200
Subject: [PATCH] media: Doc add missing documentation for
 samsung,exynos4212-jpeg
In-Reply-To: <578890BA.8040101@samsung.com>
References: <1468526499-8840-1-git-send-email-shuahkh@osg.samsung.com>
 <578890BA.8040101@samsung.com>
Message-ID: <57889B73.4090607@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 07/15/2016 09:28 AM, Krzysztof Kozlowski wrote:
> On 07/14/2016 10:01 PM, Shuah Khan wrote:
>> Add add missing documentation for samsung,exynos4212-jpeg codec,
>> reorder entries to improve readability and make it easier to add
>> new entries.
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>> ---
>>   Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt b/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt
>> index 38941db..093614c 100644
>> --- a/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt
>> +++ b/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt
>> @@ -3,9 +3,9 @@ Samsung S5P/EXYNOS SoC series JPEG codec
>>   Required properties:
>>
>>   - compatible	: should be one of:
>> -		  "samsung,s5pv210-jpeg", "samsung,exynos4210-jpeg",
>> -		  "samsung,exynos3250-jpeg", "samsung,exynos5420-jpeg",
>> -		  "samsung,exynos5433-jpeg";
>> +		  "samsung,s5pv210-jpeg", "samsung,exynos3250-jpeg",
>> +		  "samsung,exynos4210-jpeg", "samsung,exynos4212-jpeg",
>> +		  "samsung,exynos5420-jpeg", "samsung,exynos5433-jpeg";
>
> I am not convinced that this is needed because exynos4212-jpeg is equal
> to exynos4210-jpeg... It is a little bit weird because Jacek's commit
> 3246fdaa0ac2d9 ("[media] s5p-jpeg: Add support for Exynos3250 SoC")
> changed the driver data for Exynos4210 from S5P to Exynos4 without
> explaining it...

It was probably a bug fix since 4210 and 4212 have the same
JPEG IP. I agree that it isn't best practice to smuggle bug
fixes like that.

> However if these compatibles are exactly equal then
> only one should be preferred. It makes everything easier. Second can be
> still documented e.g. as deprecated.

Still, both of them are present in the driver. Shouldn't it be reflected
in the documentation?

-- 
Best regards,
Jacek Anaszewski
