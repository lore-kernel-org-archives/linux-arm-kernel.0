Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B43C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:21:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F8F21B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lVJjWHz5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0HTc/V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F8F21B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZV8ltLuEN5zzL+L70ZxJ43V4GAaLdWzpp8+p4/uKmbk=; b=lVJjWHz5BDqYe9
	A9wk0/Ioi9a4YwLAQEFBZOfg1cFihL3Yh2rGBIWHuRRaxFl4BxYFe9/BYVAJQuiJFEXIuezgSGG6n
	ONeJ3WUZZ0v9t7fIPsRAqX5e1S1mT8OWnofCh9h82UEi+Ddz5ExkfJO5DiqJPZLi3hCBvpu7srgV0
	ps7Gl1uwaRN+xpQBESeMojUw94Ut1J27THXDkQcHq56dnFTc3ct9MN4HIX2KXdTzpzwW1sGvE1p5E
	aFl6yrn8G8YzNGh+dTe5eFsOoZ5Sxpb7Nk1eA/rfZCKqXfiG0bd3tRLb3gUiw3mpiju1VvXn7fX7W
	U/vOU8lwqqU//T38FmtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guj3A-0001DQ-LI; Fri, 15 Feb 2019 19:21:28 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guj37-0001Cq-Rd
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 19:21:27 +0000
Received: by mail-ot1-x341.google.com with SMTP id g1so18314241otj.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 11:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rjuFhRbm8Air21Bnmbni4tnurlO2ssfQlyZnqsZlsJ4=;
 b=T0HTc/V5URWzIDn3KkI7tYDo0+Bbl4mmyQ9BH7YNwBlBWbDsRf+TrZi3n3A0Lx3V+v
 l8ED/q4hE6joQ3Z6a4z2w+1RZMzE7eHozyN9GvzZZWCby5iafOxKRy6UpsCe4jCq48o3
 1nDSImQYL11SZJRmwoyjaRBelNFDD8KntAdao4k48ahqtH+AibUqBVrJR7H3nr5Ljfni
 OMr36Aqie67OLX4YNfP8dSUb8xE7VsToZ2Xb/kq3Ms6eMRbL9Y42nFCYkEH0FfqHtTqQ
 5vKw0waE3GFmH727xh+m/M3E+CKgLVbJjhpp88sZRtR2ZP4Ly6JK4ShT0gJTIJdQKoNq
 sZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rjuFhRbm8Air21Bnmbni4tnurlO2ssfQlyZnqsZlsJ4=;
 b=l9GN5pfoPSq1HVXhmJK3zkcD4HrsiGMYwK5ro0Zq6hEHL43wbSd6TJloH7bd1LFmrL
 ocBzAQrb69a3cK360Fkq5py0VxrXhixkEXkiENY7NVy7Kxo/QbgwRpME0AS+7jIF9MH6
 eHNAB9N5HFR0kUAlqZPyV93670cc43j/G1a5ZUQRi4KGbPXIPugNOFPEy/kYCJCXoDLk
 iMi6nkW2h4cXOYqhnS973O3GtzWPuurpTT9K9f4JAkYwAPBBVvsYL2oEJTQt+WVDQJuy
 yrHF0w9/yo75+sdV1CFSsz4Kmc9Caz969wWhaUGPH8lfwesB8hDDx4ryBrRUT01W2gE6
 RRrA==
X-Gm-Message-State: AHQUAuZOebDzn3la33qzALLx2LkLmXLch8gOpoP3p+6/CfUigaCpfI07
 M1VXroaqmBVgXE8y3X9wyR0UUz4jQ0kdJh68gbo=
X-Google-Smtp-Source: AHgI3IYabZa/uknXlxqFL1sr2gEp1uExlzWsTBWyQUvtO8Ywcg4uVyJFXCyTNsGClpVWo2+1e15NSx/240RzCaTGwoc=
X-Received: by 2002:aca:e302:: with SMTP id a2mr7040639oih.45.1550258484709;
 Fri, 15 Feb 2019 11:21:24 -0800 (PST)
MIME-Version: 1.0
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <20190215050957.20755-6-anarsoul@gmail.com>
 <20190215082331.7wq6arctd4hdjcnh@plaes.org>
In-Reply-To: <20190215082331.7wq6arctd4hdjcnh@plaes.org>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Fri, 15 Feb 2019 11:21:45 -0800
Message-ID: <CA+E=qVcFiGPFr-itZnf3PVMkNfyQpgO_AMQS_VXs_HB_1u3Pzw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 05/11] drm/bridge: Add Analogix anx6345
 support
To: Priit Laes <plaes@plaes.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_112125_893241_5F9C3433 
X-CRM114-Status: UNSURE (   9.37  )
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
 devicetree <devicetree@vger.kernel.org>,
 Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-sunxi <linux-sunxi@googlegroups.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <seanpaul@chromium.org>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 12:23 AM Priit Laes <plaes@plaes.org> wrote:

> > +     err = anx6345_tx_initialization(anx6345);
> > +     if (err) {
> > +             DRM_ERROR("Failed transmitter initialization: %d\n", err);
> > +             goto err_poweroff;
>
> You can move the whole err_poweroff section from below here and drop the goto.

Thanks, will do.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
