Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1EFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:01:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCFB62083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bdla63Kf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFB62083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A/Bx2eWx+dGUrpWVYfPOKK9cS3cTaveHCgIrqxSVrnE=; b=bdla63KfE3afXo
	7t3EWMrSCe99DOObZuFIR3AS6CyEXJgnv5UAoAPhJthbvQd9O3eLlgOKbyemhpomOT0wC1aBmQq/6
	MNNSwVlp95Smmrd5zP9ixPPbfNyvBnwLJP4+RVsjK/O9i1KwT+QlZG+Gpp8hxez7i5DKfE5ZHiDA3
	sjMMLXj1PB2RB20s4xG3c9HrrWbGKTp8O1rVSJbJJezvz19OsB670Z8keD+SXNrVfQryUUb9JbtN7
	HpXnxYhsr6Uc93oXoDGjT5GQ+shTXzKN7axZ4r7VaNsZOH258gJj+OnLwx+UaxIMC6rPAZgquzm24
	HHiLXwsd+RAwxQZOSusg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqDeM-0007Li-LB; Sun, 03 Feb 2019 09:01:14 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqDeH-0007LJ-QB; Sun, 03 Feb 2019 09:01:12 +0000
Received: from [164.15.244.47] (helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gqDe7-0001KD-Di; Sun, 03 Feb 2019 10:00:59 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: [PATCH v2 1/3] ARM: dts: rockchip: rv1108-elgin: Fix
 vcc5/6-supply representation
Date: Sun, 03 Feb 2019 10:00:58 +0100
Message-ID: <59585681.DkdmuU3GWD@phil>
In-Reply-To: <20190131124710.30238-1-otavio@ossystems.com.br>
References: <20190131124710.30238-1-otavio@ossystems.com.br>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_010111_520603_4531DF8E 
X-CRM114-Status: GOOD (  10.55  )
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
Cc: Jason Zhu <jason.zhu@rock-chips.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-rockchip@lists.infradead.org, Tony Xie <tony.xie@rock-chips.com>,
 Vicent Chi <vicent.chi@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Philipp Tomsic <philipp.tomsich@theobroma-systems.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Donnerstag, 31. Januar 2019, 13:47:07 CET schrieb Otavio Salvador:
> On rv1108-elgin-r1 board the RK805 VCC5 and VCC6 supplies come from
> the BUCK2 regulator at 2.2V, so fix the representation in the
> device tree.
> 
> While at it, rename it from vdd_cam to vdd_buck2, which is a better
> name for the regulator label.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

applied all 3 for 5.1

Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
