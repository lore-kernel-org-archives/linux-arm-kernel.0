Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAB0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:37:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8622146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OeCeZ2Vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8622146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PSk2NGVFKPDptXEiUza7vdj/vg3rqWZ2Y0+HINQFtz4=; b=OeCeZ2VqHVJf3m
	4WXwtWd1Tb9qytpiJ5p7yRDQR80UK9PC1hLHIjps2rWZVjkpi5KlVSLDiTae/05KgRKIGJafUC7Jh
	bzygtevZBpMeiZOAdcvrQYlsT6PDHPVkpHTWK+pPkKdgETEoj8f9D2PBYarReJkuEHw2iSZhfR9SO
	5dsu9i6UQJXZvBiV93Y/sxqX7ferZe+xUAyCanll63DQjutWoAkofnMBJRm9qwL2dONJA5/ckJYq2
	cYIb9CyHqFiYBdLnO1DllIzv3FOABdRHcRnshnl7f+FQBJtmdm9tk2g56WG3spPkXS1V9bbKAuz/B
	nfj3CIaagemRAPGnAyqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYu1o-0003pL-He; Mon, 17 Dec 2018 14:37:52 +0000
Received: from mail-vs1-f65.google.com ([209.85.217.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYu1l-0003oT-9a
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 14:37:50 +0000
Received: by mail-vs1-f65.google.com with SMTP id x28so179308vsh.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 06:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dc7j+H3dXQvWJVEO8qa6AU2PYM9o134G+rMUSo/Wz5I=;
 b=bv1ezenN0aC6uA4fPMJgoN53D4+7k5DIBEly0I5k8BBymb/tW+kjlH/P78Npwc75AH
 K5D2NwWo/8gLvZmktR3xU7CmLdKGjTbcV9La+i3RhBAjPiTnK5SZ2Uds4CxJ3rRKXzN1
 WIbRGGVE8S37xJyzBp+21iqwxSOZAcca56yCb7+I3fSYlEXEZPoBMyld3svUn+QsYoVy
 bX+Nfd1tHfmd8Wd3/joPbgJrY2VGVl5QC5tmJVlOmvkQOtJCVQf+50SoFZLO8wAeoSrf
 isOuJlpnA20vxRFFNJ9Xlvs7XoG/28i3o+3p54BjZzxwhWgjrJylmR3HXcWLjMs5QPNx
 7xJA==
X-Gm-Message-State: AA+aEWa6OdJsTJ9ygdgosr+G8zEI8tnv9mGSv76cwnlEOiBK7RH8Iu7D
 plN4ye4nGQO9QoXkw+qWdg6l4pVAgMD0QVx0kYI=
X-Google-Smtp-Source: AFSGD/Xa5R3P7XyF76I4xLpnEIOM4KIyTnT58iKty/mmF8XiFE4HukNISROWUduCwlKVk/11VErC6QEqWjv8W1TD2Qw=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr6567116vsm.152.1545057456642; 
 Mon, 17 Dec 2018 06:37:36 -0800 (PST)
MIME-Version: 1.0
References: <20181217124053.10918-1-horms+renesas@verge.net.au>
In-Reply-To: <20181217124053.10918-1-horms+renesas@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Dec 2018 15:37:24 +0100
Message-ID: <CAMuHMdWc=0iafOE4FLVA58zcG3GjZ+e11vX7xwYjNAL45wx65w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r8a77990: sort pciec0 node within
 soc node
To: Simon Horman <horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_063749_332491_78E44EE1 
X-CRM114-Status: GOOD (  10.78  )
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 1:41 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> Move the pciec0 node so that sub-nodes of the soc node are
> sorted by bus address.
>
> This change has no run-time affect.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
