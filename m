Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3290EC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:37:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABCA2177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J25N2kJz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FI0Pv/eX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABCA2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IFGnbvjw9PZWKH2HXAkuh0RS5J+sPYpxwftv0GKXYgE=; b=J25N2kJzmw8idp
	lFl+SMGnmfzVd0namDwY+itym4pqfxuun49UnYtxAa4FLzZVBCejiyABXHxAo5ZdmNy8bQBX6U7It
	1FaOHvmj+wKUsLr8r/GIl1JjBPUCqccY8Oq0H4KudeNE5x7m14QRh9uWnt3/GISHoQygKFQPK215j
	Yiglo4LoBFsWyOay9VrsWCRju1J5irLp+gAAfym6pjvCz6E6yGjmD4PjoiH6NqEj6enwHGH2B/cmu
	sFFHxfhZDtleib4EZMWtbtNunCoVsShlSRx81hu+heBTeiaa6k1pErqiQDEArJFjGr1nCogWXe0MY
	7KFxzbVIrIEju/8leWqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtFc-0000xD-Ol; Fri, 11 Jan 2019 09:37:16 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtFZ-0000wZ-7a
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 09:37:14 +0000
Received: by mail-lf1-x144.google.com with SMTP id c16so10334085lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 01:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MOlaGQV0JBDL7qF7LuPfPIwKlwRWVL8OVWL2jG4nkFY=;
 b=FI0Pv/eXlz3E4G4JoRXF9W0nAXnHP4L++1CCQChmTJhkbfeCA420Tssj7cli2AKOsA
 9vsexmXB4qNrtXvAVKe7+L0LnTuAndGvw4miRXz4TVsd49T7sf3mKLA0gLBvxx8qApFB
 hAHFNZGTfETpUvk9imsxl1QirpXvE9tKa/mwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MOlaGQV0JBDL7qF7LuPfPIwKlwRWVL8OVWL2jG4nkFY=;
 b=pfIqjAUDu1YklTrv47Toa5ZsZTwFXbcmO10+2p7DYY3dPU4JPFrqrDsczkzjulMcg1
 dV/2/9zIHCNOc3rtAqXMVBzfmvf42Gy0yosxBgucgW75vqKBzYWdzU0Evf+UATQn3s84
 zAG96Ys65LBKiDAGpn3SaaF4gW4fMsdTyDRi2cGgC1UxsywwE3QnufHixWuqPS0pPm0z
 Nae9KA8AIoN4Y6/CG/8JSbMPQyMY32brC3gXxluxFl4Cwx3+SkfymO7IT5vvo/dxwH27
 xLmt+59Rkh1QJ4jhdUe++lsQ0H8iNAQhrQhC3exj3plqxZeSBwUnEc3xdzsz5Ps5h84b
 H+/Q==
X-Gm-Message-State: AJcUukd+dQY8qPEa41I+iWWU4K0waiLnouw5z2nZLiv9rG24AH/d2+dD
 Zj+bT3YlvltiA1Jnsn5QxyqnZpVAVBFQgdDhWgAULg==
X-Google-Smtp-Source: ALg8bN5aRuZ4QhsI0xgKGM9WL7zatk5XRiC+0/gKThyuFT4+HhxRwmWYTcbKOcaCPVgtoJqZdb5M05JIrLYr4gwmYHg=
X-Received: by 2002:a19:c801:: with SMTP id y1mr7300597lff.53.1547199430999;
 Fri, 11 Jan 2019 01:37:10 -0800 (PST)
MIME-Version: 1.0
References: <1546419614-31207-1-git-send-email-chuanjia.liu@mediatek.com>
In-Reply-To: <1546419614-31207-1-git-send-email-chuanjia.liu@mediatek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 10:36:59 +0100
Message-ID: <CACRpkda_-C2aqGWqAbGJK9RRUF9zn=nqJq71tSP-j6pyjgb2rg@mail.gmail.com>
Subject: Re: [PATCH v4] pinctrl: mediatek: add EINT support to virtual GPIOs
To: chuanjia.liu@mediatek.com, Sean Wang <sean.wang@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_013713_271584_C68697D9 
X-CRM114-Status: UNSURE (   9.51  )
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
Cc: youlin.pei@mediatek.com, Zhiyong Tao <zhiyong.tao@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 hailong.fan@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
 huang eddie <eddie.huang@mediatek.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 2, 2019 at 10:00 AM <chuanjia.liu@mediatek.com> wrote:

> From: "chuanjia.liu" <Chuanjia.Liu@mediatek.com>
>
> Virtual gpio only used inside SOC and not being exported to outside SOC.
> Some modules use virtual gpio as eint and doesn't need SMT.
> So this patch add EINT support to virtual GPIOs.
>
> Signed-off-by: chuanjia.liu <Chuanjia.Liu@mediatek.com>
> ---
> change note:
> v4: modify description and comments

Just waiting for an ACK from Sean before I apply this.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
