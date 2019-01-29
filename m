Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92237C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:06:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CBB21848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ksnd16Zo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uf/grt9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CBB21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Message-ID:In-Reply-To:From:
	References:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+iSl+jRG3Y5do5FnDaDqrI763EsaF3VKPdfPq0qxjYM=; b=Ksnd16ZolEycYM
	vqFuHQ+C2KIlTOXjmUWbJ+bv4kgKGoMVq+QcydCv5Jw8C5ZvphDrj6eANjZ2NNDvO3oK+FrJKAg9m
	djmpGwk4gwHf/u7aCDIPFp2lIe2yBmVEYV1oGr1E52yKYfmm/xji+mlQyJGCAVUMzfV1zfrOIF473
	BrCL6dVIWE/mVTdFpd/FFAflemPnf+HZpasgXn6zOnWjdaapPq9ssPDkOD2yAPnuVuIHNsxni7tXl
	AOhXVA5Toy2BiYnUdFqERoD+yoV67tdvcKMUILpAer79QE0jmDMEuk2PuWNr/YomA89hJfc76+Gtn
	SyiMvF5/2i2wESec0TZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goXll-0003XI-L0; Tue, 29 Jan 2019 18:05:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goXlR-0003F6-Pl; Tue, 29 Jan 2019 18:05:47 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4CB5121848;
 Tue, 29 Jan 2019 18:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548785137;
 bh=aY4qLPsm9WmJCDv1/BCT8Qr0kdxJN9rRtFiw1OCIHcY=;
 h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
 b=Uf/grt9PCNKNgs6MmaPeUdkZCnwB3re2FQX0JfpgEMkcYdiaPeQKZc+eW0KWCuauL
 StkbvWt8SJcW1z4EwKBVs3Nj6xSke6Ks9LXG+Kp/utDZWCQSI+IzT6omhj3QI59g65
 qE+/GJ1xwKnynirraT1soR7C0kw3jOiuePqmIlAg=
MIME-Version: 1.0
Subject: Re: [PATCH 02/14] clk: meson: use CONFIG_ARCH_MESON to enter meson
 clk directory
References: <20190128180430.28689-1-jbrunet@baylibre.com>
 <20190128180430.28689-3-jbrunet@baylibre.com>
User-Agent: alot/0.8
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190128180430.28689-3-jbrunet@baylibre.com>
Message-ID: <154878513659.136743.11122005516300472127@swboyd.mtv.corp.google.com>
To: Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Neil Armstrong <narmstrong@baylibre.com>
Date: Tue, 29 Jan 2019 10:05:36 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_100538_431044_DC1C884C 
X-CRM114-Status: UNSURE (   5.23  )
X-CRM114-Notice: Please train this message.
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
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jerome Brunet (2019-01-28 10:04:18)
> Use CONFIG_ARCH_MESON to let make enter the meson clock directory.
> As part of a rework, CONFIG_COMMON_CLK_AMLOGIC is about to be removed.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
