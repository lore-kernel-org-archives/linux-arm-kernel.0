Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D91C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:21:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1EB20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D9yB4kil";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="bemIn85b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1EB20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BBzZM0oGM7sfu37iYoAvsWXcFPhO9n0FmDu4jJsJd38=; b=D9yB4kilKpi5T1
	4eafkk0GnRBC78v9RKLQPgwnwoHEy6b3X0eT7cnfyH5FA0icn1leG1sEiGb+aCvKSpfE6ra9xgP3N
	SPqlIvx5eZs1J7Zz+uZtXkwVLXb4HrivIjPehJ/+wW9eQ95Dl1inO+ohS/bFLuFOHDpBUNe9Y4e1m
	gdQnkM3Q7+RZGXoWDPFFNgqqgE6+fKTAAYPttD/8hULStEBcbFK+a1S2Yf/l4rj1moctOP4WYVdpa
	VW48rHH+7SlknT0LTItAxDYWKUg1SUUedKcvABq93pcC0ujkodPkM8Bi9t1+xdozw0G8V8bU6kmLz
	onw/EzFxhcH7u1gvW/NA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCsJ-0004Gd-VM; Wed, 12 Dec 2018 22:21:04 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCp1-0007oD-Cg
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:17:46 +0000
Received: by mail-lf1-x142.google.com with SMTP id b20so14737913lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Mbdo9amLaNpcQ1Gm+8UMp4Ud670k7H5aMzSRDYJY0/Q=;
 b=bemIn85bqe+cvT27x2yVuILi2VQvmQgPyWwO8QdIi7fEu09x8tpwuuHEpVAl2HdRPw
 vQHA2/Vuj98nRc29vzywSeyXFLUQu2Bx562yoEjdRRd2JU8S7GzANo9DxYSZ259OHwij
 kPnDtsTnauFXvVRL1dJJAVHvD+0bgwz/nr8oVe28DD0GqkrwpLd1W9Q4rS87749HeMMg
 U5/7beKPfZTXkEUChCBq4E9f2pjzUxRZhWgcvm6cGt+mj4T+ZTTWG518hUAdz5T3bzHI
 KINNWi6Loz/HmxclLpFLXaVVsfO2T3lExipIlqmu8arPVixOzRgu56W0JXkGeOKUnQfC
 uGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Mbdo9amLaNpcQ1Gm+8UMp4Ud670k7H5aMzSRDYJY0/Q=;
 b=qJORnjCeFq6xeProklt8ZL9TonmChopGYuCVx+gcRTJ3avwewKWr0hUah4/99GM8dv
 xRVD3nzGks1Mbhywftid+F40lSS8wQWLt8pYqD9IFY9biag+OoKwZhRKz7fxBFemoyQE
 afTMSwiezrczJ5rUVaVb1jZunBMsv6VWvRF1sH2zTWOIdlpwJUubH8Re/G7VEW/QgSxn
 GW4ECzcXnOBE9MhvF5qty6TlZbfTzMaNb9qUNbiHno6Hbgz8RTl+JnHQpx6Sr8usyOD2
 jtMrMA8oCPB86twWJmnEclQ4qdUaWn76lviaKNVMSsYeCHuA6jffSO03SC2iqOhQddfP
 9IIA==
X-Gm-Message-State: AA+aEWZZI/l2z6k7cIjVen09JXK45UQ86BmhZ6FPEVKcI86HyaPYi9dI
 gZFy2zqBtNFkr8EsAhJvQE6XHC65YqzT6Q==
X-Google-Smtp-Source: AFSGD/UXX0rmNxNTi2Bm6RI9MFh8pNFiTEwJyLNX5v+2F1kHbKobpfJptvTQwhRJ5MwhKs7nN23anQ==
X-Received: by 2002:a19:2106:: with SMTP id h6mr12348296lfh.29.1544653047623; 
 Wed, 12 Dec 2018 14:17:27 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id p21sm5856lfj.10.2018.12.12.14.17.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:17:26 -0800 (PST)
Date: Wed, 12 Dec 2018 13:46:27 -0800
From: Olof Johansson <olof@lixom.net>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [GIT PULL] Allwinner arm64 defconfig changes for 4.21
Message-ID: <20181212214627.bypoki6ypuginqk2@localhost>
References: <20181207142205.wa7hghejqteaj54f@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207142205.wa7hghejqteaj54f@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141740_365292_1EB1AF4A 
X-CRM114-Status: GOOD (  15.72  )
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
Cc: Chen-Yu Tsai <wens@csie.org>, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 03:22:05PM +0100, Maxime Ripard wrote:
> Hi Arnd, Kevin, Olof,
> 
> Here are a few defconfig changes for arm64 for the next merge window.
> 
> Thanks!
> Maxime
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-config64-for-4.21
> 
> for you to fetch changes up to 4f49b7344201616e327a5f94db0f534025ab814b:
> 
>   arm64: defconfig: Enable PWM_SUN4I (2018-11-13 14:06:40 +0100)
> 
> ----------------------------------------------------------------
> Allwinner arm64 defconfig for 4.21
> 
> A bunch of patches to improve the coverage of Allwinner drivers in the
> arm64 defconfig, mostly targeted at adding display drivers support.

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
