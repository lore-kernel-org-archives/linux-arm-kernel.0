From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 23 Jun 2015 08:04:58 +0530
Subject: [PATCH 8/8] dt: cpufreq: st: Provide bindings for ST's CPUFreq
 implementation
In-Reply-To: <1434987837-24212-9-git-send-email-lee.jones@linaro.org>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-9-git-send-email-lee.jones@linaro.org>
Message-ID: <20150623023458.GC16776@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding Rob]

On 22-06-15, 16:43, Lee Jones wrote:

At least some description was required here on why you need additional
bindings are what are they.

Over that, this patch should have been present before any other
patches using these bindings.

> Cc: devicetree at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-st.txt     | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> new file mode 100644
> index 0000000..cfa8952
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> @@ -0,0 +1,48 @@
> +Binding for ST's CPUFreq driver
> +===============================

OPP-v2 bindings are out now and you can probably use them to make life
simple, they are part of Rafael's recent pull request:
https://lkml.org/lkml/2015/6/22/606

> +Required properties:
> +-------------------
> +- compatible		: Supported values are:
> +				"st,stih407-cpufreq"

Nodes for virtual devices aren't allowed in DT.

> +Required properties [for working voltage scaling]:
> +-------------------------------------------------
> +
> +Located in CPUFreq's node:
> +
> +- st,syscfg		: Phandle to Major number register
> +				First cell: offset to major number
> +- st,syscfg-eng		: Phandle to Minor number and Pcode registers
> +				First cell: offset to process code
> +				Second cell: offset to minor number
> +
> +Located in CPU's node:
> +
> +- st,opp-list		: Bootloader provided node containing one or more 'opp at X' sub-nodes

I can see that this will be passed in from the bootloader. But at
least an example on how exactly things would actually look would have
been good. In logs if not in this file.

-- 
viresh
