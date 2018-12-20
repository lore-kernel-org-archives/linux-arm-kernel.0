Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94B0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:35:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73BCB2186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JoNJlXZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BCB2186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+NC/67q8c+mQEqET7xpcMdGsEruWYJvZyWijnA5B55g=; b=JoNJlXZIzzIiIX
	yQ94mN3ug7QvWhdWhOQbRU7EGaxPCcIEsiiL5rh5cPXgFjpxbRhfwUhdQqsZj+dPHYEeyE+SpTtXu
	Ry/wcrzhRz1jdpw/1wWXd289VecjmENQpswicG4hPp/s7/EtQ8VEv4rxckM9m7HO0nTtqoAED1nHo
	80cQWTxmJSSbf0aNJSdzRofnEqIWC3KvTc0aS5GtCybvVGjelDqQIKjTUu6muRroDhfru+aonMCFS
	2h/87gnSTN+x7I75lhHRfK2vwlbGSCcGa9kmRRMbceQPiqIehEsc9L209V4c05WDN+iYwwHl6gXKE
	ebFq+HAUjbKE/iT2zfGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga0M7-0007wL-DE; Thu, 20 Dec 2018 15:35:23 +0000
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0M3-0007b4-Mv
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 15:35:21 +0000
X-IronPort-AV: E=Sophos;i="5.56,377,1539640800"; d="scan'208";a="361269676"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Dec 2018 16:23:29 +0100
Date: Thu, 20 Dec 2018 16:23:23 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [arm:csi-v6 3/5] drivers/media/i2c/imx219.c:2218:2-8: preceding lock
 on line 2206 (fwd)
Message-ID: <alpine.DEB.2.20.1812201622480.14665@hadrien>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_073520_029418_23662A08 
X-CRM114-Status: GOOD (  11.47  )
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

Hello,

It looks like an unlock may be needed at line 2218.

julia

---------- Forwarded message ----------
Date: Thu, 20 Dec 2018 23:15:54 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [arm:csi-v6 3/5] drivers/media/i2c/imx219.c:2218:2-8: preceding lock on
     line 2206

CC: kbuild-all@01.org
CC: linux-arm-kernel@lists.infradead.org
TO: Russell King <rmk+kernel@armlinux.org.uk>

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git csi-v6
head:   787eec29b136e015f9f10ba0475c800a43dc9f65
commit: 2aaa1f8a02040955a755baa0e39d5f1c3c33c8e7 [3/5] media: i2c: imx219 camera driver
:::::: branch date: 7 days ago
:::::: commit date: 7 days ago

>> drivers/media/i2c/imx219.c:2218:2-8: preceding lock on line 2206

git remote add arm git://git.armlinux.org.uk/~rmk/linux-arm.git
git remote update arm
git checkout 2aaa1f8a02040955a755baa0e39d5f1c3c33c8e7
vim +2218 drivers/media/i2c/imx219.c

2aaa1f8a Russell King 2017-01-21  2162
2aaa1f8a Russell King 2017-01-21  2163  /*
2aaa1f8a Russell King 2017-01-21  2164   * Hardware limitations:
2aaa1f8a Russell King 2017-01-21  2165   * The sink crop rectangle must always fit within the sink pad format size.
2aaa1f8a Russell King 2017-01-21  2166   * The sink compose rectangle must always fit within the sink crop rectangle.
2aaa1f8a Russell King 2017-01-21  2167   * The source pad format size must always match the compose rectangle size.
2aaa1f8a Russell King 2017-01-21  2168   *
2aaa1f8a Russell King 2017-01-21  2169   * Even if V4L2_SEL_FLAG_KEEP_CONFIG is set, we _must_ propagate a change
2aaa1f8a Russell King 2017-01-21  2170   * in the compose rectangle size to the source pad format, because the
2aaa1f8a Russell King 2017-01-21  2171   * difference is a pure software fallacy.
2aaa1f8a Russell King 2017-01-21  2172   */
2aaa1f8a Russell King 2017-01-21  2173  static int imx219_set_selection(struct v4l2_subdev *sd,
2aaa1f8a Russell King 2017-01-21  2174  				struct v4l2_subdev_pad_config *cfg,
2aaa1f8a Russell King 2017-01-21  2175  				struct v4l2_subdev_selection *sel)
2aaa1f8a Russell King 2017-01-21  2176  {
2aaa1f8a Russell King 2017-01-21  2177  	struct imx219_private *priv = imx219_get_priv(sd);
2aaa1f8a Russell King 2017-01-21  2178  	struct imx219_sub *sub = imx219_get_sub(sd);
2aaa1f8a Russell King 2017-01-21  2179  	struct v4l2_mbus_framefmt *pad_fmt, *src_fmt;
2aaa1f8a Russell King 2017-01-21  2180  	struct v4l2_rect *pad_crop, *pad_compose;
2aaa1f8a Russell King 2017-01-21  2181  	struct v4l2_rect *rects[4], sink_fmt_rect, src_fmt_rect;
2aaa1f8a Russell King 2017-01-21  2182  	int ret, idx;
2aaa1f8a Russell King 2017-01-21  2183
2aaa1f8a Russell King 2017-01-21  2184  	if (!sub->pad_ops->adj_selection)
2aaa1f8a Russell King 2017-01-21  2185  		return -ENOTTY;
2aaa1f8a Russell King 2017-01-21  2186
2aaa1f8a Russell King 2017-01-21  2187  	switch (sel->target) {
2aaa1f8a Russell King 2017-01-21  2188  	case V4L2_SEL_TGT_CROP:
2aaa1f8a Russell King 2017-01-21  2189  		idx = 1;
2aaa1f8a Russell King 2017-01-21  2190  		break;
2aaa1f8a Russell King 2017-01-21  2191  	case V4L2_SEL_TGT_COMPOSE:
2aaa1f8a Russell King 2017-01-21  2192  		idx = 2;
2aaa1f8a Russell King 2017-01-21  2193  		break;
2aaa1f8a Russell King 2017-01-21  2194  	default:
2aaa1f8a Russell King 2017-01-21  2195  		return -EINVAL;
2aaa1f8a Russell King 2017-01-21  2196  	}
2aaa1f8a Russell King 2017-01-21  2197
2aaa1f8a Russell King 2017-01-21  2198  	pad_fmt = imx219_get_pad_fmt(sd, cfg, sel->which, sel->pad);
2aaa1f8a Russell King 2017-01-21  2199  	pad_crop = imx219_get_pad_crop(sd, cfg, sel->which, sel->pad);
2aaa1f8a Russell King 2017-01-21  2200  	pad_compose = imx219_get_pad_compose(sd, cfg, sel->which, sel->pad);
2aaa1f8a Russell King 2017-01-21  2201  	if (!pad_fmt || !pad_compose || !pad_crop)
2aaa1f8a Russell King 2017-01-21  2202  		return -EINVAL;
2aaa1f8a Russell King 2017-01-21  2203
2aaa1f8a Russell King 2017-01-21  2204  	src_fmt = imx219_get_pad_fmt(sd, cfg, sel->which, PAD_SRC);
2aaa1f8a Russell King 2017-01-21  2205
2aaa1f8a Russell King 2017-01-21 @2206  	mutex_lock(&priv->mutex);
2aaa1f8a Russell King 2017-01-21  2207  	imx219_framefmt_to_rect(&sink_fmt_rect, pad_fmt);
2aaa1f8a Russell King 2017-01-21  2208  	imx219_framefmt_to_rect(&src_fmt_rect, src_fmt);
2aaa1f8a Russell King 2017-01-21  2209
2aaa1f8a Russell King 2017-01-21  2210  	rects[0] = &sink_fmt_rect;
2aaa1f8a Russell King 2017-01-21  2211  	rects[1] = pad_crop;
2aaa1f8a Russell King 2017-01-21  2212  	rects[2] = pad_compose;
2aaa1f8a Russell King 2017-01-21  2213  	rects[3] = &src_fmt_rect;
2aaa1f8a Russell King 2017-01-21  2214
2aaa1f8a Russell King 2017-01-21  2215  	ret = sub->pad_ops->adj_selection(priv, sel->target, sel->flags,
2aaa1f8a Russell King 2017-01-21  2216  					  &sel->r, rects + idx);
2aaa1f8a Russell King 2017-01-21  2217  	if (ret)
2aaa1f8a Russell King 2017-01-21 @2218  		return ret;
2aaa1f8a Russell King 2017-01-21  2219
2aaa1f8a Russell King 2017-01-21  2220  	if (sel->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
2aaa1f8a Russell King 2017-01-21  2221  		ret = sub->pad_ops->set_selection(priv, sub, sel->pad,
2aaa1f8a Russell King 2017-01-21  2222  						  sel->target,
2aaa1f8a Russell King 2017-01-21  2223  						  &sel->r, rects[idx - 1]);
2aaa1f8a Russell King 2017-01-21  2224
2aaa1f8a Russell King 2017-01-21  2225  		/* Setting the crop also propagates to the compose */
2aaa1f8a Russell King 2017-01-21  2226  		if (sel->target == V4L2_SEL_TGT_CROP && ret == 0)
2aaa1f8a Russell King 2017-01-21  2227  			ret = sub->pad_ops->set_selection(priv, sub, sel->pad,
2aaa1f8a Russell King 2017-01-21  2228  							  V4L2_SEL_TGT_COMPOSE,
2aaa1f8a Russell King 2017-01-21  2229  							  &sel->r, &sel->r);
2aaa1f8a Russell King 2017-01-21  2230  	}
2aaa1f8a Russell King 2017-01-21  2231
2aaa1f8a Russell King 2017-01-21  2232  	if (ret == 0) {
2aaa1f8a Russell King 2017-01-21  2233  		*rects[idx] = sel->r;
2aaa1f8a Russell King 2017-01-21  2234
2aaa1f8a Russell King 2017-01-21  2235  		if (!(sel->flags & V4L2_SEL_FLAG_KEEP_CONFIG)) {
2aaa1f8a Russell King 2017-01-21  2236  			while (++idx < ARRAY_SIZE(rects))
2aaa1f8a Russell King 2017-01-21  2237  				*rects[idx] = sel->r;
2aaa1f8a Russell King 2017-01-21  2238
2aaa1f8a Russell King 2017-01-21  2239  			src_fmt->width = src_fmt_rect.width;
2aaa1f8a Russell King 2017-01-21  2240  			src_fmt->height = src_fmt_rect.height;
2aaa1f8a Russell King 2017-01-21  2241  		}
2aaa1f8a Russell King 2017-01-21  2242  	}
2aaa1f8a Russell King 2017-01-21  2243  	mutex_unlock(&priv->mutex);
2aaa1f8a Russell King 2017-01-21  2244
2aaa1f8a Russell King 2017-01-21  2245  	return ret;
2aaa1f8a Russell King 2017-01-21  2246  }
2aaa1f8a Russell King 2017-01-21  2247

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
