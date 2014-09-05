From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 05 Sep 2014 12:58:15 -0700
Subject: [PATCH v5 7/7] arm: dts: qcom: Add idle states device nodes for
 8974
In-Reply-To: <1409870132-16929-8-git-send-email-lina.iyer@linaro.org> (Lina
 Iyer's message of "Thu, 4 Sep 2014 16:35:32 -0600")
References: <1409870132-16929-1-git-send-email-lina.iyer@linaro.org>
 <1409870132-16929-8-git-send-email-lina.iyer@linaro.org>
Message-ID: <7hmwadyh48.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> Add allowable C-States for each cpu using the cpu-idle-states node.
> ARM spec dictates WFI as the default idle state at 0. Support standalone
> power collapse (power down that does not affect any SoC idle states) for
> each cpu.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

[...]

> @@ -55,6 +59,22 @@
>  			cache-level = <2>;
>  			qcom,saw = <&saw_l2>;
>  		};
> +
> +		idle-states {
> +			CPU_WFI: cpu-idle-state-0 {
			         ^^^^^^^^^^^^^^^^
Minor nit:

This name is what's being used to populate the idle state's ->name field
in the CPUidle driver, which in turn is used by tools like powertop to
display state names, etc.

So first, that name field has to be short (it currently gets truncated,
dropping the zero), and second that field should be more descriptive,
like 'WFI', so viewing in the various tools shows something useful.

Thanks,

Kevin
