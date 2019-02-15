Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE078C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:53:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D6C2192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TsUcFYfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D6C2192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b5IZTrhQZLZlmQpvghpK1aKMJkJjQtipYPisVcFQDJ0=; b=TsUcFYfF5rDoxl
	wodle/iWuFUYqUkfzZSpqq9bJYwG9T31uAMuqf1bB5cE2itiAdRrvhAlbO8Rp1ARA/3stlV2kQKBz
	s1IR3UQsVtNCyLUvgM/zGhDVjwGniqNUJUe6qnb4j4gMNCtiaex73RdZZPaa1m28YgauXgHwYVWFY
	9/6HNeHTYb+4mx25qLQkhFicD9IaxXfcpiJ5fOWw9eo/+rjvmn3de7t5IdNfAJ/h0s9UxfrR8UJT/
	HsUOkqKigCepP+m1Ly39byChDGyZkuKIPrnyxBAzGdlJTSmmG5GNiZdreY3p0+SJJ/v7+RcAv54Um
	a8SuWNrXwvJ+olacRgDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufns-0005y8-26; Fri, 15 Feb 2019 15:53:28 +0000
Received: from mail-qt1-f170.google.com ([209.85.160.170])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufnp-0005xl-2T
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:53:26 +0000
Received: by mail-qt1-f170.google.com with SMTP id 2so11369132qtb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZKvOL2tcGHCIv9Ijfh4h7QUdMeLq3iqfMVK04YsEjOg=;
 b=bz+yNBWpCc3LzxDxEk/IDoluP7LYLlxn3hNoPRw69kS/xP16Pb01xOH0h7WOih1nhu
 6aFTK2DMPObYMTDG2kAgY4vNdgZopzVAYcnHgJoKMkZ9HrikFObs7FNZi2VjLiV3vq2/
 r6GHXbBJEpgu0O/NWyXMWOnEWbzUtqoG5VmpkBU08wg6+Ysf2hfdR9gZQr0hRI6+1nsH
 lLlYYDFxTZnlK24DngyGfoJOr2MWhXHgmxM0GhdTWmNhDev48azCCexzrJtrQIjCMXWb
 2SCgnDOC0StyCGVeasn/OIwX09wkSe2iTfGDyWosJQ/maZbmYMjLmfQJJ7u0d1qJjq7P
 Gp7w==
X-Gm-Message-State: AHQUAuYDogGyRC6l1ZfIb9vTC0OGjWK+lrUbraXSA4oA1ZWxgCk4+uLT
 2Cj+SzxFts32i+Pw0jZycnAgRw1i2cis2uN6Jt/NWg==
X-Google-Smtp-Source: AHgI3IaEO4c2BSmcN3qfmD1mYrRO4y3Xhvj9ENoIlsZ3HL+kbedeekHtOtJNQEMi44vDlhep5LnIhsP+jg/iF0sSa9A=
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr7614072qve.180.1550246004257; 
 Fri, 15 Feb 2019 07:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20190204160210.18046-1-dinguyen@kernel.org>
In-Reply-To: <20190204160210.18046-1-dinguyen@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:53:07 +0100
Message-ID: <CAK8P3a1XT-WPXwh+63w-RVt05V0N8_esTN7DKw6beZ3W4u+X+A@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] ARM: defconfig: socfpga_defconfig: updates for v5.1
To: Dinh Nguyen <dinguyen@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_075325_109979_BE286C34 
X-CRM114-Status: UNSURE (   7.04  )
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
Cc: arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 4, 2019 at 5:02 PM Dinh Nguyen <dinguyen@kernel.org> wrote:
>
>   ARM: socfpga_defconfig: enable BLK_DEV_LOOP config option (2019-02-04 09:30:34 -0600)

Pulled into arm/defconfig, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
