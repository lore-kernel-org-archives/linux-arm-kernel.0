From: evgreen@chromium.org (Evan Green)
Date: Fri, 11 May 2018 14:30:16 -0700
Subject: [PATCH v4 4/7] interconnect: qcom: Add RPM communication
In-Reply-To: <20180309210958.16672-5-georgi.djakov@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-5-georgi.djakov@linaro.org>
Message-ID: <CAE=gft6HTU76M8AqzvN-VeDWE6c8Bgk+TimHHLMfLztWYhCSYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 9, 2018 at 1:11 PM Georgi Djakov <georgi.djakov@linaro.org>
wrote:

> On some Qualcomm SoCs, there is a remote processor, which controls some of
> the Network-On-Chip interconnect resources. Other CPUs express their needs
> by communicating with this processor. Add a driver to handle comminication
> with this remote processor.

> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>   .../devicetree/bindings/interconnect/qcom-smd.txt  | 31 ++++++++
>   drivers/interconnect/qcom/Makefile                 |  1 +
>   drivers/interconnect/qcom/smd-rpm.c                | 90
++++++++++++++++++++++
>   drivers/interconnect/qcom/smd-rpm.h                | 15 ++++
>   4 files changed, 137 insertions(+)
>   create mode 100644
Documentation/devicetree/bindings/interconnect/qcom-smd.txt
>   create mode 100644 drivers/interconnect/qcom/Makefile
>   create mode 100644 drivers/interconnect/qcom/smd-rpm.c
>   create mode 100644 drivers/interconnect/qcom/smd-rpm.h

> diff --git a/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
> new file mode 100644
> index 000000000000..14e83ed7019b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
> @@ -0,0 +1,31 @@
> +Qualcomm SMD-RPM interconnect driver binding
> +------------------------------------------------
> +The RPM is a dedicated hardware engine for managing the shared
> +SoC resources in order to keep the lowest power profile. It
> +communicates with other hardware subsystems via shared memory
> +and accepts requests for various resources.

You never say what RPM or SMD stands for. RPM is Resource Power Manager,
right? But I'm not in the know about SMD. Can you define these somewhere?

-Evan
