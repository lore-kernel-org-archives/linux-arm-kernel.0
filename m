From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 29 Oct 2015 10:10:05 +0300
Subject: [PATCH] ARM: exynos: Bring back reboot on Exynos5410
In-Reply-To: <CAGcde9H4WVt34rn6_9H+sVu2Bp2xq4awMiwV1zgv1D6posPWSg@mail.gmail.com>
References: <1446024965-8508-1-git-send-email-p.fedin@samsung.com>
 <56317960.9070608@samsung.com>
 <CAGcde9H4WVt34rn6_9H+sVu2Bp2xq4awMiwV1zgv1D6posPWSg@mail.gmail.com>
Message-ID: <006c01d11218$d6e2d500$84a87f00$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> Patch looks ok, but after Alim's patch series [1] to handle poweroff
> and reboot via generic syscon based driver gets merged, this will
> become redundant entry into PMU driver in the absence of any PMU  data
> for Exynos5410. Alim has taken care of adding power-off and reboot
> device node in exynos5410.dtsi [2].
> 
> [1]: http://www.spinics.net/lists/devicetree/msg98858.html
> [2]: http://www.spinics.net/lists/devicetree/msg98862.html

 I looked at those patches, IMHO they are too large for doing too small thing. What they do is basically describing two registers one-by-one and adding a separate per-register driver. Isn't it too much just for pushing a reset pin?
 May be we should just invent some generic "compatible" string, like "samsung,exynos-pmu" (or "Samsung,exynos-pmu-generic", if you want to be more specific), which would do the same as my patch currently does? This would be only several lines of code, achieving the same result.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
