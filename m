Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CB6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:17:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632C6218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XvIE3OR6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jEaRB7ak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632C6218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HOnKK0pWca3MAjGySxoQK5HfdEjDZWalRylP9xydHXs=; b=XvIE3OR6m1oFEt
	yHS3yuxwHLoRGAw8bm44cHiltB/ZwUWww6XtU/qhHS+1+TUIN4VHKK87kw4XmWm1W2WDfebEtOiH2
	E/ttBcBgRBl7keAXoJymSydaQSwNwvVMVhLETPG+aBQqBhyEpW+1jh3LFaVaBkeis8InTgcHN99Ww
	n6dOQic70NAGui1Sox6YgoxGc+MKx8VO62KKlvW4SucdIryBV3Zn+/vvn9cwRjB1qn/gux3GrsGZ7
	aSQrWiNdUT5ly75/cOx9ldbsUsOOuJtvPm3FCU0rjKAXDFaCaDjo9t3jFi7x6duu9BohbbwPEciEa
	BvWE4RdiueJgEg74kwsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaHsP-0005Qj-Bz; Fri, 21 Dec 2018 10:17:53 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaHsL-0005PU-Rn
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 10:17:51 +0000
Received: by mail-lf1-x143.google.com with SMTP id u18so3508190lff.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 02:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=afcFUfas/vk/331jAo4gIvH82Dv7vTpFi3FOQp4ZaiY=;
 b=jEaRB7akudOo2vLclr1yTKKSo5VmVVUYzdpzmWzFu6f2ICbEtDH6EFyTC9HlOnPPWz
 dwbTw04xAo3xS4cOd3RdkVvQn+XgkANwVbIjFiDRLkNaJ6fBe+AWZTwQrH+lU6Wl37au
 3r7lFUUJm6YZB4FVpTbw1sBIaGmBECiAVgpPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=afcFUfas/vk/331jAo4gIvH82Dv7vTpFi3FOQp4ZaiY=;
 b=f2vyiYGctqdOquprfz3WtGpVfC2dv6ChqSDQSu1sBVDfkhIWRKYFBJWCZTLCWFeVSZ
 po6Q1ffkil8VgUtb9pCaAANgc8kA7yEsuYfRMdivko+431t6j7OTSj8nG/+IFSg1MxJA
 IJKaJ+9ufK0DVCRNWFZ3kyYNaasHkOea+j48ZVcVQHMtbnnI1wv8g2q01EKqyjhMWXbi
 Y7u+1EPpZSh95pHx8gPne1/rRIdir9P5/m2NzVDlBn5gz/3kTw+gsbtmc+4rwb/2rV/m
 YLJKuRsalu/caJd7a1BrrC4iAXGAecxzTJJlSQCZgnjHNlKTYB/mJCi55eUqVpinkYkt
 pbBA==
X-Gm-Message-State: AA+aEWafxDlk2bSTApxuGiaxWodGo2IMriVK2dNxCSVqyAeyiaIWogBQ
 5y0uxsDS25/QzTeIVb5HQlGiAFeUeH2ceW0NqP8tww==
X-Google-Smtp-Source: AFSGD/UFAke1qiEd6nqMpvJhR8QRd0yMrmIFciv+sIQIbp2HMFueCNxRyilTdjrot/RIZguc+SIiWttZKyENiZSTHYU=
X-Received: by 2002:a19:5154:: with SMTP id f81mr1108543lfb.96.1545387457776; 
 Fri, 21 Dec 2018 02:17:37 -0800 (PST)
MIME-Version: 1.0
References: <e4eb66dec2901016e01767932461c5d560762f66.1544666839.git.ryder.lee@mediatek.com>
In-Reply-To: <e4eb66dec2901016e01767932461c5d560762f66.1544666839.git.ryder.lee@mediatek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 21 Dec 2018 11:17:25 +0100
Message-ID: <CACRpkdZMgnj2S8xPPFm3PnDGrqTerOwWcS-+Uruy1uLH24HRLg@mail.gmail.com>
Subject: Re: [PATCH v1] pinctrl: mediatek: improve Kconfig dependencies
To: Ryder Lee <ryder.lee@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_021749_916346_1653F13B 
X-CRM114-Status: UNSURE (   8.14  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sean Wang <sean.wang@kernel.org>,
 Weijie Gao <weijie.gao@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 3:28 AM Ryder Lee <ryder.lee@mediatek.com> wrote:

> Remove prompts to make all pinctrl cores to non-visible symbols and
> make sure the target SoCs would be coupled with the corresponding
> cores.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Patch applied with ACK and Tested-by.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
