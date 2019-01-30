Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BB4C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:36:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5642620869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TqoJ/aoA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i+nPMG1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5642620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p1ReFTXjIGZXR3F2Ex4HoG+RCGMViyPIaJk7KhBbqkU=; b=TqoJ/aoACN7M3/
	fqgqH/ZfiFj+v39xcnQoxJ4J4DJu3Q6WFemH3+/6iDUryNUPeeGEzeVgXg8vRLYF1Pdo326lBgXKq
	ScUCjGTw9DJLW4W6MjS9mFjhi0oAVXGeIpRVCgoFkl7yj16duqTaK3SJyHuESy3zyOoLBO5ZeKnaP
	aOpYGD6xt9kCJXasazuTS9QPCrtXYkAEhOWg2GKBo9k06dgN+bn6BanxWcTNrpba1Fm2xX/3u4vg+
	3PauVV7ermuGP12CxwmTpzYBA9MZrXsdM4sW9DqSoqh0sd2Mh6lu/S/I7IPG6UMdlJX0q/FSu3UBC
	kBf9RUEg/2kG0voGxUvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gouj7-0000MZ-EO; Wed, 30 Jan 2019 18:36:45 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gouj3-0000L9-LA
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:36:43 +0000
Received: by mail-lj1-x244.google.com with SMTP id c19-v6so468178lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/8Po7PAew1Si7r0kpsvoOXR+vsOhQ/wQS/c90BOpM+o=;
 b=i+nPMG1r3BI/2v4XPoi3Qxk/kyH3G1OXuf0sHhgCbPAbYcXLYROQd0o7vHLB8tIMVG
 0wHlqSAI/zcWD35MQr0mMRtLSOoWn49YJoMDi8M/DkYsRnrA3ldMNB66BLD0mS2BTcUs
 +NLvcXdtfk1Kb419xwb8cwo3+bS9vjDC5MH6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/8Po7PAew1Si7r0kpsvoOXR+vsOhQ/wQS/c90BOpM+o=;
 b=l0tAB5uNr89/IDSiGY+L19i5tlQ7Xk7TeCEE6ATHPZcoKUu3oKFESAVok47bYlNlTJ
 01S9vNnc6aEFd7ezmVaJdum1sRhwWXBGtHX2OZkEIFBqsmXiMnfGCt2VzcE+gbtucEzX
 pXFS73EPIAY4s8TcKS0c1MLXOMQoC3xBDVm0MiMV5cISy+o3BkEupcp3SRAlGMYtzJoI
 F13R0AxVeNMUDA/udIJv+AjGyCSMPaVBnnW8kFkZ5EhwPsr4Ajj3KkmUDWo+5s5XO4Ia
 gtJ6kqtDw9JiUoyLyNN7ZaR0T1p+JZ6P59Yd3ZpcMerW9HizOaourblsKdfNJZtIVz5z
 /5Bw==
X-Gm-Message-State: AHQUAubPgE15GyRDtaugPda4TZCgZO0JmzfKLWy94irvKdcIP7OIHO4X
 TIexNWbUcakVIGOqKF/vOyEhxtn3ces=
X-Google-Smtp-Source: AHgI3IaHcCQCzOJxryypHuKV6mF2dUND/yxkR2pMKF27x4NVNrc0kC2f+8XHv5k8yPVbLGVZGfip1w==
X-Received: by 2002:a2e:97d7:: with SMTP id
 m23-v6mr3597175ljj.18.1548873399781; 
 Wed, 30 Jan 2019 10:36:39 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com.
 [209.85.167.44])
 by smtp.gmail.com with ESMTPSA id g70-v6sm400078ljg.92.2019.01.30.10.36.39
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 10:36:39 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id f5so361717lfc.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:36:39 -0800 (PST)
X-Received: by 2002:a19:7352:: with SMTP id o79mr25471998lfc.104.1548872909383; 
 Wed, 30 Jan 2019 10:28:29 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-4-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-4-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 10:27:52 -0800
X-Gmail-Original-Message-ID: <CAE=gft6AouN2DDzgF6d4f52n+mqiOyeeKg1=Og+=YxQsMoBnLw@mail.gmail.com>
Message-ID: <CAE=gft6AouN2DDzgF6d4f52n+mqiOyeeKg1=Og+=YxQsMoBnLw@mail.gmail.com>
Subject: Re: [PATCH v5 03/20] memory: mtk-smi: Use a general config_port
 interface
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_103641_918882_0D06B262 
X-CRM114-Status: GOOD (  14.41  )
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

On Mon, Dec 31, 2018 at 7:57 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The config_port of mt2712 and mt8183 are the same. Use a general
> config_port interface instead.
>
> In addition, in mt2712, larb8 and larb9 are the bdpsys larbs which
> are not the normal larb, their register space are different from the
> normal one. thus, we can not call the general config_port. In mt8183,
> IPU0/1 and CCU connect with smi-common directly, they also are not
> the normal larb. Hence, we add a "larb_direct_to_common_mask" for these
> larbs which connect to smi-commmon directly.
>
> This is also a preparing patch for adding mt8183 SMI support.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
