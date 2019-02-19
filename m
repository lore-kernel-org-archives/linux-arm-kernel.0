Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A139C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:31:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160182147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qzvAxa0r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LswjmVyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160182147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8OfN4BNRnYN33KtI1yKqMjoV5INs4kMV2yupquFylak=; b=qzvAxa0r3KobLU
	C+OSTxHMRmTxPkOcLODRYcZ/nAiC03NqQ/lJLUcQ1oUDXf2tlc9sGP50AH2OBJO2gD65aL/LfxmKA
	c5XVlV6oYsJ9s4sp80TlYUNjsUNQRrpj784ckNKT3/YieedWGoGekYY0Daq9RcJ8vFLjzB98tXIwM
	3GjDDWJdRoL4ld7Ouk5ODz5kQGiWikDzcvdFZjEWeRUolfOYs5sgDdeMKxJGz0eXY/8JcmBWqtnq1
	aEkF+i4f7ZmnaUUd42KBUqGr16GnZER0oQOqSlRdTSBeXMRxK2HyI2GylvBmK3MEpjUFGOP88QYsL
	xFHP7XNUfx7GnxZRfxzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwErd-0005JR-4s; Tue, 19 Feb 2019 23:31:49 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwErU-0005Cg-Vy
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 23:31:46 +0000
Received: by mail-lf1-x144.google.com with SMTP id j1so16137273lfb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DIfJtFbcTx4wLP72OsVIvirz7fZiyTk5Gcu0qV9xxjI=;
 b=LswjmVygELud/ZPIitEuENf/mMAsZ7vP52842g20Jnx0pwOQIWP9NC6bYD3aXSBY+I
 h7szZC6TYQkSc2GrjYX43WyjkPML+0lZfKp2O1YLUGzVYwZeIZoWbI//5lBjxHhjuWK4
 dIk95/qSEZXx7OA4qWWorSzuWgV0VYXbLS7lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DIfJtFbcTx4wLP72OsVIvirz7fZiyTk5Gcu0qV9xxjI=;
 b=mQTPqzk4k/WIFNqouQDT/fbLzNoVFMkoT1KwaDOSprgGKiZGbPg9S719vwv2rJDqo1
 fuCyAFd6BYlYZnLsJJ2RreEpDJIAE0PZ6XQoWqUCwx18TMDce6XVoQ0u0AvrB7/S4f5V
 wtko8TNk8q40iG6z5Cct5rbhgbUwXQQx9tcN8F8ykHip4hHa+edxwe1dsan9UQEvhmbS
 8j0rlMfkq8MIKTQiHrt2GpouLqd8vRw0EgTpxUoIkfo+so7bskrVuH9ntiGOXTA1IPPc
 7NTGEmvDo15YO36vs4Pi2yapjm50cQlMo/vDH2ivTaoyuNl5WKmkI9n6tLKlznbu42Sq
 HL1Q==
X-Gm-Message-State: AHQUAuZuWceibo5lWtEPcbH4jGjMneJgOukf5LGcCNqge3NTX8RcfhUz
 I4/L3zv+WF7FzIotv+chQz63pFFxPH0=
X-Google-Smtp-Source: AHgI3IZcdg/Z0raUDXa0cjqaUFLqfjXUhb1qxr3PmxkpsIDMG/qfpTz6yEqK8Nv5GvtJaS9+ECub+w==
X-Received: by 2002:a19:5e57:: with SMTP id z23mr16217661lfi.25.1550619099150; 
 Tue, 19 Feb 2019 15:31:39 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com.
 [209.85.208.178])
 by smtp.gmail.com with ESMTPSA id i21sm4947640lfj.60.2019.02.19.15.31.37
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 15:31:38 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id j19so18343183ljg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:31:37 -0800 (PST)
X-Received: by 2002:a2e:2c11:: with SMTP id s17mr13935662ljs.147.1550619097330; 
 Tue, 19 Feb 2019 15:31:37 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
 <1550394300-17420-12-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-12-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Tue, 19 Feb 2019 15:31:01 -0800
X-Gmail-Original-Message-ID: <CAE=gft4QKi5kfK9mXs8-OLcYyZzRYOd7DrvUx8CJZH9UJGq6hw@mail.gmail.com>
Message-ID: <CAE=gft4QKi5kfK9mXs8-OLcYyZzRYOd7DrvUx8CJZH9UJGq6hw@mail.gmail.com>
Subject: Re: [PATCH v6 11/22] iommu/mediatek: Move vld_pa_rng into plat_data
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_153141_188987_5E9BCD7C 
X-CRM114-Status: GOOD (  10.53  )
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

On Sun, Feb 17, 2019 at 1:08 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Both mt8173 and mt8183 don't have this vld_pa_rng(valid physical address
> range) register while mt2712 have. Move it into the plat_data.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
