Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A34CC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:16:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DB020989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A1MqjdfQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cJ7GeL5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DB020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nxhp6ar4Ya01QG8pWq+0LStW493o+l3Lli4z7bXQD2w=; b=A1MqjdfQJUVQNb
	UAwBWt56D3oN0bDIIJ2d7y7twHWmLFGTx5FLnp2sVPjkGfkP4l5iedOGL51YBPs6WRKsgowp2D4A0
	g6jQxDsbkrlkzWrnnNcDp4JyRPtkQmp9nEP624lt4tVQ9i/yQeTlNgHX/87OKTMSTle/eHUQFNTRj
	YAr90VCodUIwJdJX6wb3E1OnA7oUbggtFNbqgIPy76QdUoZVhEF6grUlRzr8fkdxE19VQkVj9/wHH
	6yf4dvBESggRxG+DMzhU23no9poV1aPkXvub3buXIj+l82CpBER2A78wdi208HPQ5J4IGF6sE6XLB
	kprcOJs2Bp8VuNMELMuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1govLO-00027Q-85; Wed, 30 Jan 2019 19:16:18 +0000
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1govLL-00026n-BO
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 19:16:16 +0000
Received: by mail-lj1-x22a.google.com with SMTP id t9-v6so565521ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kUoP8ow0u3BjoGMjMpf081Xt5GpQYKWK+yws+VrVB9U=;
 b=cJ7GeL5raixS5kQ0QSjZNPpYMJLD708nwHxeU4aWWr7W1gOpUV1ISKdvs3fdzRK63s
 tQen7oDI8yCkKjpWeo4PSinWqcK1ZBM1Wbj04cDXDBHSIXH9A6Zvp+utqUTUg077tKMd
 p4H0bzNtrnTFIvI7pXY77t22jgWkHlWnH8/54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kUoP8ow0u3BjoGMjMpf081Xt5GpQYKWK+yws+VrVB9U=;
 b=tKgkb+3cU7C1yfzLq0EGmlrThlCcVzPgDyeRbX5X9/9RdIQrrgtOVSoNciieIDgBBK
 O4quVBscbqpegO7J2RBN2+cyg4rA3QfJevPLJxLaALuT5hLfjBQief4wa3qrFl8k7H46
 a4k56Jt/Bp0OhW62Hn/v0PGs9wwCcogLZyeUqPuNJAVzMaCQa9t4Iyxx3X/RPFsQEUH3
 +PBVBYNJ2V1ValnMO18P6VfTit1UTkYElHckRZv3jKQ6OaYsxCPSLH+K2bcXmAxn7LBY
 I/uuNt+ZUatkEx7j26U/6JRjAb+NVNOg/YV+U7OGb0dDAY36bsmCO8h7KlEmYBLjgGoK
 TJ3g==
X-Gm-Message-State: AHQUAua9lX/J3y9+8GKHieQSvzvldQtKgxt1ycdAw6R22tSrQzWalCvk
 1zPK1jeHF1Rs+/TQKqAOqoyT1Fhd9ms=
X-Google-Smtp-Source: AHgI3Iagyj2VALrGTxzVm2+6+tLIE8fr+blOnUTLSk/6RGaQkfSxRyXpIfiuTTHzxnRRhH0IGx8c0g==
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr1698264ljh.59.1548875773150; 
 Wed, 30 Jan 2019 11:16:13 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id b69sm441904lfl.28.2019.01.30.11.16.12
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 11:16:12 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id n18so493373lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:16:12 -0800 (PST)
X-Received: by 2002:a19:7d42:: with SMTP id y63mr25092101lfc.47.1548875771635; 
 Wed, 30 Jan 2019 11:16:11 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-20-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-20-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 11:12:51 -0800
X-Gmail-Original-Message-ID: <CAE=gft4g4HbDG7shtiqUP5vw9tiyRr4VEheMGM2uhEL_65yYmg@mail.gmail.com>
Message-ID: <CAE=gft4g4HbDG7shtiqUP5vw9tiyRr4VEheMGM2uhEL_65yYmg@mail.gmail.com>
Subject: Re: [PATCH v5 19/20] iommu/mediatek: Add shutdown callback
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_111615_419139_ADFD9A83 
X-CRM114-Status: GOOD (  10.55  )
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
> In the reboot burning test, if some Multimedia HW has something wrong,
> It may keep send the invalid request to IOMMU. In order to avoid
> affect the reboot flow, we add the shutdown callback to disable
> M4U HW when shutdown.

Sounds unpleasant. Hopefully the reboot flow still continues properly
even in that case, since this shutdown code may not run during some
rougher resets.

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
