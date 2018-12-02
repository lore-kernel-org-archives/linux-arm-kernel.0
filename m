Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4E1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:59:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2C420892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EY9CKaeY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="fm/2DAAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2C420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GF4ImQtmwQKkEDkYIHL4Yjv8hXWYB59lq6ublRL44e8=; b=EY9CKaeYWs20QJ
	fJNrwK+M0uDkHQ/kXf+bW/B7K6PgVnN0qSPN46aAPL91yhNGn8BNVkxX3M1jBX6/br5g3XTv/Ya2n
	MdCkYcSIhPubhzcaFFRn/HF4cv0gVorSvDpCaRSYbER1iT1NwTNN984kFpoZFB+3uhvUE4R/sGdCf
	zUw9otfxbNpFu9MgbomAg2cXCYCSRWJ1T6swORSnmKlZCnsLFWsZ/L44At4HOKSJVU8KeoJfIGn03
	dG4VeaGHZKTX0wHDNrQkPEcAy21ppyQheoTdefu2vUAGjBIOt8h/WDUaY+pevyvz81iefJJGbLh+j
	b+MskD+61GEGhBxF6Opg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTahx-0000ek-At; Sun, 02 Dec 2018 22:59:25 +0000
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTahu-0000eH-Ms
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 22:59:24 +0000
Received: by mail-qt1-x844.google.com with SMTP id n32so11773891qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 14:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2TvXV0hTCOcTxrx2KsS7UbKMfrrAJBCgpa8JkTjwFvw=;
 b=fm/2DAACjRnadLg9+sOS2DBh5ZE0aZ/sUNFuM0JPdbOeTyb0JPAZHL0oeI7RSN9DJV
 qPF+Vk4JpZ/YkeTWJ5fFGBPyGrD2c+3lObFTJF2fw7hv9lcCTacFyuzGMjHCAKlP+F24
 cOjHO5osVGHHPLXyLO9n0hSsCrxLDHVS8KF+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2TvXV0hTCOcTxrx2KsS7UbKMfrrAJBCgpa8JkTjwFvw=;
 b=SocVQeit6IJlTJs1N4eFob0cgm5St9OuvzqlQawJxoLwoDTEMMlg49nFDv4/T+9KkV
 Jq5Z9+/2T16CrP1fQjwakHuEHLdx9caZrUNr7GMWD5/7pbXNjHL6mRTe8BZpHem9unRE
 BjSpigkLPxLOxZDOJCMXg20lSng0YwZFXV3UBMGdytUrIgU8/c54tDCTfqFssiBRi6BE
 +R4q+zr8WBHkfL/ux3seo9xILAkQnFeVqv1QaS1r+J3u7sNIHaUcJXafkma9Rs37dVLr
 LW5QIFMTpWj3F2fITdV8vbXCeosjWEZAPoKPvk6Uy4MfHwDTbrLQFBTQ0zBZwXMJcuF+
 ls3A==
X-Gm-Message-State: AA+aEWZ7RoQuy76sm4zeIcqEQghuJIhagRAumtbIfkgrNvp8/BIZv9qN
 BCJCKvpkMdRx7JeRifZZd5oHF2zdGV9W9RQMeyw=
X-Google-Smtp-Source: AFSGD/UY+m2PICT71eDW75AQvAj/SGeSdxeSF1jBVruD3LfelpVJ0yHUMKEPfXP1xrdmYTaD+t8TwBXpG9UJtEhuAIc=
X-Received: by 2002:a0c:a4a3:: with SMTP id x32mr13531528qvx.89.1543791549430; 
 Sun, 02 Dec 2018 14:59:09 -0800 (PST)
MIME-Version: 1.0
References: <20181109005046.210657-1-taoren@fb.com>
In-Reply-To: <20181109005046.210657-1-taoren@fb.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 3 Dec 2018 09:28:58 +1030
Message-ID: <CACPK8XfVHDwso=kMXjk_6Q0eEJTQxUC5B=onqLfw6QzAYZU7vQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: Add Facebook Backpack-CMM BMC
To: Tao Ren <taoren@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_145922_748181_F111EA40 
X-CRM114-Status: UNSURE (   9.02  )
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>, linux-aspeed@lists.ozlabs.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 9 Nov 2018 at 11:20, Tao Ren <taoren@fb.com> wrote:
>
> Add initial version of device tree file for Facebook Backpack CMM
> (Chasis Management Module) ast2500 BMC.
>
> Signed-off-by: Tao Ren <taoren@fb.com>
> ---
>  Changes in v3:
>    - including pin configurations in UARTs 1-4 device nodes explicitly.
>    - including external pinctrl controller nodes gfx and lhc explicitly.
>    - deleting misleading i2c-related statements from commit messages, and
>      adding comments for i2c buses in the board device tree file.
>  Changes in v2:
>    - including "aspeed-bmc-facebook-cmm.dtb" in Makefile.
>

Thanks. I've merged v3 for inclusion in 4.21.

Cheers,

Joel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
