From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 17 Aug 2016 12:28:48 +0200
Subject: [PATCH] ARM: dts: exynos: Use stdout non-deprecated property and
 add serial options to Odroid XU/XU3/XU4
In-Reply-To: <20160817102506.GD30900@leverpostej>
References: <1471419298-10414-1-git-send-email-k.kozlowski@samsung.com>
 <20160817102506.GD30900@leverpostej>
Message-ID: <bae50bce-8e56-62cc-89b4-68532c2acaf0@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2016 12:25 PM, Mark Rutland wrote:
> On Wed, Aug 17, 2016 at 09:34:58AM +0200, Krzysztof Kozlowski wrote:
>> The "linux,stdout-path" is deprecated.
>>
>> Add serial options so the console can be properly configured when
>> bootloader does not pass "console" parameter to command line.  Without
>> options and lack of "console", the serial output dies during boot (just
>> after probing sound).
> 
> I'm confused. Is this just a cleanup (given "linux,stdout-path" is
> deprecated but still supported), or a bug fix?

There is no bug, so rather this is cleanup and improvement in one.
Usually we pass full console=ttySAC2,115200n8 from UBoot to command
line. The usage of serial options allows skipping that.

I can split the cleanup part from improvement. To me it looked a little
bit too much but I don't mind.

> I guess that prior to this patch Linux might change the rate of the
> console, but otherwise it should work.

It still can be overridden by command line if needed.

Best regards,
Krzysztof
