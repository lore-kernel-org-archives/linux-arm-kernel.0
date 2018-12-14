Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C87CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:00:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEFF2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aJ7BOmtQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcopODKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEFF2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AyQ1DBBZLC1U/OoFX/QFRHCv5fpvSL1yBfLG9u1bdyk=; b=aJ7BOmtQCE/qbu
	US1FbBT180GYBJ0DLPoEqvoNByCGOnk+lBmxoHv62DtXtjvZLeWKRSxvcEajYDcy71krR5UiukVAT
	qpyQCdhn8L7+4sM7mDqApHbAKvjAkbsZ1osi69HKVAO63D8qRuX7TcgZeNLhqLb+iSomgkQPpok98
	fQNQlb5lq4r20Nm+SariF4brPB2DbLEWzmaRNO5mV58uzxlOx4DAtTyfa5/cpVFUIdbITMtMPiOAX
	fmm93YNEuAOJEfupfOPMbWr/Yvm1fvaGiJiUGP32BsQ2WcWZQDcE948d6Bccj72QqGz5fJdT+VM+u
	ntSo+D8gOE2iy2637bVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXvV8-0005g6-Qa; Fri, 14 Dec 2018 22:00:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXvV5-00055Q-I5; Fri, 14 Dec 2018 22:00:04 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 95EEF2080F;
 Fri, 14 Dec 2018 21:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544824793;
 bh=HM+pvOXnrVygvetIkh6Obe539vg/4SVk5T1UxvWkShU=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=QcopODKbU4RpoGGdn8CaiRzYCU/HTo1GxBNIQAkfnin4+0SoY7JLy1pQmUnBNZP/7
 cneCLtH+NeFt0qfa2HRhcAE1F7a3rYarI3yncT//Ffz3m24zhU2bl88o4t8AKcsRqM
 RiVaM/Z7hQugntgLwxpKxMn6fCPjoXD+8PNTFGiM=
MIME-Version: 1.0
In-Reply-To: <20181210073240.32278-10-weiyi.lu@mediatek.com>
Subject: Re: [PATCH v3 08/12] clk: mediatek: Add MT8183 clock support
To: Matthias Brugger <matthias.bgg@gmail.com>,
 Nicolas Boichat <drinkcat@chromium.org>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@codeaurora.org>, Weiyi Lu <weiyi.lu@mediatek.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com>
 <20181210073240.32278-10-weiyi.lu@mediatek.com>
Message-ID: <154482479243.19322.7465842539016312943@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Fri, 14 Dec 2018 13:59:52 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_140003_654762_E9FA7ADF 
X-CRM114-Status: UNSURE (   6.73  )
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
Cc: James Liao <jamesjj.liao@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Weiyi Lu (2018-12-09 23:32:36)
> +       "apll2_ck"
> +};
> +
> +static const struct mtk_mux top_muxes[] = {
> +       /* CLK_CFG_0 */
> +       MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MUX_AXI, "axi_sel",
> +               axi_parents, 0x40,
> +               0x44, 0x48, 0, 2, 7, 0x004, 0, CLK_IS_CRITICAL),

Please document why CLK_IS_CRITICAL is being used everywhere it's used.

> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_MM, "mm_sel",
> +               mm_parents, 0x40,
> +               0x44, 0x48, 8, 3, 15, 0x004, 1),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_IMG, "img_sel",
> +               img_parents, 0x40,
> +               0x44, 0x48, 16, 3, 23, 0x004, 2),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_CAM, "cam_sel",

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
