Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB99C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:38:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B63B721473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LJwZ1GgO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ey0zfcYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63B721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oMtFPYpRotWLi/NB37Y5v45Rmhmr0laRFnL/plt5W18=; b=LJwZ1GgOyzha7i
	IKd7TNkF6YvS2gS42oenL5Q1Iy0/48XDLYhD2ziPt0ItX4E9Fig12IH2zMI8nItwI3hpTb7Jxkf8W
	vC/bQcz6a/CKpSmOPuDNqhEG8vfp4XvDFVHkVCOLnj2h8unVgvo8UpVCFc63+W/trfCz3Jy/jZvvl
	sesGL9lhCA/iVOd5daE13eztFSrVqSVAO9lQKZ7oGdviR/eRcWP8bbWPGrX9xfL1l541vr34CP3aO
	2o523BFmqBALwkc1MAGjkkl49GfzZTL8FHvXFeFt3vz8+OGEhv207Ghz8YvX/LP7H7zHa8MT7bTYa
	X5rflwZ1ypvbidujuLRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goghs-0008IW-4t; Wed, 30 Jan 2019 03:38:32 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goghp-0008HU-Nl
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 03:38:31 +0000
Received: by mail-qk1-x741.google.com with SMTP id m17so12925853qki.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 19:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cvQzkXhLPeLTgOpbEGZkyycdIgApjN7ax2QwNyqnteI=;
 b=ey0zfcYgibOQGdFqjPX3227zGgdcaG9Tj0pT/7QDkcrVnKKfNEmPUyFFijSQkfXWIj
 /FMcNC+NZ35wmaoDwJgBHccMEOA1G0R5c0PMvQ5BLSCghHYJsh+oQjDbYkXusHc2ZW3b
 Ov+2qt4vGLJgmzb3BSs6n3HLKU016d41tAZD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cvQzkXhLPeLTgOpbEGZkyycdIgApjN7ax2QwNyqnteI=;
 b=ET20M82WleCDSDLTDCseD3DCMwkcmPe1H4zxjdH3kflV1JZXWwsYQxhxm0o962giPK
 +EufzTpJuP59aj064xuJwQSKb9+RufAPYTT9N4W8alZV1jYhxeIK5nEPH8LZcpbapaV7
 pSoTt2uEdgrVacystsJa6kW4/Jl48fAXIN7B080kzVUtzja8jRayiEP4L3li5j55VAW7
 dnIRk2vTSmh3bEncGmcN8vgzgAXmDI9vDsnRuvwYFYaQ7PHZSOiNywdtlQdhxa/GKc6o
 qKUdGQ5m5O+7uag/k9EPrkK87M2AxQV1wMrs2QS7jkHzf0dlAlkJ0UIp/OYtOq0NXEw5
 gvrw==
X-Gm-Message-State: AJcUuke9Fd8pdTu/71NjpR9PoJbqRLdnBgifJjOySGAhuRpq3o9wFi6v
 biZ49xtsRzLHh06weYBgHtZOZx2/2FPyAzmZTZw=
X-Google-Smtp-Source: ALg8bN4JOiF64YPw5l1msQix8HtFd086FzSEg2HOYTNVQInCcekKKD2qj7EfQ/r1BM/tIDwHDkyZtrJjasFGPdT2V18=
X-Received: by 2002:a37:61cd:: with SMTP id v196mr26444903qkb.25.1548819508774; 
 Tue, 29 Jan 2019 19:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20190129214703.119694-1-venture@google.com>
In-Reply-To: <20190129214703.119694-1-venture@google.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 30 Jan 2019 14:38:17 +1100
Message-ID: <CACPK8Xfz5m6++SWoN-E_sT-n6y68vvrcvunhso4nD5Yq3vN6+A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: quanta-q71l: enable uart1
To: Patrick Venture <venture@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_193829_768035_A9E2BAEA 
X-CRM114-Status: UNSURE (   7.50  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, linux-aspeed@lists.ozlabs.org,
 Andrew Jeffery <andrew@aj.id.au>, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 30 Jan 2019 at 08:47, Patrick Venture <venture@google.com> wrote:
>
> Enable the uart1 node such that the clock will be enabled.
>
> Signed-off-by: Patrick Venture <venture@google.com>

Applied to the aspeed tree for 5.1.

Cheers,

Joel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
