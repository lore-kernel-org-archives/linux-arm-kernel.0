Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFE3C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:28:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AECCE2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BCYHLBVc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X1qxyF/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECCE2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QeQUT3DDyvR6TZv6LT9Yyo4XBsGcH5/C2HLx/x4WrVc=; b=BCYHLBVcuzCKcq
	5ZCZP7lRcYUcOKR5rnUz7RPjH1Z32tKGUfF5pDv4bK7iFbOYOwNa/JjMMcV9+B21MZcZ92YoqQObY
	3YT6qR3Baoe0hETf2J+iKJTxeZt7tWoh8gBB4dLQ5EHYsmWwp9BLam2PQH6oVzNv+sD0FVW7C8EJn
	31xR2Zw75OybSb/J6ZodetpYcx8rTNYQlw+oafyqXNePuzxU2su26vUUTYmOd+HIB/fMfeNPD+vRe
	dYliJFHS+G+Q4fM+yDNYktoi0MFZPhTk2cXpBwIAEGRB3PzaYjRYDbzV0uPhp93rWRM04aJAoMQXy
	mKd4qpa+l4ehGdW/nxgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gouaz-0003iz-CN; Wed, 30 Jan 2019 18:28:21 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gouaw-0003hh-Lk
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:28:20 +0000
Received: by mail-lf1-x141.google.com with SMTP id l10so365153lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GQ0dKTYavvdRK2craM+1+cJoElQMefWKTyFdjDSik8w=;
 b=X1qxyF/EyL/kleGQ7Tjtw1XsuimunA+g7IjHYnNk1jOhzaYVvBUM7mgt7jI/8yksWs
 JVKtOIkOam8fvkOTAcT+EXX3nID0pJa4msDaSJfu6FhX51lOFDNEkRoVKyRdpuRXZn2p
 krfsJtBNAN0w5pzx0qDZrkyfQX17HUpefJ+9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GQ0dKTYavvdRK2craM+1+cJoElQMefWKTyFdjDSik8w=;
 b=IRPEdVveNUM5m6xZHYe9tseQ0sbFAlQg2aaugu9Jk4QVDpx8gD7N5FEvjP+T1UKrEM
 vJtATsrj4Lmf99EHO9jqNBN55faZtG/WXn/KwIeksGAXfSsUUsPaP5tqxAugLytSFc3l
 FUmWFMgJtnxYacqHSkMloiJ6VEmTtIxjH0fvbMHUSB8Ia7I6TKmhCVrdFq0/3ulj7D7t
 GcRf+HHJbFRvwKXQx2EdtBLDudCER182YcvjsAdBWbdk5OxByK4H+u0P0HRJUfu2YQll
 muOHM9C9ep476DY2kcc+QU20P64xXZg8HGt8Wf/WNDjNP4frfn5c6g8LTkhHtLpJVMO7
 0GUg==
X-Gm-Message-State: AJcUukfilsHQah4rg+3pTTw6elwwTt7lx9Dc2QTRQqLI35tCdCTjhO3Y
 fty/kr6p7ZbzhrA+dP6tQf2TntdoN+M=
X-Google-Smtp-Source: ALg8bN6ASHw9rxEWy/VE1zAA+pHYxL3pCzdqEUxHVyiqzLayoYAWz7Pqg339hHUlQzZnFOh39wA6xw==
X-Received: by 2002:a19:c954:: with SMTP id z81mr24915011lff.150.1548872896386; 
 Wed, 30 Jan 2019 10:28:16 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com.
 [209.85.167.47])
 by smtp.gmail.com with ESMTPSA id 18-v6sm393662ljg.83.2019.01.30.10.28.15
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 10:28:15 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id z13so353480lfe.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:28:15 -0800 (PST)
X-Received: by 2002:a19:7018:: with SMTP id h24mr24289646lfc.162.1548872894574; 
 Wed, 30 Jan 2019 10:28:14 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-3-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-3-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 10:27:37 -0800
X-Gmail-Original-Message-ID: <CAE=gft61E614+kXLGr7Z1MZOrPAsTAcM2qU8GGqKq61vfSFvOg@mail.gmail.com>
Message-ID: <CAE=gft61E614+kXLGr7Z1MZOrPAsTAcM2qU8GGqKq61vfSFvOg@mail.gmail.com>
Subject: Re: [PATCH v5 02/20] iommu/mediatek: Use a struct as the platform data
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_102818_741236_23D19C7D 
X-CRM114-Status: GOOD (  10.75  )
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

On Mon, Dec 31, 2018 at 7:56 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Use a struct as the platform special data instead of the enumeration.
> This is a prepare patch for adding mt8183 iommu support.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
