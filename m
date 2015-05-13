From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Wed, 13 May 2015 18:51:26 +0900
Subject: [PATCH v4 02/13] ARM: dts: exynos4: Use labels for overriding
 nodesin Exynos4210
In-Reply-To: <5553130D.3010909@kernel.org>
References: <1431351773-2031-1-git-send-email-k.kozlowski.k@gmail.com>
 <1431351773-2031-3-git-send-email-k.kozlowski.k@gmail.com>
 <5553130D.3010909@kernel.org>
Message-ID: <55531E9E.2030805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 13.05.2015 o 18:02, Kukjin Kim pisze:
> On 05/11/15 22:42, Krzysztof Kozlowski wrote:
>> Usage of labels instead of full paths reduces possible mistakes when
>> overriding nodes.
>>
> Well, I'm not sure what kind of the possible mistakes you mentioned...?

One can make a mistake in path when overriding. For example we have:
exynos4.dtsi:
/ {
	gic: interrupt-controller at 10490000 {
		...
	};
}

and someone can add in child dtsi (like exynos4210.dtsi):
/ {
	soc {
		interrupt-controller at 10490000 {
			cpu-offset = <0x8000>;
		}
	}
}

or he can make a mistake in address.

As a result the gic node won't be properly overridden.

> 
> I don't think we need to use the label for gic, combiner.

They are overridden by child DTSI. First definition is in exynos4.dtsi
and exynos4210.dtsi adds a cpu-offset.

Best regards,
Krzysztof
