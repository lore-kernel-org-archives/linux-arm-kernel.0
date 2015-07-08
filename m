From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 8 Jul 2015 07:15:42 -0700
Subject: [PATCH 0/4] ARM: dts: Use labels instead of full paths for
 Exynos5 pinctrl nodes
In-Reply-To: <559CDEDA.50608@samsung.com>
References: <1436333790-18219-1-git-send-email-javier@osg.samsung.com>
 <559CDEDA.50608@samsung.com>
Message-ID: <559D308E.3020809@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof,

On 07/08/2015 01:27 AM, Krzysztof Kozlowski wrote:
> On 08.07.2015 14:36, Javier Martinez Canillas wrote:
>> Hello Kukjin and Krzysztof,
>>
>> This is a trivial series that changes Exynos5 pinctrl dtsi files to extend
>> the pinctrl nodes using labels instead of full paths.
>>
>> Using labels is less error prone since a misstyped label leads to a build
>> error while full paths can lead to the creation of a new node instead of
>> overriding the original which makes the mistake harder to detect.
>>
>> I tested the changes by decompiling the Exynos5* dtbs and comparing before
>> and after. The resulting dts were identical modulo some node ordering due
>> the pinctrl include change.
> 
> Is the DTB before and after the same? It should not change by re-ordering.
>

The DTB differ but I'm not that familiar with how dtc represents the FDT
to know what is changing in the binary.

But as mentioned, the decompiled DTS only changes in which position the
pinctrl are defined and both DTS are identical if I do:

$ cat decompiled.dts | sort

> Best regards,
> Krzysztof
> 

-- 
Javier Martinez Canillas
Sr. Linux Kernel Developer
Open Source Group
Samsung Research America
