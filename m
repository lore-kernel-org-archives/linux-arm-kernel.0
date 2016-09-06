From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Sep 2016 11:29:44 +0100
Subject: [PATCH v2] ASoC: rockchip: i2s: restore register during
 runtime_suspend/resume cycle
In-Reply-To: <1473124793-74625-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1473124793-74625-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <20160906102944.GH3950@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 09:19:53AM +0800, Sugar Zhang wrote:

>  	struct rk_i2s_dev *i2s = dev_get_drvdata(dev);
> -	int ret;
> +	int ret = 0;
>  

Why are you initializing this?  All this will do is stop the compiler
warning you about use without initializaiton bugs.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160906/94c81b8c/attachment.sig>
