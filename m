From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 23 Dec 2011 13:18:51 +0000
Subject: [PATCH v4 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <1324537753-30590-5-git-send-email-richard.zhao@linaro.org>
References: <1324537753-30590-1-git-send-email-richard.zhao@linaro.org>
 <1324537753-30590-5-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111223131851.GB13175@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 03:09:10PM +0800, Richard Zhao wrote:
> The driver get cpu operation point table from device tree cpu0 node,
> and adjusts operating points using clk and regulator APIs.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but one nit:

> +Required properties in /cpus/cpu at 0:
> +- cpu-freqs : cpu frequency points it support, in unit of Hz.
> +- cpu-volts : cpu voltages required by the frequency point at the same index,
> +	      in unit of uV.
> +- trans-latency :  transition_latency, in unit of ns.

trans-latency should really say what latency is being measured (the CPU
core only or the whole operation).
