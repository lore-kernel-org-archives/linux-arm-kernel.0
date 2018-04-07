From: swboyd@chromium.org (Stephen Boyd)
Date: Sat, 07 Apr 2018 05:33:00 -0700
Subject: [PATCH 2/2] pinctrl: qcom: qdf2xxx: add support for new ACPI HID
 QCOM8002
In-Reply-To: <1521848700-22214-2-git-send-email-timur@codeaurora.org>
References: <1521848700-22214-1-git-send-email-timur@codeaurora.org>
 <1521848700-22214-2-git-send-email-timur@codeaurora.org>
Message-ID: <152310438008.180276.15989327938738839272@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Timur Tabi (2018-03-23 16:45:00)
> Newer versions of the firmware for the Qualcomm Datacenter Technologies
> QDF2400 restricts access to a subset of the GPIOs on the TLMM.  To
> prevent older kernels from accidentally accessing the restricted GPIOs,
> we change the ACPI HID for the TLMM block from QCOM8001 to QCOM8002,
> and introduce a new property "gpios".  This property is an array of
> specific GPIOs that are accessible.  When an older kernel boots on
> newer (restricted) firmware, it will fail to probe.
> 
> To implement the sparse GPIO map, we register all of the GPIOs, but
> fill in the data only for available GPIOs.  This ensures that the driver
> cannot accidentally access an unavailable GPIO.
> 
> The pinctrl-msm driver also scans the "gpios" property to determine
> which pins are available, and ensure that only those can be registered.
> 
> Support for QCOM8001 is removed as there is no longer any firmware that
> implements it.
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
