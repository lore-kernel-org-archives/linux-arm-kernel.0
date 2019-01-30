Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61B0C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:55:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF3D218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="au6Mw/nu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ps15UBi2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF3D218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AC767cvV0R4MnGP66IwX6QgDiHIi/kzoQstm20a3wCQ=; b=au6Mw/nua1oW6w
	cvmX/8NuwT6XAEVhrtg2j6qLkmJU+6icWXxe3iHVxTST9u+r8HnHSeAYpM467xMJCILwWlotQzJTB
	pK+WD5AyTAyip29ZfHvw27Rfw0PVdKxsAwVTNhRFNoQ6/nFTudKHx0oUjycYd73Xu0Sf4RmW9gZNi
	glEh+vJGjfuer8A1L6aV2nrUl2gBjNHN46CcohuvAU/vW0YL2KURfe3gbrki5uFoyiZrLzLfPhE+g
	iLjdTBuPQgQBo3G9TTEuPgJuVKgIM32IF3R7P0ixD5VgoBcmy+SKDuLwCTClXM0TIztVmmdPobe0g
	t7I+usLnseFJ8IUkcONA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gov1f-0001md-Py; Wed, 30 Jan 2019 18:55:55 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gov1c-0001m7-Ji
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:55:53 +0000
Received: by mail-lf1-x141.google.com with SMTP id i26so477864lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iICV6iO5GGqy/9UyvLBZFlPh+9/PoKYpYWrjSxw2AAU=;
 b=Ps15UBi2+dGsGjwapfletBv+573yHf6DC+OJb8tE5CbQxaNE2HEFKvYtYKiZ49sauE
 qr3hdJPCfSK5vXOAYerx0ce6yfBZhbx5ydpwO5+nMk/tvHiBkQQHcvnbd4bHPcbwL28y
 V//kUweAepKdxRr1pyB9Zwnju1ExglqAg1+QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iICV6iO5GGqy/9UyvLBZFlPh+9/PoKYpYWrjSxw2AAU=;
 b=uSgKrUWwvXCJnUgj/Zex851IVerm3Wzm2qHg1fIFoauHn3D0xndRqkS79mWQgKjyxS
 Wwpq6s1w2j/n5nVcrmLJn5UoYtdOsr0mM9XcKwXOHC12VXVO0Tj46r2q7nv+OLkefBsV
 okwTQpxMQkZYYO6qHb4h6voVp8t8okF1NzOX0Byalu4oySStusnBfTBFcfzG2Wn+xWAi
 wktnvveDfGeNQWEii2tolRxCgfvrkP096gUEmgkTJgHkG9BaDAZpl9z3ydfaro7CMppI
 YivYWbolH43xT0ES0LJyuObpCpxZxrtijGW/LdcRmvqqdQ5IHk4ARFFlrAWS6erK7rbk
 H+4Q==
X-Gm-Message-State: AJcUukf/0eb+kx4a/LuFve5dfi2oxcDzO8/oW8M7BsTATm86cfULnwBH
 +6egbQ9GgxXlGUKR3pkoF60JJ17c+74=
X-Google-Smtp-Source: ALg8bN5y5RlogJtTg64s2s9gwFYcjBDsGoatRtFr1uZosaHRsNfKPmnxC47cj2K27Sm8SZ4o8NvpaQ==
X-Received: by 2002:a19:9b50:: with SMTP id d77mr24052220lfe.137.1548874550514; 
 Wed, 30 Jan 2019 10:55:50 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com.
 [209.85.208.174])
 by smtp.gmail.com with ESMTPSA id 85-v6sm416198lja.16.2019.01.30.10.55.50
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 10:55:50 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id v1-v6so552765ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:55:50 -0800 (PST)
X-Received: by 2002:a2e:9181:: with SMTP id
 f1-v6mr18171528ljg.64.1548873092541; 
 Wed, 30 Jan 2019 10:31:32 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-13-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-13-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 10:30:55 -0800
X-Gmail-Original-Message-ID: <CAE=gft5BS=yDQV48V1a=n8U1YyAQuQ+vxg1bFy1HFJXmvXE_gw@mail.gmail.com>
Message-ID: <CAE=gft5BS=yDQV48V1a=n8U1YyAQuQ+vxg1bFy1HFJXmvXE_gw@mail.gmail.com>
Subject: Re: [PATCH v5 12/20] memory: mtk-smi: Add gals support
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_105552_647950_7FDDDE14 
X-CRM114-Status: GOOD (  16.42  )
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

On Mon, Dec 31, 2018 at 7:58 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> In some SoCs like mt8183, SMI add GALS(Global Async Local Sync) module
> which can help synchronize for the modules in different clock frequency.
> It can be seen as a "asynchronous fifo". This is a example diagram:
>
>             M4U
>              |
>          ----------
>          |        |
>      gals0-rx   gals1-rx
>          |        |
>          |        |
>      gals0-tx   gals1-tx
>          |        |
>         ------------
>          SMI Common
>         ------------
>              |
>   +-----+--------+-----+- ...
>   |     |        |     |
>   |  gals-rx  gals-rx  |
>   |     |        |     |
>   |     |        |     |
>   |  gals-tx  gals-tx  |
>   |     |        |     |
> larb1 larb2   larb3  larb4
>
> GALS only help transfer the command/data while it doesn't have the
> configuring register, thus it has the special "smi" clock and doesn't
> have the "apb" clock. From the diagram above, we add "gals0" and
> "gals1" clocks for smi-common and add a "gals" clock for smi-larb.
>
> This patch adds gals clock supporting in the SMI. Note that some larbs
> may still don't have the "gals" clock like larb1 and larb4 above.
>
> This is also a preparing patch for mt8183 which has GALS.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

So really from a software perspective the gals are just a couple of
extra clocks that need to be turned on for certain larbs. Seems fine
to me.

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
