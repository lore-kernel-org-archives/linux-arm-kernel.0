Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06DBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:02:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6DA217F4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FCznm0ai";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kc1+7CSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6DA217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EhR5bET/DMqCAyfZaCBuds9ZiDQN5pvdAqDIo+bVTvM=; b=FCznm0ai6UWiWI
	RNukSRfM1iZ1X20ZTTEjVD7sIrMM/iUx+RFTjIjArCrkdghWzaNfFEuGccYM2NBYI70afTXfmfTQE
	kGK5MWOVRSrHkeiAMWwg+6urOztujOqt20Yb3uvblaLJi48207nGzNtg4U942O99GRCTdGQEVBIUM
	qq+WSXZE0Yo6TIk0WRFRD7xiNONTxXKIQVYh/iQUs1DYb+mGkYMf+6t/8Bv0NAMZpEkw0fXEdmOdU
	HA3IDmJlHBgGTP2JZIB08VesO4UNzD1YFfQpTI7PYEQikTTCw7BlhVvoNCLuPGUXJFxrZ0SfYk/nW
	iqfHldspO7h/zSl/KxCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyQCk-0004Kw-K4; Tue, 26 Feb 2019 00:02:38 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyQCc-0004Ab-26
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 00:02:34 +0000
Received: by mail-lj1-x242.google.com with SMTP id z7so8921408lji.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 16:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t4gY5KZY3j+v6lNL3mYxj3q2uSyGFjZbYwW3PkYe4vQ=;
 b=kc1+7CSQghDMEHxybMZNL+zxWbTGNFaeWcmZu7HPhDTWtIO7lYG9IdvAxq6ZoTXRzC
 vDnzAv0T/CofbIgC+9dAxgfyQWxZ1qqYK22vbAfZ7nUlrQW3DZDcxfN5kp44Hmn6Bcfu
 4+XoUuNtGRs/6Mi7l0mTBYa1fDagwO21XumVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t4gY5KZY3j+v6lNL3mYxj3q2uSyGFjZbYwW3PkYe4vQ=;
 b=AojCtY9z6tfiwGeF19v9Rr5q3UOl+Utp9SIartKy+Dj2b5SSAzrtf+aFTj1bPgNeaQ
 xokV8YqwhNo4mtXmTJf7xX2DWA+4Z4Iqg6IExJC0hxozw06RbSNCGO3g1bJjAyb/z9Jo
 M+0yvs81Cbx/xRemf3Ex0h4t6FgA1AlsLhTEuuJEld6rIbEa2nlsOnn1yT4qDGMKS6by
 8n4HL0nA/shSLCa02FxO+b2xWzF/2FtvtNf2aRx5/yxvyDBHSp3D4UVMJqSSa/pi+mDg
 ngo2o5gFkv+YIoDtMZ1CoI0Dmy/VanPx0hgkA/sewULmr77Y555q2MqfthC81W8fc3e1
 W01g==
X-Gm-Message-State: AHQUAuY8j+pmci6aZrL7z3OWXMC3V1JC+DcnJ9MA9XyUqhaZPm7OwDI7
 SyXWyu5O8ceOVtT456GFRXF1Cev37VM=
X-Google-Smtp-Source: AHgI3IY1Ml0zqyFc6nBh7HE1Va0WIQWllnaMFcBnq1/QN5JI663litkWQvizjl96PtadeFnbr6Gltw==
X-Received: by 2002:a2e:9a95:: with SMTP id p21mr10682165lji.127.1551139348325; 
 Mon, 25 Feb 2019 16:02:28 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com.
 [209.85.208.174])
 by smtp.gmail.com with ESMTPSA id j12sm2843461lfg.47.2019.02.25.16.02.28
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 16:02:28 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id t13so4743692lji.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 16:02:28 -0800 (PST)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr11645266ljj.30.1551138861092; 
 Mon, 25 Feb 2019 15:54:21 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-3-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-3-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 25 Feb 2019 15:53:44 -0800
X-Gmail-Original-Message-ID: <CAE=gft7mWs1jc+KQQcPuuhcmxpFRnRBTt35+uC3F20N6R554bQ@mail.gmail.com>
Message-ID: <CAE=gft7mWs1jc+KQQcPuuhcmxpFRnRBTt35+uC3F20N6R554bQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] driver core: Remove the link if there is no driver
 with AUTO flag
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_160230_665871_0FFE6C58 
X-CRM114-Status: GOOD (  18.75  )
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> DL_FLAG_AUTOREMOVE_CONSUMER/SUPPLIER means "Remove the link
> automatically on consumer/supplier driver unbind", that means we should
> remove whole the device_link when there is no this driver no matter what
> the ref_count of the link is.
>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> The ref_count of our device_link normally is over 1. When the consumer
> device driver is removed, whole the device_link should be removed.
> Thus, I add this patch.
> ---

I will admit to reading about device links for the first time while
reviewing this patch, but I don't really get this. Why use a kref at
all if we're just going to ignore its value? For instance, I see that
if you call device_link_add() with the same supplier and consumer, it
uses the kref to return the same link. That machinery is broken with
your change. Although I don't see any uses of it, you might also
expect a supplier or consumer could do a kref_get() on the link it got
back from device_link_add(), and have a reasonable expectation that
the link wouldn't be freed out from under it. This would also be
broken.

Can you explain why your device_links normally have a reference count
>1, and why those additional references can't be cleaned up in an
orderly fashion?

(To be honest, I don't really understand the case for the AUTOREMOVE
flags at all. Is there some case where the party that set up the link
can't tear it down? Or is this a way to devm_ify the link, where devm
itself doesn't work because the links themselves stall out that
mechanism?)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
