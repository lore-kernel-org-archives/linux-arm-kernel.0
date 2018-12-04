Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0330C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:38:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19FA20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QJm0FPFP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiVJ17XP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19FA20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vI7I/Y2p2TlGpv4CzloWbdvoai/BYz3CtgQSvel7s/E=; b=QJm0FPFPXPNOlA
	WvY5LeFuf/RhcIlpGPiOoabFJFpgWsz+mhE641cDISPsdPEnXER4fTCB0wsNzsweJce+uavBnl54K
	wBIK3rbEtYoltL9M7Oul6rm1Q6thJFQ+0HLT/niEfSp1MgYbuHdcXdOIcMPsI/48FJpT9vjPZOYYq
	BPki/qdVuv5r5dkvvTHh2ZL83PFgwNIhFXtanCjQMO6k6jZhox3dnaVGRc59aSxcTkIhjr5w64ycz
	wSWRaVutzRAmOiZk7Wyw0gONHF8VGlfJrZiWvJqBkSgWRtucZ/lcl7WO5mlgqXZE0FCNxsVYnSUzo
	j1GbWApbAJycBptNtrFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUGWe-0006no-B2; Tue, 04 Dec 2018 19:38:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUGWa-0006mJ-Gx
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:38:29 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F009A2081C;
 Tue,  4 Dec 2018 19:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543952298;
 bh=cngnxl+fU+ayv84S7RyWF15Ik1K/InQVU3DcM+FUCIo=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=GiVJ17XPmwirSW3mJ0E2FkVcefeNrshizET7NcDG5jnG7MaXqI0k5osnMaoe5bl93
 N0qcwqGPHLoThI7bvvwW7BEyh5aqaCz7dfGbCTMTXf8GwCM4yC0mxMeuaDcfx1/NgI
 a7rHJUjnXT+FztrZ9FswBU/UCMObuhTN+6XwjK+A=
MIME-Version: 1.0
To: matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <a40442ad1a2f1d13798ba535eca371845bae9248.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <a40442ad1a2f1d13798ba535eca371845bae9248.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <154395229720.88331.16585219136189943316@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 03/10] clk: of-provider: look at parent if registered
 device has no provider info
Date: Tue, 04 Dec 2018 11:38:17 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_113828_591948_B4B408E0 
X-CRM114-Status: GOOD (  17.53  )
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
Cc: david.brown@linaro.org, linux-clk@vger.kernel.org, b.zolnierkie@samsung.com,
 andrew.smirnov@gmail.com, linux-kernel@vger.kernel.org,
 mturquette@baylibre.com, rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
 linux@armlinux.org.uk, krzk@kernel.org, akshu.agrawal@amd.com,
 cw00.choi@samsung.com, djkurtz@chromium.org, pavel@ucw.cz,
 pombredanne@nexb.com, andy.gross@linaro.org, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Matti Vaittinen (2018-12-04 03:34:53)
> It seems to be usual for MFD devices that the created 'clock sub-device'
> do not have own DT node. The clock provider information is usually in the
> main device node which is owned by the MFD device. Change the devm variant
> of clk of-provider registration to check the parent device node if given
> device has no own node or if the node does not contain the #clock-cells
> property. In such case use the parent node if it contains the #clock-cells.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/clk/clk.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 78c90913f987..66dc7c1483d7 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3893,6 +3893,11 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
>         of_clk_del_provider(*(struct device_node **)res);
>  }
>  
> +static int of_is_clk_provider(struct device_node *np)
> +{
> +       return !!of_find_property(np, "#clock-cells", NULL);
> +}
> +
>  /**
>   * devm_of_clk_add_hw_provider() - Managed clk provider node registration
>   * @dev: Device acting as the clock provider. Used for DT node and lifetime.
> @@ -3901,8 +3906,11 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
>   *
>   * Returns 0 on success or an errno on failure.
>   *
> - * Registers clock provider for given device's node. Provider is automatically
> - * released at device exit.
> + * Registers clock provider for given device's node. If the device has no DT
> + * node or if the device node lacks of clock provider information (#clock-cells)
> + * then the parent device's node is scanned for this information. If parent node
> + * has the #clock-cells then it is used in registration. Provider is
> + * automatically released at device exit.
>   */
>  int devm_of_clk_add_hw_provider(struct device *dev,
>                         struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> @@ -3912,12 +3920,17 @@ int devm_of_clk_add_hw_provider(struct device *dev,
>         struct device_node **ptr, *np;
>         int ret;
>  
> +       np = dev->of_node;
> +
> +       if (!of_is_clk_provider(dev->of_node))
> +               if (of_is_clk_provider(dev->parent->of_node))
> +                       np = dev->parent->of_node;

As said on v5, let's just modify of_clk_add_provider() to do the parent
search.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
