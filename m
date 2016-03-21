From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 21 Mar 2016 14:47:17 -0500
Subject: [PATCH 1/2] serial: amba-pl011: make platform driver generic
In-Reply-To: <1457920282-14823-1-git-send-email-jun.nie@linaro.org>
References: <1457920282-14823-1-git-send-email-jun.nie@linaro.org>
Message-ID: <56F04FC5.7040907@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jun Nie wrote:

> -	snprintf(uap->type, sizeof(uap->type), "SBSA");
> +	snprintf(uap->type, sizeof(uap->type), "PL011 plat");

I'm not crazy about this.  I think you need to add a "const char *name" 
field to 'struct vendor_data'.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
