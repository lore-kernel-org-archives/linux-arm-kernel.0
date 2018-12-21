Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E39AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:28:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DD721903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bXWmVCaX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aoPUViPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DD721903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MZbMlhGq5JaQuNtifsoBa6VlfUoy0NCRbwNENCfyEgo=; b=bXWmVCaXXdy7K2
	bgNPwl/G6eRS/TWEcAyCW4b7a5UcfrP/CR5WdK1tSoPQ3+yvxKS8wX9LPwMqA4SjQ/7i7zo/r/+5B
	tP9VBc/TApLXKBRTaGlNEHweLA+6/1ls2xASWBg499OY6T28b/g8IFGkE/LH4jB/KjXMRi4gHD2nr
	Cs8OsNl50rR+hv118Ad5ll4jz1v2Y1KvZ54faOQ4Tg1XgJXiy9bIDUg1U5JSthBdMliiiZ7Wx8w/j
	3jBAT2WmW/fuz4j92yk5VxQpNZBUyo2s9gDnkVfhZweywsXGTR1XyRx3ANwwvIT3xP0RH3Tcptl4O
	/wCDcslNYfCDtdXyuG9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaMip-0003P5-7E; Fri, 21 Dec 2018 15:28:19 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaMik-0003MA-Ul
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 15:28:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L/8AIlneBYRPC+3W3DXZUFl+oPqXxZfFR3kgfHMJ5dg=; b=aoPUViPm+py834+TLywfaXj3M
 NqmoQoZjH7c/h7vkiXtVI4b+qjY8szLHMc+sDnwc/pVGLI7j6kvOUWIMpY4M2GzBEPOy1juzAy13h
 KBAOHB4YwR/ljs+Gw7TW3xunm5NdoMwxGv3DvouUYP5kyBiYm3p4NARQh+NHK5gABCIm8=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:51305)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gaMgS-0007Sd-Nk; Fri, 21 Dec 2018 15:25:52 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gaMgN-0000is-OT; Fri, 21 Dec 2018 15:25:47 +0000
Date: Fri, 21 Dec 2018 15:25:45 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [arm:csi-v6 3/5] drivers/media/i2c/imx219.c:2218:2-8: preceding
 lock on line 2206 (fwd)
Message-ID: <20181221152545.GV26090@n2100.armlinux.org.uk>
References: <alpine.DEB.2.20.1812201622480.14665@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1812201622480.14665@hadrien>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_072815_420005_CAE935E5 
X-CRM114-Status: GOOD (  16.99  )
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
Cc: kbuild-all@01.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Thanks, fixed.

On Thu, Dec 20, 2018 at 04:23:23PM +0100, Julia Lawall wrote:
> Hello,
> 
> It looks like an unlock may be needed at line 2218.
> 
> julia
> 
> ---------- Forwarded message ----------
> Date: Thu, 20 Dec 2018 23:15:54 +0800
> From: kbuild test robot <lkp@intel.com>
> To: kbuild@01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: [arm:csi-v6 3/5] drivers/media/i2c/imx219.c:2218:2-8: preceding lock on
>      line 2206
> 
> CC: kbuild-all@01.org
> CC: linux-arm-kernel@lists.infradead.org
> TO: Russell King <rmk+kernel@armlinux.org.uk>
> 
> tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git csi-v6
> head:   787eec29b136e015f9f10ba0475c800a43dc9f65
> commit: 2aaa1f8a02040955a755baa0e39d5f1c3c33c8e7 [3/5] media: i2c: imx219 camera driver
> :::::: branch date: 7 days ago
> :::::: commit date: 7 days ago
> 
> >> drivers/media/i2c/imx219.c:2218:2-8: preceding lock on line 2206
> 
> git remote add arm git://git.armlinux.org.uk/~rmk/linux-arm.git
> git remote update arm
> git checkout 2aaa1f8a02040955a755baa0e39d5f1c3c33c8e7
> vim +2218 drivers/media/i2c/imx219.c
> 
> 2aaa1f8a Russell King 2017-01-21  2162
> 2aaa1f8a Russell King 2017-01-21  2163  /*
> 2aaa1f8a Russell King 2017-01-21  2164   * Hardware limitations:
> 2aaa1f8a Russell King 2017-01-21  2165   * The sink crop rectangle must always fit within the sink pad format size.
> 2aaa1f8a Russell King 2017-01-21  2166   * The sink compose rectangle must always fit within the sink crop rectangle.
> 2aaa1f8a Russell King 2017-01-21  2167   * The source pad format size must always match the compose rectangle size.
> 2aaa1f8a Russell King 2017-01-21  2168   *
> 2aaa1f8a Russell King 2017-01-21  2169   * Even if V4L2_SEL_FLAG_KEEP_CONFIG is set, we _must_ propagate a change
> 2aaa1f8a Russell King 2017-01-21  2170   * in the compose rectangle size to the source pad format, because the
> 2aaa1f8a Russell King 2017-01-21  2171   * difference is a pure software fallacy.
> 2aaa1f8a Russell King 2017-01-21  2172   */
> 2aaa1f8a Russell King 2017-01-21  2173  static int imx219_set_selection(struct v4l2_subdev *sd,
> 2aaa1f8a Russell King 2017-01-21  2174  				struct v4l2_subdev_pad_config *cfg,
> 2aaa1f8a Russell King 2017-01-21  2175  				struct v4l2_subdev_selection *sel)
> 2aaa1f8a Russell King 2017-01-21  2176  {
> 2aaa1f8a Russell King 2017-01-21  2177  	struct imx219_private *priv = imx219_get_priv(sd);
> 2aaa1f8a Russell King 2017-01-21  2178  	struct imx219_sub *sub = imx219_get_sub(sd);
> 2aaa1f8a Russell King 2017-01-21  2179  	struct v4l2_mbus_framefmt *pad_fmt, *src_fmt;
> 2aaa1f8a Russell King 2017-01-21  2180  	struct v4l2_rect *pad_crop, *pad_compose;
> 2aaa1f8a Russell King 2017-01-21  2181  	struct v4l2_rect *rects[4], sink_fmt_rect, src_fmt_rect;
> 2aaa1f8a Russell King 2017-01-21  2182  	int ret, idx;
> 2aaa1f8a Russell King 2017-01-21  2183
> 2aaa1f8a Russell King 2017-01-21  2184  	if (!sub->pad_ops->adj_selection)
> 2aaa1f8a Russell King 2017-01-21  2185  		return -ENOTTY;
> 2aaa1f8a Russell King 2017-01-21  2186
> 2aaa1f8a Russell King 2017-01-21  2187  	switch (sel->target) {
> 2aaa1f8a Russell King 2017-01-21  2188  	case V4L2_SEL_TGT_CROP:
> 2aaa1f8a Russell King 2017-01-21  2189  		idx = 1;
> 2aaa1f8a Russell King 2017-01-21  2190  		break;
> 2aaa1f8a Russell King 2017-01-21  2191  	case V4L2_SEL_TGT_COMPOSE:
> 2aaa1f8a Russell King 2017-01-21  2192  		idx = 2;
> 2aaa1f8a Russell King 2017-01-21  2193  		break;
> 2aaa1f8a Russell King 2017-01-21  2194  	default:
> 2aaa1f8a Russell King 2017-01-21  2195  		return -EINVAL;
> 2aaa1f8a Russell King 2017-01-21  2196  	}
> 2aaa1f8a Russell King 2017-01-21  2197
> 2aaa1f8a Russell King 2017-01-21  2198  	pad_fmt = imx219_get_pad_fmt(sd, cfg, sel->which, sel->pad);
> 2aaa1f8a Russell King 2017-01-21  2199  	pad_crop = imx219_get_pad_crop(sd, cfg, sel->which, sel->pad);
> 2aaa1f8a Russell King 2017-01-21  2200  	pad_compose = imx219_get_pad_compose(sd, cfg, sel->which, sel->pad);
> 2aaa1f8a Russell King 2017-01-21  2201  	if (!pad_fmt || !pad_compose || !pad_crop)
> 2aaa1f8a Russell King 2017-01-21  2202  		return -EINVAL;
> 2aaa1f8a Russell King 2017-01-21  2203
> 2aaa1f8a Russell King 2017-01-21  2204  	src_fmt = imx219_get_pad_fmt(sd, cfg, sel->which, PAD_SRC);
> 2aaa1f8a Russell King 2017-01-21  2205
> 2aaa1f8a Russell King 2017-01-21 @2206  	mutex_lock(&priv->mutex);
> 2aaa1f8a Russell King 2017-01-21  2207  	imx219_framefmt_to_rect(&sink_fmt_rect, pad_fmt);
> 2aaa1f8a Russell King 2017-01-21  2208  	imx219_framefmt_to_rect(&src_fmt_rect, src_fmt);
> 2aaa1f8a Russell King 2017-01-21  2209
> 2aaa1f8a Russell King 2017-01-21  2210  	rects[0] = &sink_fmt_rect;
> 2aaa1f8a Russell King 2017-01-21  2211  	rects[1] = pad_crop;
> 2aaa1f8a Russell King 2017-01-21  2212  	rects[2] = pad_compose;
> 2aaa1f8a Russell King 2017-01-21  2213  	rects[3] = &src_fmt_rect;
> 2aaa1f8a Russell King 2017-01-21  2214
> 2aaa1f8a Russell King 2017-01-21  2215  	ret = sub->pad_ops->adj_selection(priv, sel->target, sel->flags,
> 2aaa1f8a Russell King 2017-01-21  2216  					  &sel->r, rects + idx);
> 2aaa1f8a Russell King 2017-01-21  2217  	if (ret)
> 2aaa1f8a Russell King 2017-01-21 @2218  		return ret;
> 2aaa1f8a Russell King 2017-01-21  2219
> 2aaa1f8a Russell King 2017-01-21  2220  	if (sel->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
> 2aaa1f8a Russell King 2017-01-21  2221  		ret = sub->pad_ops->set_selection(priv, sub, sel->pad,
> 2aaa1f8a Russell King 2017-01-21  2222  						  sel->target,
> 2aaa1f8a Russell King 2017-01-21  2223  						  &sel->r, rects[idx - 1]);
> 2aaa1f8a Russell King 2017-01-21  2224
> 2aaa1f8a Russell King 2017-01-21  2225  		/* Setting the crop also propagates to the compose */
> 2aaa1f8a Russell King 2017-01-21  2226  		if (sel->target == V4L2_SEL_TGT_CROP && ret == 0)
> 2aaa1f8a Russell King 2017-01-21  2227  			ret = sub->pad_ops->set_selection(priv, sub, sel->pad,
> 2aaa1f8a Russell King 2017-01-21  2228  							  V4L2_SEL_TGT_COMPOSE,
> 2aaa1f8a Russell King 2017-01-21  2229  							  &sel->r, &sel->r);
> 2aaa1f8a Russell King 2017-01-21  2230  	}
> 2aaa1f8a Russell King 2017-01-21  2231
> 2aaa1f8a Russell King 2017-01-21  2232  	if (ret == 0) {
> 2aaa1f8a Russell King 2017-01-21  2233  		*rects[idx] = sel->r;
> 2aaa1f8a Russell King 2017-01-21  2234
> 2aaa1f8a Russell King 2017-01-21  2235  		if (!(sel->flags & V4L2_SEL_FLAG_KEEP_CONFIG)) {
> 2aaa1f8a Russell King 2017-01-21  2236  			while (++idx < ARRAY_SIZE(rects))
> 2aaa1f8a Russell King 2017-01-21  2237  				*rects[idx] = sel->r;
> 2aaa1f8a Russell King 2017-01-21  2238
> 2aaa1f8a Russell King 2017-01-21  2239  			src_fmt->width = src_fmt_rect.width;
> 2aaa1f8a Russell King 2017-01-21  2240  			src_fmt->height = src_fmt_rect.height;
> 2aaa1f8a Russell King 2017-01-21  2241  		}
> 2aaa1f8a Russell King 2017-01-21  2242  	}
> 2aaa1f8a Russell King 2017-01-21  2243  	mutex_unlock(&priv->mutex);
> 2aaa1f8a Russell King 2017-01-21  2244
> 2aaa1f8a Russell King 2017-01-21  2245  	return ret;
> 2aaa1f8a Russell King 2017-01-21  2246  }
> 2aaa1f8a Russell King 2017-01-21  2247
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
