Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF5DC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:47:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8FDE20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sIVhcFig";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI3HDKdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FDE20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:Message-ID:To:From:
	Subject:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b64g3VT6Ldi+g8fk92pUJVnukO0M5cUIEG8RfONQPM8=; b=sIVhcFig9wyqxL
	DLLWpf3VZOTWkrwI3MRdcg+h6EEFozmQVVofYcqA5S6QrQm1bkXTHWG6XOjK/eZH+/dAnbuzOvuW4
	UwZUES+d3WNHnzcYEOFq7PTCH0h5+LOPiOGupQoJnQ7pbZYr1FmNL11AB1xw+OMuGp+KC07ub4orD
	iek6RC0GBKbO2qYsAaexLrfdabhRBUU+mouhPoxYzYNnFwGY9YQiN6e9gDFK4P0w9K3I+4mh+jTdN
	NqJ2oayz9mvmh4F/KNopjM0wB8PN/DHlJBsUzvJWUwMoJ79zLLqJqoKPOaGMiiiql7qIMgKf9HX4c
	I+feJtIA+WvO4qll8Wdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVM5m-00060r-F7; Fri, 07 Dec 2018 19:47:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVM5j-0005yA-Kg
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 19:47:16 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9DB4220672;
 Fri,  7 Dec 2018 19:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544212024;
 bh=pexYbmdn6og4rtzBsXC5ZK5tpzJf2z86eUawaok+rNs=;
 h=References:Subject:Cc:From:To:In-Reply-To:Date:From;
 b=kI3HDKdquUG/9K4OCQWEY771b8XZ4mWYAQiZQnuCqmgALB+L7ObCmr74JdgCX8W7E
 La0iGC/SiNrSzRNE7/WxHWI9Q9NXm9LIUcS1p/Q3g9cWy9weZtLQJUAs8a1fHpUkC4
 eHUB1FhI/T0N4WWMPzBlAxez3kFInPG0oTaYaPWY=
MIME-Version: 1.0
References: <1544209088-25602-1-git-send-email-andy.gross@linaro.org>
Subject: Re: [Patch v2] arm: dts: qcom: msm8998: Fixup clock to use xo_board
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
To: Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org
Message-ID: <154421202373.168715.6410962945648112535@swboyd.mtv.corp.google.com>
In-Reply-To: <1544209088-25602-1-git-send-email-andy.gross@linaro.org>
Date: Fri, 07 Dec 2018 11:47:03 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_114715_694378_35B4A0C4 
X-CRM114-Status: UNSURE (   7.16  )
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
Cc: Andy Gross <andy.gross@linaro.org>, linux-arm-kernel@lists.infradead.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Andy Gross (2018-12-07 10:58:08)
> This patch sets the msm8998 xo clock name back to xo_board.  Recent
> clock tree changes fixed the clock tree and the change to the xo name
> is causing issues where msm8998 boards do not boot properly.  Let's
> change it back and leave the xo label on it.
> 
> Fixes: 634da3307b08 (arm64: dts: qcom: msm8998: correct xo clock name)
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
