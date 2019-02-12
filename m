Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F72C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:35:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C16D2184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uaJCpKVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C16D2184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hD7/+KQ1iRI2BdbpALX2gebnLa0m2ivtOY6Sz2dMd/Y=; b=uaJCpKVQ1bK5Zu
	gMdeTliI5gIe3z9+E0AYhww2SbteiU/gWxKTx0te61ZM2jOItj7syxnV2NHtpuu4BXPH+FKiYXrs8
	RnfMbclETbRKeqxjqiMMjhGmL2SVnzcYEHbglNHVp//OHbFqsxYoEXVYSgJrzzLNOZy2ZXo9pRnFD
	YnQ/uJcw5BQAbFs4F7gcy3+EtZnL2kImAFExLwP1vssBtt0SXcDQkBc6Ki4HUF57pEnh59ztOnckC
	doP/UJ8mDapLXlkRnlsUy6qFszm2Ad72M+yzxO7D67TAX2Qu7PQsSNDa3WfNzBrYt6YQU/URe0zy1
	0IARZsv5TUvktTgPFrtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtTWu-0004Ya-Gc; Tue, 12 Feb 2019 08:35:00 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtTWs-0004Y9-4B
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 08:34:59 +0000
Received: by mail-ed1-f67.google.com with SMTP id 10so1430574eds.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 00:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GchSLQL+MK3+aDAYq+CRIhaNVIm9FvskzFFpE48PnmM=;
 b=Jt3PM46o8Fi7GGdsE6lifjc9+LqOy7Ollqjdoza/ZcTZzB0kDn9G+m2+07KBKA32Vk
 MG9kX+xSjWMLNPiLCAhuhOwSCt/4gaKAz4gFen/En3AA7tzuG6HVhf75gxAXwsyV8ZRB
 1gkZ4awrcl9yaXiYfJfDPqr0ldkTLpquNHVYjJ6hWKRLoI+2dQ6eRbKQLDVipTNzcaQ+
 l20KXD8I/gWiEMECR7ggotkSpmb9TEhNe7MLuazm7cgRq3yi6FcCoxPvCle1fhE/F3yK
 /CtI7PUhlQTNZxdorR/3ldTTiksmnCoOlMtzeLP1DcS2D/YyG6Fm0ZWVaIP0DKWOgrV6
 X9Dg==
X-Gm-Message-State: AHQUAuYBOcpG3baSFPmy7y7jpjhphfRVQlnFOrV8RTGm1q8CEYbDhtfD
 VEpDHMlDNBolZt3aTN/P62t1zYjP6BU=
X-Google-Smtp-Source: AHgI3IYMbYy8jPeAH8mnhKy8pJnbjQrqyzI0FRKPH5qoXeG4T/bgQHiPvjLexdTwjkkNoe/cqEiDfA==
X-Received: by 2002:a50:ee0d:: with SMTP id g13mr2158414eds.230.1549960495733; 
 Tue, 12 Feb 2019 00:34:55 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com.
 [209.85.221.47])
 by smtp.gmail.com with ESMTPSA id h9sm3735836ede.93.2019.02.12.00.34.54
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 00:34:54 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id v13so1665116wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 00:34:54 -0800 (PST)
X-Received: by 2002:adf:efc2:: with SMTP id i2mr1896955wrp.44.1549960494217;
 Tue, 12 Feb 2019 00:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20190201113743.10058-1-harald@ccbib.org>
In-Reply-To: <20190201113743.10058-1-harald@ccbib.org>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 12 Feb 2019 16:34:46 +0800
X-Gmail-Original-Message-ID: <CAGb2v66MHGrpFuA8eBKhVLXPcriwGb-o4_3jfyLJ4HwEBVD3GA@mail.gmail.com>
Message-ID: <CAGb2v66MHGrpFuA8eBKhVLXPcriwGb-o4_3jfyLJ4HwEBVD3GA@mail.gmail.com>
Subject: Re: [PATCH RFC] arm64: dts: allwinner: a64: teres-i: Enable audio
To: Harald Geyer <harald@ccbib.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_003458_161251_54045024 
X-CRM114-Status: GOOD (  14.44  )
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
 devicetree <devicetree@vger.kernel.org>, info@olimex.com,
 Maxime Ripard <maxime.ripard@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 ibu@radempa.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 1, 2019 at 7:37 PM Harald Geyer <harald@ccbib.org> wrote:
>
> The TERES-I has internal speakers (left, right), internal microphone
> and a headset combo jack (headphones + mic).
>
> The headphone lines are multiplexed with the debug console.
> The headphone and mic detect lines of the A64 are connected properly,
> but AFAIK currently unsupported by the driver.
>
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
> Hi all,
>
> a couple of issues make this patch RFC:
>
> hpvcc-supply vs. cpvdd-supply:
> On the A64 manual the pin is called CPVDD and the binding documents
> requires a cpvdd-supply property. However in the actual driver and
> devicetrees so far hpvcc-supply is used. This is a very new binding,
> so we have the luxury to decide either way, I think. Any input from
> the devicetree maintainers would be appreciated.

Sorry about the screw-up. I'll send out patches fixing this once I
test them. The preferred name is CPVDD, as that is what the datasheet
uses.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
