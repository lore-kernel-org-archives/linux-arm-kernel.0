Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88829C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:22:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3A92086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DUzEbg7A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kbeEOxjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3A92086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gA5dxEelFTbcWAEAqoFIJmyh7N5ygOV9h/7b8I4nv2k=; b=DUzEbg7ARyQj5J
	IaHAr7UdgZEDAm18nFt/TuWq4vBPO8DmwyMLYo2T+cjXwCcBmo5snmHQrhXTCVOEAafl5A2htV27A
	rYbmeKM6vFVU851b5KmyvryhgZti0ATLFL7NHJAyxVESt6ZoMVm5ovr1G5iU7e2LLVLAC/EPHY+Ld
	vyHK/TKPk3AoCKjo+bG3yRHzv0h/Ci+XPtyXhcCQXXabd1G0Anas+NwkT0w62RDKbaapuVZPCkjk+
	l3+TlhwVVDWYYK8hAJIK2v6OfPAz2Jjn7UFmaAEzBdFfLsaSWoPjy4Zy5baseh3TYuwY+8XMQnOmw
	Dts4kjjecg1+xW8w2cBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1govQx-0004NA-BR; Wed, 30 Jan 2019 19:22:03 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1govQu-0004Mp-MA
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 19:22:02 +0000
Received: by mail-lj1-x244.google.com with SMTP id l15-v6so548496lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SFTTDZR6YcJzF46vICwfSJ+8tqAs4omNQ9g0nqdfois=;
 b=kbeEOxjxBB3VUw2oPfJYeJuZpaQWy15eSI71DDEAF5210vDE8pnejqJovUL1RvHtMT
 VfM5b1Oy5i1GNGm2T56TFvVKWffxvtEr55ALOkbchwvr5Mcr8lOnaLcntRlhPjZ/FTeY
 dCHUQhk9SK6qAQ76sPxgdz5DhA2eLZMNbEx/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SFTTDZR6YcJzF46vICwfSJ+8tqAs4omNQ9g0nqdfois=;
 b=PVJ+tAXHUFwuXzFO8hydPhFCy1jrmlApvpYp54qX9f8uTl+ILjk2ogf/E/iL9XwpvL
 bhmmkUV2K44Xy41CCzxEA1qbWUC1jh6rE5bAMv233Dk6irAseCDZJT2R+JbL2wmfTK5Q
 SKUhEuh8SKgCV0Ro75NERy1/NxsfuL3d59UYB8YIVIUhNIn7YWQpfq95fi9fZ/Ctu71/
 O3TU+vu2kbwz1wXtyKBNpQIQWvmlE/zx4SMK0fKfX5e5EROtdonRRYRTkcAYuDJXoFfU
 TsJfvUUjFRvqi8cnZQF1boWJ/GEuxyY7hc3BIYe7UoWQWPpC9KgXTNnYXm04fFsnUIFO
 IXcA==
X-Gm-Message-State: AJcUukd6Xtmq7Updczyh/8SuJOb/s2wmkDpi25GihF9RzN/4MKfRhfwQ
 QvhvyhbCcDx40vT9CBieUtUWoK+ctc4=
X-Google-Smtp-Source: ALg8bN4UjK9QWAH71xjqJlnjts/EmfGMJiMba8bJ93dDJ7y48aXFveUrTWf/5y8XeWR9xiNaenexPw==
X-Received: by 2002:a2e:7d15:: with SMTP id
 y21-v6mr24640362ljc.77.1548876118537; 
 Wed, 30 Jan 2019 11:21:58 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com.
 [209.85.167.47])
 by smtp.gmail.com with ESMTPSA id t144sm433965lff.53.2019.01.30.11.21.58
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 11:21:58 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id f5so463930lfc.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:21:58 -0800 (PST)
X-Received: by 2002:a19:8c1b:: with SMTP id o27mr23897594lfd.90.1548875813284; 
 Wed, 30 Jan 2019 11:16:53 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-21-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-21-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 11:13:02 -0800
X-Gmail-Original-Message-ID: <CAE=gft6Dje_VF6vr3=iM9BSKB1N8xe3F5EkEzMgC+fyF69csJQ@mail.gmail.com>
Message-ID: <CAE=gft6Dje_VF6vr3=iM9BSKB1N8xe3F5EkEzMgC+fyF69csJQ@mail.gmail.com>
Subject: Re: [PATCH v5 20/20] iommu/mediatek: Switch to SPDX license identifier
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_112200_747360_41EADE73 
X-CRM114-Status: UNSURE (   9.64  )
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
Cc: youlin.pei@mediatek.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 31, 2018 at 8:00 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Switch to SPDX license identifier for MediaTek iommu/smi and their
> header files.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
