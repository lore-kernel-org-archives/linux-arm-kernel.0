Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94EFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:10:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DFE20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cGCM8m+1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwqUxcTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DFE20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BsIw5cAtaPKGkR0yXmmZ3kFbyEkzHr0Tm7KkI3tZVrI=; b=cGCM8m+1+hbhai
	XoI361WSdVaZ1zO+wv1XHVfTzX6WX/uNF9hkR5/oMAPXSWWkK8o/KFzIb5vyoYgPhjvAIR7lekOu4
	NL7FK9J/IVWixuZOGzRb4Xf4KtoDfmoNq/iE3JdsGkue0wDJLuKzhPKXfzcy+EfhQxykjUGnj4+91
	qvyLflwLSQASZ/xNlNMpod9CZn/6egKaHIgxzlfONYP6tXLod/JVzdcAoABP3Ljax7Nr9AIDuTD6V
	wt/GlT3ptKCrYUtjxQAX/lcRnZgrzw2t8ZmNYwt2P14b+jWAKL1sctImYxXXPgug8oIGTIbat5ygm
	SeijHNtahGqHV0T2uCNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gycV3-0002g6-I1; Tue, 26 Feb 2019 13:10:21 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gycV0-0002fk-5s
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 13:10:19 +0000
Received: by mail-ot1-x342.google.com with SMTP id n71so10979884ota.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 05:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7EArR8rhNWZekF6rsLjjqi+vFLF5tmLAxYkTWIKoQGM=;
 b=bwqUxcTsQHZ9Mgt20p5DslZ/cNFCPHQDHc/0hYIEgKWRBMV3j5ypDxc1VR1BemvoSu
 ATCS+1Q/FjY4pZr9Sl5ZPaV0UwR7kmjFpePIdEt1/haZAEGl+r0Fw2xVlM8A+uAj9H0H
 pHXsYfvEYjG156GPIDNOL4mh8miW0v5AwU1Uftwe414o+RghAKSJ0acuxIG2XJF38eQv
 iOXveMXPA9Ev3WdNbY3a/4Xoq9ALTrioYqJU36iNAuZegxC92ijy5RUgDh0bvQlWEnuL
 iBxjihRgvr8r+XmujjzgpaWsfj5dWEVQwXGyDnuzvKk/9ICXofjVyOd10R9hL4TpsgaO
 wecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7EArR8rhNWZekF6rsLjjqi+vFLF5tmLAxYkTWIKoQGM=;
 b=U5CVQaPsJogN0t2+xfgGPtis5XaEgPxziq8jckRS8z1NLWCcQKpe+k60RIGhoP6Gjy
 5r7NdHWV2LMjOayse+tpoftBdZ6/DxLziT2VL37h/IZfvMWUBKyEgTNR+G1xl3BrT4lz
 thXFXeR1uRWW7qopvDCYGdhLp/6NLuBJ14iNK3YTagMG6suvlBaW8LCo1WjXaYXMVOFa
 3btTNPebMQYZNYxnxq27Pxr69u/gg0ATV5bh9OX1aZIFA5qZd2hIyuqyEt7wlCkBZYiF
 PxQBcsGUIgAxIsCtn3zR14vdSXb3KwyFElPKmPi5K1TdBTCYdnPXAH5XdlLH2OCiOYm8
 lHkg==
X-Gm-Message-State: AHQUAubM+1a133k3XobaSOYe1mJZfmhr4NtcMiLD6v117jxIUrXvzhgx
 3i96pKwZq3DrbDae31BCJLUnR/gSCqlz5Tdwge8=
X-Google-Smtp-Source: AHgI3IYJZEx+LeSTjQLznF5XKAYJTInOGzkPDk7wzOxULVtJcwUtxEDb/o5WbO+gHlt7XnMoEEYR23ZC4bx7glHho9A=
X-Received: by 2002:a05:6830:1547:: with SMTP id
 l7mr14510496otp.196.1551186617179; 
 Tue, 26 Feb 2019 05:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20190226070742.30551-1-daniel.baluta@nxp.com>
 <CAOMZO5CpefU56xLaOUq0GRwWP9kcMPyZ2PWM38C9FuU-3k1MJA@mail.gmail.com>
 <CAEnQRZBRG4d59y3kteMaZMjfHWZ=FYL4dP+uRcthvXxqtmH7cw@mail.gmail.com>
In-Reply-To: <CAEnQRZBRG4d59y3kteMaZMjfHWZ=FYL4dP+uRcthvXxqtmH7cw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Feb 2019 10:10:07 -0300
Message-ID: <CAOMZO5DTR8aLphJBCqR=oLOz5aZXuNfPVEgUk6K_YOdVD0UK+A@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Enable wm8524 on i.MX8MQ
To: Daniel Baluta <daniel.baluta@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_051018_215784_1FD8D018 
X-CRM114-Status: UNSURE (   9.56  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "baruch@tkos.co.il" <baruch@tkos.co.il>, Abel Vesa <abel.vesa@nxp.com>,
 "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
 "ccaione@baylibre.com" <ccaione@baylibre.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "angus@akkea.ca" <angus@akkea.ca>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Aisheng Dong <aisheng.dong@nxp.com>, "agx@sigxcpu.org" <agx@sigxcpu.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 10:05 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:

> I get your point here. But for the moment it is identical with
> "fsl,imx7d-sdma" so there is no need to add it now!
>
> See the discussion here, and comment from Lucas:
>
> https://lkml.org/lkml/2019/1/28/194

Lucas' suggestion was not change the sdma driver code and I also agree with it.

The SoC dts should still use:

compatible = "fsl, imx8mq-sdma","fsl,imx7d-sdma";

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
