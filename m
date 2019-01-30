Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD95C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:22:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AFD820833
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YFMBJWGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFD820833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AneY0Ng1sVPc3lvNUN+tvZTZAXNEduj57/1BMQQ0Pto=; b=YFMBJWGdQJmbZr
	Q0KbZn4B4yrBIStNaQ81LE3AIhMUy6W/b/d9vqyyS+OlxdoO9tvRSa6YTOIs6SiKS6pa8dYcQL5Yr
	2VIO3MttgZ3cICzs6vM4jeqEowYsbn6Bq3LxVkGPvsBXYOEPslsQCJSep6wZNemJyM45ZrU8TxnF+
	u1jyM3F/TpSMo3OPtRpJ2zlkaKJ69oV69lHZiHlf08ou6NCkmpofT0HIGpli9vRLWiQMCyU2XGMpu
	VLR8D5A8a2dxS/UVAZm9pNNdPs2oAVhOTfhHdkYkXbkCf57QX3zJGqQnJwy1kck8F3eFnSyF13Q7k
	uz/84lT3x1llXQ7eWPhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gon0g-00054D-Oc; Wed, 30 Jan 2019 10:22:22 +0000
Received: from mail-qt1-f169.google.com ([209.85.160.169])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gon0e-00053s-GO
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:22:21 +0000
Received: by mail-qt1-f169.google.com with SMTP id t13so25602419qtn.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 02:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XCMMsmst+3+HktudzZHx/d439ItgKF2SLn79lrde664=;
 b=K13TE7iS8nOcOonyA8m4TKcq9ECX5FDaua/Mlds5kysVCAT/YcKVY7y6sr2s6BY5Uh
 xZw0RtFEM7tztvqzoghs/76qQ3bETJkx0i13VZuVFAZGHlXV9JojGsehqO0a/XpEvgpY
 WPjDJ4VKAhk0OU+6uTVziy/Y4F5pmWmbVPI2gzguCPbnTWVZ0GTL5W9SZuzPulFu3CN4
 VtcyTnWzzZ+rXKK24xjwrEuIrYrQhGb7xawlysLkAq1ZHSBK1Jdv0QLxkX6Ac1hG+kQe
 0Y3HQIOOGDLpA6BOyxgxj5uDzxAsnn1kNPEQhTJhESPlcZRHizfJ4ClO7s4y+EKQKrin
 iGYg==
X-Gm-Message-State: AJcUukeUb1ttmEC60ZhjaRbhwICec6sN0lYaQzVjHiuxqJx1IugRF5Ni
 nYaD/v8YJNlObmT2P3k/jDggdABtdQA6IpGdFfs=
X-Google-Smtp-Source: ALg8bN7QMTUbGO832hZG9mmunet9FqNU7Cx7YfRlzGneukWZPgk/H1mgjWbtIcWceV1XhUADfXUlpcsUd2l2NY2gfWg=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr28638777qvj.161.1548843739290; 
 Wed, 30 Jan 2019 02:22:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548165440.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1548165440.git.horms+renesas@verge.net.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 11:22:03 +0100
Message-ID: <CAK8P3a2axojR_otZeDqia_f+YTbsWo2X9v+AQWK2YO0wPuA8mg@mail.gmail.com>
Subject: Re: [GIT PULL] Second Round of Renesas ARM Based SoC Fixes for v5.0
To: Simon Horman <horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_022220_539395_7D62783B 
X-CRM114-Status: UNSURE (   9.86  )
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
Cc: Kevin Hilman <khilman@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 4:12 PM Simon Horman <horms+renesas@verge.net.au> wrote:
>
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these second round of Renesas ARM based SoC fixes for v5.0.
>
> This pull request is based on the previous round of
> such requests, tagged as renesas-fixes-for-v5.0,
> which you have already accepted.

Pulled into arm/fixes, thanks!

    Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
