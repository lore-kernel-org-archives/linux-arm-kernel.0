From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 21 Oct 2017 22:14:01 +0200
Subject: [PATCH] ARM: dts: exynos: add cpu perf counters to Exynos54xx
 boards
In-Reply-To: <CAM3PiRyEdXX26aBfuS=3rQK3k7ovR=HeeoF8Qcz0Dt-zdiXuww@mail.gmail.com>
References: <CAM3PiRxi8sxf6T990K8rd7UsOLd2D5TaLciF=c_wF=9gmpLKYg@mail.gmail.com>
 <e2b87fe2-bc04-242d-8f4f-9cd21743e3aa@arm.com>
 <CAM3PiRyEdXX26aBfuS=3rQK3k7ovR=HeeoF8Qcz0Dt-zdiXuww@mail.gmail.com>
Message-ID: <20171021201401.enzhfzjkzyihtjvv@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 21, 2017 at 05:54:31PM +1030, Marian Mihailescu wrote:
> Hi Robin,
> 
> Apologies, I did not really check which cluster is described for the
> 5410 (since 5422 boots from the A7).
> 
> Should I define both pmu nodes (w/o interrupt affinity) in the
> exynos54xx,dtsi, and set the status property to "disabled"?
> And then add the interrupt affinity to the SoC variant, and enable
> them as required...

After putting it under common exynos54xx you would have to anyway
override/extend most of the nodes so I think there is no much sense for
that. Instead it should be in exynos5410.dtsi and exynos5422.dtsi.

> 
> The problem that I see however is that, while 5410 is easy to deal
> with (it has the cpus defined in exynos5420.dtsi for all boards), 542x
> variants have the cpus included in the board dts. So there would be
> the same pmu nodes with interrupt affinity copied in all 542x and 5800
> boards dts (and there are several of them), instead of being included
> in exynos542x.dtsi...

You mean exynos5420-cpus.dtsi, not board DTS?

For exynos542x/5800 you could indeed add it directly to
exynos542x-cpus.dtsi, following existing pattern about cpus (with
comment).


Best regards,
Krzysztof
