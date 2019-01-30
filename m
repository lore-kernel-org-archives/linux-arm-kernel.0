Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186D7C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:18:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DBC218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="he6jRnXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DBC218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PqtLRF8l/kLBFZwfVOjobfwaUmGId4TzNObtVghcmow=; b=he6jRnXG8sqcDl
	Rten2h0KhCTY8MRjrW6wN9toLmyRRGmJcCUL6dJr+CELvnXlm0qi2WX/25C0anWLtJPTsG2Xq9kW7
	X/tLZIU8WM5kwhCVEbH+z6NzQtH1QY7E4oN5cwSXzl/bJtTKTX4Hv6mXYdvHdHM4MpewAJEeF2IUa
	awgl97wO2z71sCKa9OYGc9MxWtdPWwxd1lRwcVSnthLOgJp50Ch99eV6qQ4kXUnnKquJ0MVNI2zC9
	EO6OtU4jpgxfGJNhdJ7TVgOOnm8NzPlFWq8Xax8AQZTDUusDSAnIzmZ2aRZu9oeOoNkFOXP+DK7X1
	afURF7Zqcdk7a04SfSig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomwl-0001J0-Lq; Wed, 30 Jan 2019 10:18:19 +0000
Received: from mail-qt1-f178.google.com ([209.85.160.178])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomwW-00014y-AA
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:18:09 +0000
Received: by mail-qt1-f178.google.com with SMTP id y20so25516090qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 02:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AVwjnwNqByL+kIGuLHjkyOzYA0crm55SEMRS0vaoV3I=;
 b=NemUY4ITJeL9Un5qmL6uNGRQ+kDFUbx8MeeXf2elt44PFroWajd6X97OXtgqf2sGfu
 //3khJA+okrrF6NmKnbMhvyiPTkFfp+S5dat7SsgfjnBg+6ezRnxZCHMso4U+QeBBvb0
 B7nPg9ZUFXGt15fbxWiU7uA7fRB8lXT3tiwLIB1a9INyqkNbPCu2NzrdOGJ2drZABHRg
 KCHg6xukfDzeF37Zp6bkgijsTZAqIDKiOSVtEuBUdeN+o0qiFjcwXI9eystdoJOalkXo
 mV4v2hZXgK/iSkgmNiEdoUUhBtIxP7upAuSeYEIBf4H5UMiK8yelEfzte1GlQN4gGEBs
 XFxQ==
X-Gm-Message-State: AJcUukcQG20DtW18/oUpeLsLRlz2EdWedonBx/SMEQV0ArfyiDAuAkLZ
 3iZI2rR9yzF4EdYuqMiNe7KD6exYUDgy9cHiTSXvWg==
X-Google-Smtp-Source: AHgI3IbR6zY1PMKJ7IhHCN5WdIMptjRHJSiWJZNOokgJTvhA/e8geKn1nUc/Xpbr/KZbxnK/00GIXV1hAM5DFmvTwIQ=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr17944357qtl.343.1548843483024; 
 Wed, 30 Jan 2019 02:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20190122072145.GF19929@dragon>
In-Reply-To: <20190122072145.GF19929@dragon>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 11:17:46 +0100
Message-ID: <CAK8P3a0BqxcnrPnQxp1hJd_kuDp-aTdNaMWgNbuF+hs1wEUY8w@mail.gmail.com>
Subject: Re: [GIT PULL] i.MX fixes for 5.0, 2nd round
To: Shawn Guo <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_021804_649348_E6200A5F 
X-CRM114-Status: UNSURE (   8.57  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, arm-soc <arm@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
 Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 8:22 AM Shawn Guo <shawnguo@kernel.org> wrote:
> ----------------------------------------------------------------
> i.MX fixes for 5.0, 2nd round:
>
> It contains a single fix for i.MX8MQ clock numbers, removing the
> duplicate use of 232 and numbering the clocks consecutively.

Pulled into arm/fixes, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
