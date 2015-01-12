From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 12 Jan 2015 17:38:50 +0900
Subject: [PATCHv7 05/10] devfreq: event: Add documentation for exynos-ppmu
 devfreq-event driver
In-Reply-To: <905389780.892831421050282747.JavaMail.weblogic@epmlwas09a>
References: <905389780.892831421050282747.JavaMail.weblogic@epmlwas09a>
Message-ID: <54B3881A.60407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Myungjoo,

On 01/12/2015 05:11 PM, MyungJoo Ham wrote:
> 
> I have rephrased part of the documentation for better readability.
> Some semantics is guessed so you may need to re-rephrase.
> 
> Other than that, Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

OK, I'll fix them according to your below comment.

Best Regards,
Chanwoo Choi

> 
> 
>>  This patch adds the documentation for Exynos PPMU (Platform Performance
>> Monitoring Unit) devfreq-event driver.
>>
>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  .../bindings/devfreq/event/exynos-ppmu.txt         | 110 +++++++++++++++++++++
>>  1 file changed, 110 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> new file mode 100644
>> index 0000000..e665d30
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> @@ -0,0 +1,110 @@
>> +
>> +* Samsung Exynos PPMU (Performance Profiling Monitoring Unit) device
>> +
>> +The Samsung Exynos SoC have PPMU (Performance Profiling Monitoring Unit) for
> 
> The Samsung Exynos SoC has PPMU (Performance Profiling Monitoring Unit) for
> (have->has)
> 
>> +each IPs. PPMU provides the primitive values to get performance data. These
> 
> each IP. PPMU provides primitive values to get performance data.
> (IPs->IP)
> 
>> +events provide useful information about the behavior of the SoC that you can
> 
> PPMU events provide information of the SoC's behaviors so that you may
> 
>> +use when analyzing system performance, and made visible and can be counted
> 
> use to analyze system performance, to make behaviors visible, and to count
> 
>> +using login in each IP (DMC, CPU, RIGHTBUS, LEFTBUS, CAM interface, LCD, G3D,
> 
> usages of each IP ( .... )
> 
>> +MFC). The Exynos PPMU driver use the devfreq-event class to provide event data
> 
> use -> uses
> 
>> +to various devfreq device. The devfreq device would use the event data when
> 
> device -> devices
> 
>> +derterming the current state of each IP.
>> +
>> +Required properties:
>> +- compatible: Should be "samsung,exynos-ppmu".
>> +- reg: physical base address of each PPMU and length of memory mapped region.
>> +
>> +Optional properties:
>> +- clock-names : the name of clock used by the PPMU, "ppmu"
>> +- clocks : phandles for clock specified in "clock-names" property
>> +- #clock-cells: should be 1.
>> +
> 
> []
> 
