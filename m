Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FC5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:16:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A90D2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tc0fhDwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A90D2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7FnskBmixmeZtmkFQkp3PSTr5AthrmYBSN0dgJvJU1Q=; b=Tc0fhDwSqQtDgg
	8E1AcLKxEq2Pljxtn7HKh9HnRHerX3cZnK2igBL31BU5hG9HMRh+e2ZoVelKCeE1pcdGWr8qPS4yx
	FGZiihb/qwOjDtlZOUGI7BoE5UplsnLmV+HD/VZpOJDBGCgR5N1EDIh3NYK1uX2oAbKOyhbjZRnS4
	07TM+XFrrGarUl7zm6R63aGSgADes1IEUW+W9jdzEO5ViCpNgc6avA5iNfkeEZMm4ZJNDzq+7H8vZ
	qQOkXTBYm62RdJMyFTqkoKFme7Vq62Zt6Dw/y2C8olEqduGOEeJduFs/sJKj60XRP9AIl8EUzVsLE
	9grr2JFD1W7zOVVUp4Ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkUwr-0002sI-BL; Fri, 18 Jan 2019 14:16:41 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkUwo-0002ra-6z
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:16:40 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id CFA92207B0; Fri, 18 Jan 2019 15:16:36 +0100 (CET)
Received: from localhost (alyon-652-1-26-46.w109-213.abo.wanadoo.fr
 [109.213.9.46])
 by mail.bootlin.com (Postfix) with ESMTPSA id 703E52074A;
 Fri, 18 Jan 2019 15:16:36 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v4 3/4] clk: mvebu: armada-37xx-tbg: fill the device entry
 when registering the clocks
References: <20190108161940.4814-1-miquel.raynal@bootlin.com>
 <20190108161940.4814-4-miquel.raynal@bootlin.com>
Date: Fri, 18 Jan 2019 15:16:36 +0100
In-Reply-To: <20190108161940.4814-4-miquel.raynal@bootlin.com> (Miquel
 Raynal's message of "Tue, 8 Jan 2019 17:19:39 +0100")
Message-ID: <871s5anj97.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_061638_529872_AC35F3B3 
X-CRM114-Status: GOOD (  20.05  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, Nadav Haklai <nadavh@marvell.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Miquel,
 
 On mar., janv. 08 2019, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> So far the clk_hw_register_fixed_factor() calls are not providing any
> device structure. While doing so is harmless for regular use, the
> missing device structure may be a problem for suspend to RAM support.
>
> Since, device links have been added to clocks, links created during
> probe will enforce the suspend/resume orders. When the device is
> missing during the registration, no link can be established, hence the
> order between parent and child clocks are not enforced.
>
> Adding the device structure here will create a link between the 4 TBG
> clocks (registered by this driver) and:
> * their parent clock: XTAL,
> * their child clocks: several 'periph' clock.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory

> ---
>  drivers/clk/mvebu/armada-37xx-tbg.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/armada-37xx-tbg.c
> index 77b978c55ef6..da3a08e419d6 100644
> --- a/drivers/clk/mvebu/armada-37xx-tbg.c
> +++ b/drivers/clk/mvebu/armada-37xx-tbg.c
> @@ -116,8 +116,10 @@ static int armada_3700_tbg_clock_probe(struct platform_device *pdev)
>  		name = tbg[i].name;
>  		mult = tbg_get_mult(reg, &tbg[i]);
>  		div = tbg_get_div(reg, &tbg[i]);
> -		hw_tbg_data->hws[i] = clk_hw_register_fixed_factor(NULL, name,
> -						parent_name, 0, mult, div);
> +		hw_tbg_data->hws[i] = clk_hw_register_fixed_factor(dev, name,
> +								   parent_name,
> +								   0, mult,
> +								   div);
>  		if (IS_ERR(hw_tbg_data->hws[i]))
>  			dev_err(dev, "Can't register TBG clock %s\n", name);
>  	}
> -- 
> 2.19.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
