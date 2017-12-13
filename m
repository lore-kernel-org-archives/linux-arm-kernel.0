From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 13 Dec 2017 16:43:05 +0200
Subject: [PATCH 3/3] [v5] pinctrl: qcom: qdf2xxx: add support for new
 ACPI HID QCOM8002
In-Reply-To: <1513111858-6251-4-git-send-email-timur@codeaurora.org>
References: <1513111858-6251-1-git-send-email-timur@codeaurora.org>
 <1513111858-6251-4-git-send-email-timur@codeaurora.org>
Message-ID: <1513176185.7000.22.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-12-12 at 14:50 -0600, Timur Tabi wrote:
> Newer versions of the firmware for the Qualcomm Datacenter
> Technologies
> QDF2400 restricts access to a subset of the GPIOs on the TLMM.  To
> prevent older kernels from accidentally accessing the restricted
> GPIOs,
> we change the ACPI HID for the TLMM block from QCOM8001 to QCOM8002,
> and introduce a new property "gpios".  This property is an array of
> specific GPIOs that are accessible.  When an older kernel boots on
> newer (restricted) firmware, it will fail to probe.
> 
> To implement the sparse GPIO map, we register all of the GPIOs, but
> set
> the pin count for the unavailable GPIOs to zero.  The pinctrl-msm
> driver will block those unavailable GPIOs from being accessed.
> 
> To allow newer kernels to support older firmware, the driver retains
> support for QCOM8001.

Please, read my comments to v8, same applies here.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
