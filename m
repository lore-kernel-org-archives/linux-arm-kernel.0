From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 3 Jul 2017 16:21:42 -0400
Subject: [PATCH 2/2] [v2] pinctrl: qcom: qdf2xxx: expose only some GPIO
 pins
In-Reply-To: <1498783339-749-2-git-send-email-timur@codeaurora.org>
References: <1498783339-749-1-git-send-email-timur@codeaurora.org>
 <1498783339-749-2-git-send-email-timur@codeaurora.org>
Message-ID: <9BA42EA1-D050-41D3-A7DE-0B0FBF9A4274@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jun 29, 2017, at 8:42 PM, Timur Tabi wrote:

> On Qualcomm Technologies QDF2xxx platforms, only a subset of the GPIOs
> are actually available to the HLOS.  The others are blocked by the XPU,
> and any attempt to access them will cause an XPU violation that halts
> the system.
> 
> Instead, the ACPI table now lists only specific GPIOs that are exposed
> externally as generic GPIO pins.  The full list of GPIOs is still
> registered, but the pin count for the unavailable GPIOs is set to zero.
> The pinctrl-msm driver will block those unavailable GPIOs from being
> accessed.

Please do not apply this patchset just yet.  

We are considering assigning a new ACPI HID for this change, so that we don't accidentally cause XPU violations when someone uses an old kernel with new firmware.  However, with everyone on vacation this week, many of the stakeholders are not available for discussions.

I'm still interested in reviews on this patchset though.
