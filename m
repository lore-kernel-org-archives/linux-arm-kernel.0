Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C64C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:38:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373F321473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aHvFdHv5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="gdH1PxCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373F321473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7Vz9PZ+YVF5tK9KxFyj12vVqB8n1WG0f1+BSjRQOPgc=; b=aHvFdHv5JWxlok
	tPX5FnM995mpxxy4EkwS0cKFTphN0sBpFp3/aP2LBRPoBclvj1kQGGvGt3h14D07JBfSEcn4RdCHU
	Ux++KXhLc1SzBXj2ttgOpCwqsczVG7UR9wRUGv2g3D1xsBuw1IGEE3FQWE/tFH2n0H4zY+Y0TgXEU
	Nwb0O4ifVfMdblWqrHe/WOp4sEXhCuvlM6U8iehvJ1ea6HU+jFvZmuwfEwIa6H94ja8kB5rKvl6qE
	YPubO/MviT0Y4dvoaATWnte3M9imobGZTAY8V+2LutBBjd5CwKm3igecYeRADFMKdNhMoMyEsjXf9
	lb812eFKlEQJaZRTRcWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gogha-0007zX-OE; Wed, 30 Jan 2019 03:38:14 +0000
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goghX-0007zF-Dv
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 03:38:12 +0000
Received: by mail-qk1-x742.google.com with SMTP id o125so12929143qkf.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 19:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dg2MenSHWrAwQe2mYdpL9kjlGddqbZ3q0zPRrt2PF6o=;
 b=gdH1PxCX3i5nIlJRizCaRCrYu2gZ8oLTOqelWVQtJMVkMvi4hxOQ/ignri279EpM1B
 FQBbxF2oSU8sgmVavHZSCGPc+OaA2exrhvn7NP7o82RWroktpcxTsKfEFNJo66qAd/Cq
 tXcPJDRorwazIlKq//clip7tOHR/Vvwjz5DYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dg2MenSHWrAwQe2mYdpL9kjlGddqbZ3q0zPRrt2PF6o=;
 b=Jg5IxW78aGuupCJd7E63bSVDVKEWKWwfoP5yKCloxCFjLwU1RC25Ud+eAxMbXVnbRU
 U/bfIfU52cmUvgt69JcXKBeUI6wFbVtgIzXsWphv4GHPek61l3oXzMjypQHd3mBbUlBS
 wSBGPmEleWkLxmJwEbgFw+0HaGlJPHt4zlyGsYqVTY/p7QNTtl/NC2MXs0TL838Q3LJO
 qaBvOIPwjc5vy7MBMdZEMVMv1PBvzsCLI4CFV7JpZo2CYJkj0XXHE3x1TVeHkFFnH6ze
 TLo69+SmcNbJYDCCWjhNlrw8iQlTBWijhY7YiWIncHRvPuJuZeW6giMfeJJxl85B7M/i
 4FIA==
X-Gm-Message-State: AJcUukeYxRqBLLM3I8U+ud3LkqR/f1lRcf++vjkGAEnNU5NCMqep/5mT
 HbYfBXeSfbzfKyC8lshGHCx9bJ9MPcFdyyuJPDE=
X-Google-Smtp-Source: ALg8bN5yQjI6Tf9kyG+GP6w6clWGHJ0xefs8q7tANRJ1rMrsVVqXcCyM+uPDE890R+YUZ3zgWz2ChuW1j9/frM7fBJY=
X-Received: by 2002:ae9:dec5:: with SMTP id
 s188mr25826624qkf.127.1548819490344; 
 Tue, 29 Jan 2019 19:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20190129214624.119330-1-venture@google.com>
In-Reply-To: <20190129214624.119330-1-venture@google.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 30 Jan 2019 14:37:58 +1100
Message-ID: <CACPK8XeSoOkOqVtc7Xhov7Zrj8sMc28q1-BQ_t-d5FTYXMkggg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: quanta-q71l: enable lpc_ctrl node
To: Patrick Venture <venture@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_193811_465914_CB19CF87 
X-CRM114-Status: UNSURE (   8.00  )
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

On Wed, 30 Jan 2019 at 08:46, Patrick Venture <venture@google.com> wrote:
>
> Enable the lpc_ctrl node in the quanta-q71l dts such that the LPC_CLK is
> enabled.
>
> Signed-off-by: Patrick Venture <venture@google.com>

Applied to the aspeed tree for 5.1.

Cheers,

Joel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
