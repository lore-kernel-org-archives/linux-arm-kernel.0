Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DE5C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:41:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2D020672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SGzvzdSO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDkM+Mr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2D020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:References:From:Subject:To:
	Message-ID:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c0r+iAwkKYSAoBG/S90RK1zu8f2YIWLvuJZYeuI2dbU=; b=SGzvzdSOYjbQpF
	gatwaKUe6WRI+1IBIaQTfn4bCbeOFq16AN4abTAJw5XGUTNVfJ+6f4ZM8ltIk8t/xXOHoyzSjG1ce
	N5np8dobsGm+kfPTPUiFBckRBheRFLJpgasI4YA288Y3dmb1e59saOn56DmubXePK7Z2pEB3RB9n6
	Qjgl09A5VBa0dkQeN4AyF5pUblg8g1sa0oj/2R6CMjsUbz19GxNO/M+YoedA6hiX/jLL1Hg7aY34L
	spL52mEkTj75QjEghwpgnBxiXIusithj9110pOIEeY8zaRhFAToeGzd+tPnwExbZVTrcuo58LoUUm
	yrORLncebf7WWl/O1H5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWRQr-0005SU-O3; Mon, 10 Dec 2018 19:41:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWRQd-0005HE-GU
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 19:41:20 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0EE4820672;
 Mon, 10 Dec 2018 19:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544470869;
 bh=Zl5CZWZw619W0iwbDydnx9ees4UuGnSgQ6tkP44mFew=;
 h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
 b=IDkM+Mr4nkcpDv3Q+F/cXHCxFBxLrjyyKqbjhREUS9r/gU3Ds53uDvrTSstV6Z/jB
 mgvKMVEvD9jNbpybpwAw+RM1BTQPK8iVcJZ3mBelrBkbYhBSzbePY/7CN4gUq/O836
 infP9uO0aPSvWh8HZP33tMpF95He+87BODJk7lds=
MIME-Version: 1.0
In-Reply-To: <20181115143028.19087-1-l.stach@pengutronix.de>
Message-ID: <154447086823.17204.18171176566068710285@swboyd.mtv.corp.google.com>
To: Lucas Stach <l.stach@pengutronix.de>,
 Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v2 1/3] clk: imx6q: reset exclusive gates on init
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <20181115143028.19087-1-l.stach@pengutronix.de>
Date: Mon, 10 Dec 2018 11:41:08 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_114119_569899_077A8CAA 
X-CRM114-Status: UNSURE (   8.17  )
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
Cc: devicetree@vger.kernel.org, patchwork-lst@pengutronix.de,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Lucas Stach (2018-11-15 06:30:26)
> The exclusive gates may be set up in the wrong way by software running
> before the clock driver comes up. In that case the exclusive setup is
> locked in its initial state, as the complementary function can't be
> activated without disabling the initial setup first.
> 
> To avoid this lock situation, reset the exclusive gates to the off
> state and allow the kernel to provide the proper setup.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Dong Aisheng <Aisheng.dong@nxp.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
