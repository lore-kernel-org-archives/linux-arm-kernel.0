From: robh@kernel.org (Rob Herring)
Date: Fri, 18 May 2018 09:26:39 -0500
Subject: [PATCH v8 11/15] dt-bindings: cpufreq: Document
 operating-points-v2-kryo-cpu
In-Reply-To: <1526555955-29960-12-git-send-email-ilialin@codeaurora.org>
References: <1526555955-29960-1-git-send-email-ilialin@codeaurora.org>
 <1526555955-29960-12-git-send-email-ilialin@codeaurora.org>
Message-ID: <20180518142639.GA3877@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 02:19:11PM +0300, Ilia Lin wrote:
> The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> to provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each OPP of
> operating-points-v2 table when it is parsed by the OPP framework.
> 
> This change adds documentation for the DT bindings.
> The "operating-points-v2-kryo-cpu" DT extends the "operating-points-v2"
> with following parameters:
> - nvmem-cells (NVMEM area containig the speedbin information)
> - opp-supported-hw: A single 32 bit bitmap value,
>   representing compatible HW:
> 			0:	MSM8996 V3, speedbin 0
> 			1:	MSM8996 V3, speedbin 1
> 			2:	MSM8996 V3, speedbin 2
> 			3:	unused
> 			4:	MSM8996 SG, speedbin 0
> 			5:	MSM8996 SG, speedbin 1
> 			6:	MSM8996 SG, speedbin 2
> 			7-31:	unused
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/opp/kryo-cpufreq.txt       | 680 +++++++++++++++++++++
>  1 file changed, 680 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/kryo-cpufreq.txt

Reviewed-by: Rob Herring <robh@kernel.org>
