Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BCEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:16:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BD0206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c5fAQM+p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="INC2w61U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BD0206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OSdXr7Y1dyoDOCBUnPh0oNkLDete5kQaYpWnTaSv2Ls=; b=c5fAQM+pXrS4JK
	BEnt6g93aQcqE240h5yklcWbb8TTic4x5lL2GP0Bt2vEnU2b7JMNf7UUv2qqGfhz/MTgEedvL2eZh
	l6J4zQhiDQXlMaUKA//J5DwkyujU1eOvvxlaAoW0/YToHrDEpF4ALD9Qj+qvRjW4ikIlmkK8Dn++L
	sFqivZZ+8ST235fSYqhlwBMDo2xjxu7UXcNKf3fHWzNsIdnzUqjgZGngyOQJSffv8MwFAwDuhd2ei
	2T7BnZ15eKYIT+zVQSt9FlqVYlL97NQ6TZmpUurrBoi4/OuxmihraSBWM2AQpwU0mggevleB9P7MQ
	CYSpmeiZZz77tAO4IaeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjxEM-0006Ek-Up; Thu, 17 Jan 2019 02:16:30 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjxEH-0006EJ-Pp
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 02:16:28 +0000
Received: by mail-qt1-x843.google.com with SMTP id t33so9708369qtt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 18:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YSITg5nLUuzLRRNJussahg969n3MJCyU4m8iRI9jkH0=;
 b=INC2w61Uc4usKolkS9ucuxWkmOd+grPEzHOp2gbUfxGgkmd6IHVIwcc3/56hgXy8FG
 Q9zNCfRcyuPEQbThRqcckovLXEnd7xDNNWl9Q7REmDvUgesxUMlHmDNYyk/ltu3qZeQm
 iPFs8p9vQR8oB63vJ+A/sLq6fFNq7gQ3EyIik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YSITg5nLUuzLRRNJussahg969n3MJCyU4m8iRI9jkH0=;
 b=AexUEWIIic3stkXEVgJH2IvjZi4YWvBp0kPvsG1t27hgjEqBnmllaw62KmHzMFeaU4
 HYA+0yGM5XyP8g2i5OYuUDdCaT9eU9t1TPTiYwQPVeVNSMZRT7s01OAYmS34fFTGqn2o
 hamGR243lExbC34VR1ZXSkJJX/8aFi3hm23Frv04/7ihO6WufREllZIfKTLO8/ZEVlg1
 pxFj3Ue6LJ9Rrp0Y6GO0uJL7qrBGrNrfZJRmyqoMX1ufMmAZMFUOIwKInWFFoMsfz4dY
 N0zmWW5meIld4dz6IW2gjDx1ek7jyzCEKh7/ECU5ceSBBAhnPVDqV+WKqQaHK8p24F0v
 jAxw==
X-Gm-Message-State: AJcUukce9bLRral86YwNxK1hC8Cgo0U8cO2bBKtNM2otihWFq2ojJmNv
 ZZrASPHt4lgitaYtofIeeojGoL7QGASfn8mfaiw=
X-Google-Smtp-Source: ALg8bN5h35smeNkZvq357fFV6Lc/Q/eQedZ7l9keLPV5CH5qacfSMicKnX2FTqRGBKPcO6d8KodWGb3tKHQmLqkfU6w=
X-Received: by 2002:a0c:c927:: with SMTP id r36mr9740145qvj.51.1547691382865; 
 Wed, 16 Jan 2019 18:16:22 -0800 (PST)
MIME-Version: 1.0
References: <20181214120423.3363-1-mark.walton@serialtek.com>
In-Reply-To: <20181214120423.3363-1-mark.walton@serialtek.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 17 Jan 2019 13:16:10 +1100
Message-ID: <CACPK8Xdtt8-fFNpx9SjwVSyS8Zy-6h8020adRaz3ym5Xfpz7GA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Add #interrupt-cells property to gpio
 controllers
To: Mark Walton <mark.walton@serialtek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_181625_870272_18CB7439 
X-CRM114-Status: UNSURE (   7.98  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>,
 Rob Herring <robh+dt@kernel.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 14 Dec 2018 at 23:07, Mark Walton <mark.walton@serialtek.com> wrote:
>
> Allows the GPIO controller to be used as an interrupt parent.
>
> of_irq_find_parent() skips interrupt controller nodes that do
> not have the #interrupt-cells property.
>
> Signed-off-by: Mark Walton <mark.walton@serialtek.com>

Thanks, applied to the aspeed tree for 5.1.

Cheers,

Joel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
