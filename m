From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Jul 2014 19:56:09 +0100
Subject: [PATCH -next] ASoC: samsung: Fix return value check in
 s3c2412_iis_dev_probe()
In-Reply-To: <1405827787-26055-1-git-send-email-weiyj_lk@163.com>
References: <1405827787-26055-1-git-send-email-weiyj_lk@163.com>
Message-ID: <20140729185609.GH17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 20, 2014 at 11:43:07AM +0800, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should be
> replaced with IS_ERR(). Also remove redundant return value check of
> platform_get_resource().

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/6d57e706/attachment.sig>
