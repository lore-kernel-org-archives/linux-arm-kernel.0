From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 29 Oct 2014 10:46:29 -0700
Subject: [RFC 1/2] PM / Domains: Power on domain early during system resume
In-Reply-To: <1414072090-11293-2-git-send-email-k.kozlowski@samsung.com>
 (Krzysztof Kozlowski's message of "Thu, 23 Oct 2014 15:48:09 +0200")
References: <1414072090-11293-1-git-send-email-k.kozlowski@samsung.com>
 <1414072090-11293-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <7hk33iahvu.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:

> When resuming the system the power domain has to be powered on early so
> any runtime PM aware devices could resume.
>
> This fixes following scenario reproduced on Exynos DRM:
> 1. Power domain is off before suspending the system.
> 2. System is suspended to RAM.
> 3. Resuming starts. The Exynos DRM driver resume callback is called.
> 4. The Exynos DRM driver calls drm_helper_resume_force_mode which turns
>    the screen on by calling exynos_dsi_dpms with DRM_MODE_DPMS_ON.

Dumb Q: if the device (and power domain) were off before (and during)
suspend, why are they being resumed?

Shouldn't the resume path restore things to the same state they were
before suspend?

Kevin
