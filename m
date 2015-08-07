From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Aug 2015 14:05:40 +0100
Subject: [PATCH v3 1/4] ASoC: dt-bindings: add rockchip tranceiver bindings
In-Reply-To: <1438947854-3743-2-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1438947854-3743-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1438947854-3743-2-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <20150807130540.GX20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 07, 2015 at 01:44:11PM +0200, Sjoerd Simons wrote:

> +- compatible: should be one of the following:
> +   - "rockchip,rk3066-spdif": for rk3066
> +   - "rockchip,rk3188-spdif", "rockchip,rk3066-spdif": for rk3188
> +   - "rockchip,rk3288-spdif", "rockchip,rk3066-spdif": for rk3288

The binding claims that we support these three compatibles but the
driver only supports rockchip,rk3066-spdif.  It's better to list all the
compatibles in the binding even if they all boil down to the same thing
since it's less error prone when we do start adding device specific
code - people are less likely to forget to handle some variant properly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150807/7ea0e7eb/attachment.sig>
