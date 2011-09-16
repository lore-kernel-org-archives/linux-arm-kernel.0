From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 16 Sep 2011 13:52:27 +0200
Subject: [PATCH v2 5/6] OMAP: omap_device: Create a default
	omap_device_pm_latency
In-Reply-To: <1314973520-3585-6-git-send-email-b-cousson@ti.com>
References: <1314973520-3585-1-git-send-email-b-cousson@ti.com>
	<1314973520-3585-6-git-send-email-b-cousson@ti.com>
Message-ID: <4E73387B.2030403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On 9/2/2011 4:25 PM, Cousson, Benoit wrote:
> Most devices are using the same default omap_device_pm_latency structure
> during device built. In order to avoid the duplication of the same
> structure everywhere, add a default structure that will be used if
> the device does not have an explicit one.

[...]

> -	od->pm_lats = pm_lats;
> -	od->pm_lats_cnt = pm_lats_cnt;
> +	if (pm_lats) {
> +		od->pm_lats = pm_lats;
> +		od->pm_lats_cnt = pm_lats_cnt;
> +	} else {
> +		od->pm_lats = omap_default_latency;
> +		od->pm_lats_cnt = ARRAY_SIZE(omap_default_latency);
> +	}

Here is the fix for that part. I did the easy version :-). Splitting the structure in two parts will indeed require more work.

I updated the for_3.2/1_omap_device_cleanup branch.

Regards,
Benoit

---
