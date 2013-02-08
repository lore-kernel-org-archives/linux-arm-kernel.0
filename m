From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 09 Feb 2013 00:30:54 +0100
Subject: [PATCH v4 06/10] s5p-fimc: Use pinctrl API for camera ports
 configuration
In-Reply-To: <5112EAF6.1040408@wwwdotorg.org>
References: <1359745771-23684-1-git-send-email-s.nawrocki@samsung.com>
 <1359745771-23684-7-git-send-email-s.nawrocki@samsung.com>
 <5112EAF6.1040408@wwwdotorg.org>
Message-ID: <51158AAE.7050003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2013 12:44 AM, Stephen Warren wrote:
> On 02/01/2013 12:09 PM, Sylwester Nawrocki wrote:
>> Before the camera ports can be used the pinmux needs to be configured
>> properly. This patch adds a function to set the camera ports pinctrl
>> to a default state within the media driver's probe().
>> The camera port(s) are then configured for the video bus operation.
>
>> diff --git a/Documentation/devicetree/bindings/media/soc/samsung-fimc.txt b/Documentation/devicetree/bindings/media/soc/samsung-fimc.txt
>
>> +- pinctrl-names    : pinctrl names for camera port pinmux control, at least
>> +		     "default" needs to be specified.
>> +- pinctrl-0...N	   : pinctrl properties corresponding to pinctrl-names
>> +
>
> A reference to the binding document describing the pin control bindings
> would be appropriate here. Given that reference, I'm not sure if
> spelling out the property names makes sense since it feels a little like
> duplication; an alternative might be simply:
>
> The pinctrl bindings defined in ../../../pinctrl/pinctrl-bindings.txt
> must be used to define a pinctrl state named "default".

OK, I will add a reference to the pinctrl bindings instead.

> However, this isn't a big deal; it's fine either way.

--

Thanks.
Sylwester
