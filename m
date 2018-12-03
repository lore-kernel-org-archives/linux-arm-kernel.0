Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDFDC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:42:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0652082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NavzLG/l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWUDT0ux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0652082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jsL2wDh7CJNptx8sDnubrBebPemPpH8wNOxVxGXt6Wc=; b=NavzLG/lHaZOBu
	4YdyJgIQ3CJ6suu4UXbjsepYkuBkfOXWTcRTm5DN4VfG25AshyHR3+CE49Bcwu01CjPVwPptgoKIp
	SLAHcSydY+rTYn/gn/D12NmRCk4vNOuvYLxRA8SYXVOs6I0SGue8hzNuxKj38HzoPj9FaMCRK80iy
	X+W8TG89D0RYVOrPenlmm4jWCqd8pbJpiRST01F3SLfrDfdSHXBmxTGCt9GX97z/WqzH7cxhHJlsO
	TEn0IUV0sz/xFTHMxeAd5G3td+S8tOczTatihu2FBjqaH3YP8SPU8SkloSektEIJw2UL+Pgxvyo4V
	hzku3lk3sYu1yD9zY8Qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gToUC-0004CI-Nm; Mon, 03 Dec 2018 13:42:08 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gToU8-00040X-1r; Mon, 03 Dec 2018 13:42:06 +0000
Received: by mail-it1-x144.google.com with SMTP id g85so9215174ita.3;
 Mon, 03 Dec 2018 05:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L21jGM7u+iENlwfO2G9IKDDo03+MfxFYIzJXo8ANiSE=;
 b=sWUDT0ux9k5N4/qay9/wJg9liP1shOOphDkf262qV95m/TPEKxkB2Ee+u+YOXL2rDY
 z+djXzb4DylF5BsZrDxjVWX/1fQi5cYtlbbm7x2kGS+QadeguklyOH6Qqzgjh5dW0+fs
 4mSydj6zB2sKY6LPuAYkRY5C/q9lbitcvN67kibG6IScRknBCSkhqW7XmZHye9iajxaG
 PV3breW6JEsmb0ixHaedusQ1DQ9uqj76F368Ir+S8OlziUGwF1TGnzoeC//zp570NkYF
 ReoOfflzTexf/ZkMUTSEtZ3yLLzUPQWLdnnDOZFy8OX1Kp22wXuImSnVx+huLdgB2oAl
 9b7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L21jGM7u+iENlwfO2G9IKDDo03+MfxFYIzJXo8ANiSE=;
 b=KfQm9jAdhou/cX3+fRep4ETIYkmvYux+I1/iM/TgxoL/U/hrpDqbGiaPBPKllk4AUK
 dJA3nsdDiQ4wgaRPp+QzRob8F4suqae6ygu6gh9H2jO1m49pw0gAbULmh21laIWUtIyg
 Td16Uoy0RXAaVy5CfotJUtMj/DzyW9fvMSrvAolKk63UoZWrardQKon8YKTxggBK46rQ
 gbD8Jc2DfVEQQmI0zwADGBSRQ6S4gkQ9cjcV63zZDBLKXLekCwoCJyFqbNpZ9ZgYVubH
 LchSVHj/WdoXb9VySdl6p2Sfu0Ir2UrNZ94p6MPZQWPbHGuDBTNlhegyTomNZUlboL5g
 jz/Q==
X-Gm-Message-State: AA+aEWaEit+X5bfR3K69H2A3hvMOfxD9PyzgatTF+0k4m4tlWE4VmWOU
 okj7n3IkEz/fwZv1bWX6XfAPajxajeqLlFI7Pcc=
X-Google-Smtp-Source: AFSGD/WoUtbRHKVPCWKiK9ErtjPyyjiGCyRsKUQ/yV4MMumrvDFIkz34fW77WoVN93Fnge/AnQINOF07+9HkiA+bRxs=
X-Received: by 2002:a02:5184:: with SMTP id s126mr13789663jaa.12.1543844513117; 
 Mon, 03 Dec 2018 05:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20181202093047.11174-1-tiny.windzz@gmail.com>
 <87d0qig4hu.fsf@codeaurora.org>
In-Reply-To: <87d0qig4hu.fsf@codeaurora.org>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Mon, 3 Dec 2018 21:41:30 +0800
Message-ID: <CAEExFWtWCteDgt2vr2TcdreZu3SROKjPmZhucwSggjopEgO3Wg@mail.gmail.com>
Subject: Re: [PATCH] wireless: convert to DEFINE_SHOW_ATTRIBUTE
To: kvalo@codeaurora.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_054204_858653_CE6E8BE8 
X-CRM114-Status: UNSURE (   8.97  )
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
Cc: merez@codeaurora.org, sgruszka@redhat.com, kubakici@wp.pl,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, joe@perches.com, wil6210@qti.qualcomm.com,
 linux-mediatek@lists.infradead.org, Solomon Peachy <pizza@shaftnet.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, lorenzo.bianconi@redhat.com,
 davem@davemloft.net, linux-arm-kernel@lists.infradead.org,
 Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 8:49 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Yangtao Li <tiny.windzz@gmail.com> writes:
>
> > Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/net/wireless/ath/wil6210/debugfs.c    | 240 +++---------------
> >  .../wireless/mediatek/mt76/mt76x0/debugfs.c   |  20 +-
> >  .../wireless/mediatek/mt76/mt76x2/debugfs.c   |  38 +--
> >  .../net/wireless/mediatek/mt7601u/debugfs.c   |  40 +--
> >  drivers/net/wireless/st/cw1200/debug.c        |  32 +--
> >  5 files changed, 64 insertions(+), 306 deletions(-)
>
> This is rather large cleanup so please split these per driver (wil6210,
> mt76 and cw1200).
>
> --
> Kalle Valo
Has been divided into several small files.

Yours,
Yangtao

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
