Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27686C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:38:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5AB20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OU8j1KVE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="frDJB5yT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5AB20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pb7a9BH90idbx8v691iG0qGmuLMZ+EAr3XhhWD3m0tg=; b=OU8j1KVEpwWf+D
	Hq3LS0tE4YqhLjuPE3grRJWGCps+xI+eRAuETOgKHeIp7bcQOU3ZN2bZupyMwtK3D8yyoNOBE36BF
	uu/S7Qv/CPE5R7Gvng1QlaTWO3uXYYvxI3ijSXBXprYGHi0/hT4FimcQ5azJFQx43VJhO7rhBkH6Q
	MKPdTgPLQZt3PVFBTR1JS1xXj9LzEJCW3Hn78d3RnGdEeSGGRUd8V6dEZse99973BsONPKJKLxehL
	WQewHq1lKOUKXz1bSJZ4S1dzmtaOX+PtiHBh1nMQZathcJ0+cabVfco+x1wrHQDaVkIh+02i9MhOz
	mrSFJh2TRtaxAi1Q4X0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsBzB-0000xb-QI; Fri, 08 Feb 2019 19:38:53 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsBz7-0000wq-Hn; Fri, 08 Feb 2019 19:38:50 +0000
Received: by mail-ot1-x344.google.com with SMTP id n8so7771724otl.6;
 Fri, 08 Feb 2019 11:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DXIpWl5b+yrM9MNrm6OgioNthJkGr0ZFx09tr4O3T54=;
 b=frDJB5yTuzoJE6mcdGbiRksRwCg9LedugnZnQDy54kZgYr51Nv+vf5eSpM3YK5efne
 t2r+BrSc8TBuERHoMvcyVFHAwHTH/7NaM3z/XREy+8Xix3M2jZG5zkWfsNy9IBjU6uhj
 CzIxwdi1wzkxGrzI1oZGHNuUIo4OMH+1AOlbxp/MVlgmYc2CY6ynnchpWrkEiBjegqum
 1PchFpBy8q3GqU+r86ihFfRdU9hlUbYPjNzOxOXEpLpkfnAnSiTYuma4MFe3c3aUvELB
 bQwaq91Itgb/Q/kP2mTLUz1IwTjwx9cRx/6M6WBewOKAKlQNt8WTrAcP9t8Ew/pVPoDR
 cXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DXIpWl5b+yrM9MNrm6OgioNthJkGr0ZFx09tr4O3T54=;
 b=X6KoWMEb5OiAFIwVajR4ONE9YpDhrm47zQaQ4Zta9piuhg+mAQYwjGQWeSsxHKfrwD
 5ROtq6I34ohAZwF4ZnEaa97C8hnx4+31Qyrqey/ZkowfwVDhZVdijTpn2yt8IcAOUEZE
 Z11LtM+qMBglyfBGdmWtAkdtoa/DcEPiQvC8OVu/yiQu9VtgSdinJ92VeF2tBRJLMn4U
 bsSYRTYRQO0Tck0pw8snl6LP2pOXGpRrptD9kkoyJ6oNs5sVecXj3/8sNZ0BPg4vB1bH
 EVaAb5qBetpKXPVQ+Va/cb0dhAqIFK4M1JevyaEWjaSrsskXWyIoS+LaWqpSj/tkRoE0
 4FZA==
X-Gm-Message-State: AHQUAubLBivTmrOFEhgBB8SAP2DiyonFDY5CM5Hnp0K82dkKFr85tirn
 7oZw57O0Aqtj6MAi7wKSCECclURq7Xft8iP1ovXKeg==
X-Google-Smtp-Source: AHgI3Ia4CY5cKK9Cqnsy8OjTHoBkAI4wEAAXUo53kgXjeZmXiCtyl0HSKvI3qEqLJ612rjUFjIOA31rhbnaae9JZGa4=
X-Received: by 2002:a05:6830:2115:: with SMTP id
 i21mr15220595otc.237.1549654727943; 
 Fri, 08 Feb 2019 11:38:47 -0800 (PST)
MIME-Version: 1.0
References: <20181229143556.27339-1-martin.blumenstingl@googlemail.com>
 <20181229143556.27339-3-martin.blumenstingl@googlemail.com>
 <7hwoncov8k.fsf@baylibre.com>
 <CAFBinCAJhiW0kLgEoPWZRshPAP=UaK2jOBCBeftjz9E+sP2YGA@mail.gmail.com>
 <7hd0o4i9id.fsf@baylibre.com>
In-Reply-To: <7hd0o4i9id.fsf@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 8 Feb 2019 20:38:34 +0100
Message-ID: <CAFBinCAuBbNQrE4cXtBd9j=BaUuty57Tj_CYqG_3mM4URWeDFg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: meson8b: fix the Ethernet data line
 signals in eth_rgmii_pins
To: Kevin Hilman <khilman@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_113849_615610_60045EC6 
X-CRM114-Status: UNSURE (   8.56  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 jianxin.pan@amlogic.com, ingrassia@epigenesys.com, linus.luessing@c0d3.blue
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 7, 2019 at 4:05 AM Kevin Hilman <khilman@baylibre.com> wrote:
[...]
> >> Queued for v5.1 (branch: v5.1/dt)
> > do you know what happened to this patch? I can't find it in v5.1/dt
>
> Hmm, I'm not sure what happened to it, but I (re)added it to v5.1/dt
> just now.
perfect - thank you!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
