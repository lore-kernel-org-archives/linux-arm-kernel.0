Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7186BC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:48:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451D620823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eb9G6+ql";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk3/s48C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451D620823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MA8OpP9CUooDxT1zfByPvM0tYrgwiKjHhzu3NwLc8UE=; b=eb9G6+qlBDeYPC
	7G9ETpczaEKTqlICi+GJD7Hb5J/O5jB5LCgH8Vd47WGXt0OADqqBwC0pVqFQn7BMDDryP2NZiPlRV
	pP8ecZ6+VeUmjoGv4h6W86K8Q/Rl9b4MzaCASXYGOGpmPivk9AJ1jEgzzfarWN0TIBcghM8WsoxL8
	FjI2UOQnrK/nfBc433eZXqnBemx/4gOgQBCXlKq0Wt1808PgejmeDMJ6FVC4HQE2eESwfo4I1o5dc
	4ZI6IB2O31tyq5nJdhU56pGPcAaC093dzIWAlXLeafJQcYOET/+Aic9a8sCkuanXHy6YQBz9YrKnv
	EMthB9bg2fim2qpWdaww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt7G6-0003O6-JK; Mon, 11 Feb 2019 08:48:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt7G3-0003Nh-D0
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 08:48:08 +0000
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C31C721773
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 08:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549874887;
 bh=USbBreDmij9gGsyvuqdUdGistLyFa43WnOmvhiQ9Q8Q=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=kk3/s48CG7NbiZrJzGE/MNLX8My1+8x8qVaEAV9kYdutCYQjUdarbxekRPv9/pKEc
 Osqf03nsRKWYC1gwn4NTHMN5n5PWrlJdabFG0GUx1AwcXEg4mUEhSO7Ofoco5fPdZB
 l6Bw2SbziuQJaoKfVA92yY4jWnjjwdQa4XIXRJvo=
Received: by mail-lj1-f174.google.com with SMTP id o1-v6so2171530ljc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 00:48:06 -0800 (PST)
X-Gm-Message-State: AHQUAuZjngGZWIxfYIIkgQSEqE7KVF8SPSXrC1rqipHtAmo3GiClm/dd
 P1hNfAuyBRLw0i4yDniIAl52NeWvoyyqkk5rSOw=
X-Google-Smtp-Source: AHgI3Ia1N07rYTM2frCVmNxEX7R2AR2aB9qS4yZTNFU64lu3FRLGxDbSBZLSShiqffpQDWeKCoSXBYP2U2t+PmfyZHc=
X-Received: by 2002:a2e:3a10:: with SMTP id
 h16-v6mr21125806lja.184.1549874884990; 
 Mon, 11 Feb 2019 00:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20190210225114.20110-1-stuart.menefy@mathembedded.com>
 <20190210225114.20110-3-stuart.menefy@mathembedded.com>
In-Reply-To: <20190210225114.20110-3-stuart.menefy@mathembedded.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 11 Feb 2019 09:47:53 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeHMTZn0h8aVU4btg736XyHxpYHBFy1Up7jZgmQa17gtg@mail.gmail.com>
Message-ID: <CAJKOXPeHMTZn0h8aVU4btg736XyHxpYHBFy1Up7jZgmQa17gtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] clocksource: exynos_mct: Clear timer interrupt when
 shutdown
To: Stuart Menefy <stuart.menefy@mathembedded.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_004807_456979_5E30F45B 
X-CRM114-Status: GOOD (  13.97  )
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
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Kukjin Kim <kgene@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 10 Feb 2019 at 23:51, Stuart Menefy
<stuart.menefy@mathembedded.com> wrote:
>
> When shutting down the timer, ensure that after we have stopped the
> timer any pending interrupts are cleared. This fixes a problem when
> suspending, as interrupts are disabled before the timer is stopped,
> so the timer interrupt may still be asserted, preventing the system
> entering a low power state when the wfi is executed.
>
> Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
> ---
>  drivers/clocksource/exynos_mct.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
