Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF59AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:05:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E67A20665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XOQWdyke";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNrE0Ldj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E67A20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:References:To:From:
	Message-ID:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F6LwB2AuZZpcU/IWIEYwMi5sCQ1etRhGL6Vi7yM5dAo=; b=XOQWdykeiESMYI
	zNZddfIrGm0pY8Z/vrH1EboseB66cmLlgWkWWZKRI28zcIycno4jeKfKXzpzpQM9/zDoCaHeBzIYA
	FRiTDacsQIhJ0V/DLFPShkQ5Xf/Cp3HiyjhBZ/S9/dsG16EswvTUWmzj7PtloBdzu4wcRvp3hEwQX
	ugSUwhGVT6zS2jutBF1+h2h9RKnSe1SSxFarf40jacaBSKZPbNo82P87iS1F+JAnOl9Y264j/1lvn
	PRXXmVyNUSWRYBp1Xvg6LzGGpQfSmc2U5yATCzans8A6lLlWwiN6MAGqFW9lS8nCkDDe10umdeV7f
	+ihTJx6VkNVVCfzO8W4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghiSD-0004ar-LJ; Thu, 10 Jan 2019 22:05:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghiS9-0004aV-Up
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 22:05:31 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E7AAE20665;
 Thu, 10 Jan 2019 22:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547157929;
 bh=Bm0/EVOr7zy7YFL+ZJVb7CdFN2+3fSxFrYfd8QKs/MI=;
 h=In-Reply-To:From:To:References:Subject:Cc:Date:From;
 b=HNrE0LdjuI3BQZhqkVaClysGpj67v/8FyZOi4Adt7dUErcCBAM44VTGnAg6mYJNCr
 TMxl0DwGQ4o0h8XVgatYN+XEpFTMmgYsz4mgPlNbR/kVBhQThykb8WoDWCvgW2jZ1N
 bI0OerOYw5krP/0dMbX/x/6CyFItq94fbd6BoYb0=
MIME-Version: 1.0
In-Reply-To: <E1gXVHy-00088e-JK@rmk-PC.armlinux.org.uk>
Message-ID: <154715792793.19284.6256735661009793613@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
To: Russell King <rmk+kernel@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-oxnas@groups.io,
 linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVHy-00088e-JK@rmk-PC.armlinux.org.uk>
Subject: Re: [PATCH 2/9] ARM: qcom: remove unnecessary boot_lock
User-Agent: alot/0.8
Date: Thu, 10 Jan 2019 14:05:27 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_140530_012777_3DD2840D 
X-CRM114-Status: UNSURE (   6.94  )
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
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Russell King (2018-12-13 10:00:46)
> The boot_lock is something that was required for ARM development
> platforms to ensure that the delay calibration worked properly.  This
> is not necessary for modern platforms that have better bus bandwidth
> and do not need to calibrate the delay loop for secondary cores.
> Remove the boot_lock entirely.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
