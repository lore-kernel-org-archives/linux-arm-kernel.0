Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118C4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:39:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D59622147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eTS4avjo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VJGEVgQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59622147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=weM3OzMsxErTknzxJQgst3h9UB0n3YSUmQf3AleQokk=; b=eTS4avjoHo0LQt
	2/RVYBRZGoWe4miGTuJJ0fWsCXXbOjgzeImGi+Y88o1vfy5bF7Cxnq3MPSAlTROD91YR970mUEOcB
	s7ffe4k41yvi4xJndJFfqI7Cbs/2UrA75/1lIDDIjRfsrjrCMKIy+k91jd2l//1rWF+hclqfZybng
	V8WTqbpCuB2OcHcW/ttGXqdTGRJVTncXKbKvSnBbjvvSOuVEZSxAfhdRQIdz7f02BUj6XtTycYxcE
	+LIImjjC+WNnaXfU+WxnsaqKPiJUw/3IdebT7ZvuW7Cz4yUXLCYs048nxDH4PWCieFnJQekiUv6ju
	giU107FgYhstQ0C6dN1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwEzF-0007z4-QX; Tue, 19 Feb 2019 23:39:41 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwEz5-0007nH-2f
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 23:39:34 +0000
Received: by mail-lj1-x243.google.com with SMTP id d14so7974590ljl.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AJ7ED9jH39fuBc3f73jvNFeV5iY3KwuUSdsrf8MwwXk=;
 b=VJGEVgQj7V5QTQsVkhPvLHTwnozl56CbHYs2KKTw77qb03WH+izpub1pucQZI/pnMS
 Ln5Loflermovk58DJCIBryy/cBbXj9q+PHI6cg/ecAqS/DE2ZsaFY1+dYJcxEorcd7Gb
 aYVDR/p3ypPSxlv+pxCAIdFA9kcT4vxtrvuAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AJ7ED9jH39fuBc3f73jvNFeV5iY3KwuUSdsrf8MwwXk=;
 b=WqWcQoYu+MoQTetm0JBGL92WO0tLV/11BGtpEbiUqLQ/Gt3O/2hNa/AShHdG7glpFq
 CZdc1Rb4vIMoBJSbZ51yDpHc3nNMD+JymXRARKHT/mWmzYomwm/ycpC3oQf2fX7s8/hF
 mBOCgE7HCQE5iYDLwEcZWWMzMuXTecf1+2Jh8cAd4kmLf/pQ/UgZH4VAPSD3dGB3vpmQ
 1p4o2avwRE4j9vdgu0mQT0DbDx1Py+meq0IlwpmPc1OULg8vH87c8a/3sCy+MWvasvMe
 LkaOWdAiROteZfsxJEPZQdRPIK7H54WlW/jZVr2cMI7eaYHOs9xc5PHv51oRC5lEsFeZ
 lGkQ==
X-Gm-Message-State: AHQUAuZrIbns8zq3WgB0t2avQm7tb1WHFYr4pSUmZEmLt+gXlDCxGU7y
 G26FGTyzHxkaFTVxcW3S53NhpNBN03s=
X-Google-Smtp-Source: AHgI3IY9gsaxGSOCfj5vnplyZlrrjDQR0LuGtss7Q1ivMpE2jWmC5+qHRrKoOdUY3xw2je6vfYPCLg==
X-Received: by 2002:a2e:81a:: with SMTP id 26-v6mr18771473lji.14.1550619569352; 
 Tue, 19 Feb 2019 15:39:29 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com.
 [209.85.208.174])
 by smtp.gmail.com with ESMTPSA id l20sm2751570ljb.24.2019.02.19.15.39.29
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 15:39:29 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id s5-v6so19082679ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:39:29 -0800 (PST)
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr19630490ljc.97.1550619131688; 
 Tue, 19 Feb 2019 15:32:11 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
 <1550394300-17420-17-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-17-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Tue, 19 Feb 2019 15:31:35 -0800
X-Gmail-Original-Message-ID: <CAE=gft4A=MEYUwwgj4RCT=8Vz_qxbmPo8uG3Mf-HJwC0Zn0-9g@mail.gmail.com>
Message-ID: <CAE=gft4A=MEYUwwgj4RCT=8Vz_qxbmPo8uG3Mf-HJwC0Zn0-9g@mail.gmail.com>
Subject: Re: [PATCH v6 16/22] memory: mtk-smi: Add bus_sel for mt8183
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_153931_361756_5842E618 
X-CRM114-Status: GOOD (  13.11  )
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
Cc: youlin.pei@mediatek.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 17, 2019 at 1:09 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> There are 2 mmu cells in a M4U HW. we could adjust some larbs entering
> mmu0 or mmu1 to balance the bandwidth via the smi-common register
> SMI_BUS_SEL(0x220)(Each larb occupy 2 bits).
>
> In mt8183, For better performance, we switch larb1/2/5/7 to enter
> mmu1 while the others still keep enter mmu0.
>
> In mt8173 and mt2712, we don't get the performance issue,
> Keep its default value(0x0), that means all the larbs enter mmu0.
>
> Note: smi gen1(mt2701/mt7623) don't have this bus_sel.
>
> And, the base of smi-common is completely different with smi_ao_base
> of gen1, thus I add new variable for that.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
