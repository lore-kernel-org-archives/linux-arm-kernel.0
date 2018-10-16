From: javierm@redhat.com (Javier Martinez Canillas)
Date: Tue, 16 Oct 2018 11:32:34 +0200
Subject: [PATCH 1/3] driver core: add probe_err log helper
In-Reply-To: <20181016072244.1216-2-a.hajda@samsung.com>
References: <20181016072244.1216-1-a.hajda@samsung.com>
 <CGME20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e@eucas1p2.samsung.com>
 <20181016072244.1216-2-a.hajda@samsung.com>
Message-ID: <a0dc2316-fb5d-31cf-7e21-442a2968f649@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrzej,

On 10/16/2018 09:22 AM, Andrzej Hajda wrote:
> During probe every time driver gets resource it should usually check for error
> printk some message if it is not -EPROBE_DEFER and return the error. This
> pattern is simple but requires adding few lines after any resource acquisition
> code, as a result it is often omited or implemented only partially.
> probe_err helps to replace such code seqences with simple call, so code:
> 	if (err != -EPROBE_DEFER)
> 		dev_err(dev, ...);
> 	return err;
> becomes:
> 	return probe_err(dev, err, ...);
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
