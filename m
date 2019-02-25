Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10122C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:20:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF681213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="roz9Gl7q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJjGa24W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF681213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6WMIQk4qlJ6hAQuv1DzmPvBrdy54IteWoVN+JAutQis=; b=roz9Gl7qFx/3JB
	Ce6ry0nhJWOAmTsoKpBrYQhiRH7bfMhYpWL8Gj75l7dQz/AqFO9+AaqopYu9KNwfUoDjScDlyBVWS
	PApdctyzuBhfmZWvbSxucJ7e+7V0LZRCQKAL+aKLbb8yKZOPJxOlxcsFeJjZ4U0lFvqHhTTI6hg5B
	75sc7M1VpxH4wTXLwZYcWknj0FJRdxz9qG9yohndXXhKG0LBT3G8Ny+oaTHz34rNCyi7OB9Ol/dIu
	0fneAeCwFUXn52FDpKzkonZBTfazQUs+fD6mjNAcJaY6tHcgFh9n6ca1OC/9nUznUAXNTyUxxWYQv
	I8Vcix3lnOs5Q35ddO+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyJv1-0005QW-7Q; Mon, 25 Feb 2019 17:19:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyJur-0005Gr-Us; Mon, 25 Feb 2019 17:19:49 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 88B0520C01;
 Mon, 25 Feb 2019 17:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551115185;
 bh=0Z2Kt6pc2YzN2cXPwg40k4HA+RyQIKvmOcHJecxo5ME=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=fJjGa24WdOQ3bGsf0hpMcEHFLQCBSs5VBNVuj4/XeSHP8S92Nwrs40EFUh21RF2VZ
 R3Pt6dJPm9JSt1lnQDyrwxR8eP7cTomGd6bpVCu70aD2KzFl2XKCCh7IxyHbaDI+Vp
 99cRWEE63Gcr4o315HzRjRay7hR/HMwN4xvHrxxY=
MIME-Version: 1.0
Subject: Re: [PATCH V6 6/8] clk: mediatek: using CLK_MUX_ROUND_CLOSEST for the
 clock of dpi1_sel
Message-ID: <155111518481.77512.14619508720748400478@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190225020912.29120-1-wangyan.wang@mediatek.com>
 <20190225020912.29120-7-wangyan.wang@mediatek.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190225020912.29120-7-wangyan.wang@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>, Michael Turquette <mturquette@baylibre.com>,
 wangyan wang <wangyan.wang@mediatek.com>
Date: Mon, 25 Feb 2019 09:19:44 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_091946_343002_A8E03EEA 
X-CRM114-Status: UNSURE (   6.63  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 srv_heupstream@mediatek.com, chunhui dai <chunhui.dai@mediatek.com>,
 David Airlie <airlied@linux.ie>, Sean Wang <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, wangyan wang <wangyan.wang@mediatek.com>,
 linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Colin Ian King <colin.king@canonical.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting wangyan wang (2019-02-24 18:09:10)
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> The MUX clock of dpi1_sel should select the closet clock for itself.
> We could add this flag to enable this function of MUX in CCF.
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
