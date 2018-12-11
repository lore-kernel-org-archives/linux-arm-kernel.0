Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F111AC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:21:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC7C20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FXDsI0+c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJesZVlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC7C20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G7te5D71B7twvTE45Kya2+Jnf+Txg6JpWfgh0qRq1Mo=; b=FXDsI0+cyT5laZ
	LS8bDofWe3dfDjD+QsV0lPB5EVOncbI1Ol+h0zQEi3m08PMJEYnoanswJlZ+XcuLiFmne5FG0SAOW
	jWa65JAoSFp6ESt6fNJlugOOy5PejMKM3HeXQMORjG4AKe9vzxLWxvHL+vjbeSHjBC9JfOjtekS0q
	+UuRPvFlZtFBEG/uvrW+2UHB9QtMhsDJcyyF3usF9M24trwxNCej9JrYnzZV2QcZYbpBhdgFPn+q6
	QGuY6GB3Fmvbxq8BqoLSHZMd4nxWLSJpSPAOj6YLECUo1A/pPY/h6tN4zlBbD+3tqrVUcjlXqOMPl
	GAw/pMDITlYYHEGBXgVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWjqq-0006o5-Gw; Tue, 11 Dec 2018 15:21:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjqm-0006nW-MR; Tue, 11 Dec 2018 15:21:34 +0000
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E8BB320870;
 Tue, 11 Dec 2018 15:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544541682;
 bh=MN+FVvQINETTAzbt/6M6OzA7pw/8ygRELcMtNjRkSNE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=OJesZVlS4er7UhlJCLUyoV9gIhNSFBtJ71flK1utj007ehBSezBa7tS3LBzE0p4ZL
 3h3hyjIehcxG2XLEFsI1PNoKlO95FVhQ5kg+ZlUmWKaFTYEfRAHsA/pY+FY62liViP
 X+E5YxM362nwmlnl97kE2y8gzgOcsmTCdikQKdW8=
Received: by mail-qt1-f178.google.com with SMTP id y20so16727981qtm.13;
 Tue, 11 Dec 2018 07:21:21 -0800 (PST)
X-Gm-Message-State: AA+aEWb//+/CWV5R+A6BA35u5DsKV+XDGsWCczFMGaMOs2h2AsdqEV5b
 5bHXFChqwkx4UcKeJM8AImIDEUMF7/0H03H95A==
X-Google-Smtp-Source: AFSGD/XFaIYHDTZFTa8PfVID46pmbMMnOQVY1369UWTWxpKlWlUEEIGBsIS7bfvqXeFJzeuGgja/q0HJkT/ANyFJ4gc=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr15996574qtd.257.1544541681127; 
 Tue, 11 Dec 2018 07:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <2386212.ILKoqq0Ivo@phil>
 <CAL_JsqL9PyD=0jy+GF5g8ee-FO_ijvArnzEohuvqK5Od3yr7fg@mail.gmail.com>
 <30286035.tdc4tAKEPf@phil>
In-Reply-To: <30286035.tdc4tAKEPf@phil>
From: Rob Herring <robh@kernel.org>
Date: Tue, 11 Dec 2018 09:21:09 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+0+-yzB8mAodaK75Es6RPn=L5SCkFD7wgC-ZxaJtb3mg@mail.gmail.com>
Message-ID: <CAL_Jsq+0+-yzB8mAodaK75Es6RPn=L5SCkFD7wgC-ZxaJtb3mg@mail.gmail.com>
Subject: Re: [PATCH v2.2 24/34] dt-bindings: arm: Convert Rockchip board/soc
 bindings to json-schema
To: "heiko@sntech.de" <heiko@sntech.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_072132_760960_B8DEE52A 
X-CRM114-Status: GOOD (  11.32  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Grant Likely <grant.likely@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 4:45 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> From: Rob Herring <robh@kernel.org>
>
> Convert Rockchip SoC bindings to DT schema format using json-schema.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> [move to per-board entries and added recently added boards]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Hi Rob,
>
> thanks for the libyaml hint, now dtc does check my dts nicely and
> emits quite a number of little complaints ;-) .
>
> Also that suggestion to move the original firefly release+beta boards
> together was great and I just did that.
>
> Should look ok now, if so I'll apply it tomorrow.

LGTM

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
