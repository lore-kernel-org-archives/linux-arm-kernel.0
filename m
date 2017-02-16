From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Feb 2017 18:26:49 +0000
Subject: [alsa-devel] [PATCH 1/2] ASoC: mediatek: add power-domain
 get/put ctrl for mt2701
In-Reply-To: <1487222836-21174-2-git-send-email-garlic.tseng@mediatek.com>
References: <1487222836-21174-1-git-send-email-garlic.tseng@mediatek.com>
 <1487222836-21174-2-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <20170216182649.k6vj3rpvzgbquax5@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 01:27:15PM +0800, Garlic Tseng wrote:

>  	pm_runtime_enable(&pdev->dev);
>  	if (!pm_runtime_enabled(&pdev->dev))
>  		goto err_pm_disable;
> +	pm_runtime_get_sync(&pdev->dev);

You should really check for errors here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170216/92bdac0a/attachment.sig>
