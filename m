Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31464C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:04:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08C020844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iskibll/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfBjA3p1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08C020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pyiuKKQv0kjxQ6JEldF/oYIK66AwjS8ou4rOKJJx7Ys=; b=iskibll/+tiDml
	Mkl2N/SdzhmulDNtCFXeKzBxdSsZzPk5++f8YJ4WCTSkcsJfAQRIhFYjvqxc3H2SLAqhkcYYSQtmK
	slZumvy3ElsVCU8z++d4KDrCR7/vZCx/D6lHH7ymaAoQJw9+84KgrS6auz6c3+Z01f3o1Qk5t/Fte
	xbxjsnu6EeXgEGKksDmo199LosKgW4P8zB5aD124clA//jB8ca64dDQqMReqne/0nCLV94KquqtGf
	EoA4yU0IRq9lWXaqg1RoM7UeKm0eJ+TwdtPpAGgKE3ZrUEsKKOsYIfSOiL6Dqi0TJsG0txzos3mQ/
	BAnQHmRPPAvcjx3jnh8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grNoD-0008TI-9R; Wed, 06 Feb 2019 14:04:13 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grNoA-0008Sx-HT
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 14:04:11 +0000
Received: by mail-ot1-x341.google.com with SMTP id 81so12016430otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 06:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rkCVllBnqzQMwynbgyb6Rr1EcS6TzdcvH+7bY+VEMjY=;
 b=CfBjA3p11ESacOSDspGpjPwMpKlIXrB0YGO9LbkrORCFqjM+OPE+3seB4YBDEEwOBv
 AuEWSjE1kMBBF+NsFxbeY9ZXseTomuy1skIVFaa2XVjW+jEobSERzkEu46ZH5zI6kN1c
 LmuF6RKZia++u50bonX4FgdO5/zegxDGsZBEl6c/FKv1pGZSKNRm79FhajFqjFR5v16A
 3Ur8dOpIN7LoaKHpUxBiL98klZqyzOccYPFAvyIpf2fVW8uMK+qxu7p6ygzZWxZ9TpPs
 MntGWRsb1+adSiB0XaPCOZmyPrpb7bbLQAK4vP+Xc9oC0jiXnLF3lpyQFMZ8yYVN9PY8
 AqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rkCVllBnqzQMwynbgyb6Rr1EcS6TzdcvH+7bY+VEMjY=;
 b=Ij+3bvnBza+HEgxEAPvUK5Ix5+X5dWQrGcaHVc0u3/x6Y0h8zq9pyoPVwgPWZaA8Y7
 M/FqvgcGykAjQf3oxsTwJ+770+DzCoru+/xX5seyxLfox31qFc1m8+gdZV9MMdUOU4nC
 i1G99S0qE6xdVs1tM6WC26oT5Wj9VqDR6Oh7lz19GxdsF8pSuYZM176sItCqmOS148eD
 ukK7eatXrhinB8/6FgTejkGUYTRLI9yv7TZCxw4UBBqz3HOqzOtz9/3ZJX0V0cZngtmS
 2pk93hZrk7o6r3DL8kaPlTUxrjd/PScWC5ZE+sWyhx6Nymv+Kmqqpi6RZrNUsIWOLH61
 2Jgg==
X-Gm-Message-State: AHQUAuYY7eMwQ5LK8EMMseNvBzpL4dh10g6KWE1KkoaegjIikqC/4f06
 PUgxqeYoX4jz2kbdbQs2o+CX8vCxTo5QkBOeQ+w=
X-Google-Smtp-Source: AHgI3IbcBgQlK8tAxpxgAoodOJsF+DDHswEGtOczq/DpEPtJKDMDBBl3Kwhxtvq8izY0UMO6G2lv6pY5DlQVVgygxbg=
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr5605847otl.196.1549461849250; 
 Wed, 06 Feb 2019 06:04:09 -0800 (PST)
MIME-Version: 1.0
References: <20190206140241.25216-1-ccaione@baylibre.com>
In-Reply-To: <20190206140241.25216-1-ccaione@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 6 Feb 2019 12:04:06 -0200
Message-ID: <CAOMZO5ALj8Bna5XNp9RMEhy1oVo_gQm1hMCD_RPSrXsq3sT0MA@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable PFUZE100 regulator
To: Carlo Caione <ccaione@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_060410_599820_A26DA999 
X-CRM114-Status: UNSURE (   8.73  )
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
Cc: Abel Vesa <abel.vesa@nxp.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 6, 2019 at 12:03 PM Carlo Caione <ccaione@baylibre.com> wrote:
>
> This is needed to boot correctly from eMMC on the i.MX8MQ EVK board.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
