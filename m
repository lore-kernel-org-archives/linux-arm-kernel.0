Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCEFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:10:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A664C20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dcOQwXp1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tybwUH4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A664C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bEd9wK9gmtCYLIohU8n3Ekvel0bjsfxI8ElUC4fWd/A=; b=dcOQwXp1g+0nsp
	nROXUriD71WQna6IG5mTxvFVtKcqV1yC//Xw8WgleR2vKCDigYTmfoFFfmE445dlY+PXt+NgpaM8m
	6nZ09CNw5+O1iH9xatLElIatxBBAxWM7nxgeaFv3CxdHvL3pnhUK8Dakl71CEmimuiO16iw4qEvJ/
	GJ0foB6+xxFWeeUoVcQr5rJuCFuQ4nUGV4E6gLE/jcoGCwbE4EWSJvuwZy4tfjL2xInBWYO5C/ZHM
	9BRWR6Se6DU+KIiMmSE05uVve1/dqz2mE8wjyjWC8B9XRi8Lz1OeDab8zySg7eIhyyPdDSVXPK97r
	UZcV6wBind4qX8AgA5Xw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYwP0-0006iW-H5; Mon, 17 Dec 2018 17:09:58 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYwOx-0006hK-2P
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 17:09:56 +0000
Received: by mail-wr1-x441.google.com with SMTP id c14so13099922wrr.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 09:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9+IKEsp2xxvU41NOcoNJwmwkjLFreFgjNvF0b84yITM=;
 b=tybwUH4Y1DZJN86Jd6Q3xN4eEjKEf0eWkaqy5X2PUJBPzCdBqA65Jy9CyFoluonJJU
 5Fpse3vqd+2LhxE6PYO/awALkxofurTS8Mi5GP1liMWRJgZamMk4THpymot2ca79Vmnm
 CMMZtc7OtSlItEZl3tVcJrO+g0wQfSrOvLg3rqFnh6EDuykHs/3dNKOGB6Vc/cV2J0/+
 T6ExpGksDi8jdgQ6JowaAvFjTuv0l/A4Guho+IGkOn/FCG5pMAbLU2yCKU+PEnKltDr2
 ifE9Dx267VoW0tGz/2vJ2aqNoGYp0HCpgHTGJp9AxBU6c+A6roRw6ANSEBSnTMuc7Tb3
 QvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9+IKEsp2xxvU41NOcoNJwmwkjLFreFgjNvF0b84yITM=;
 b=p8kSzRpoibvnY90TNdjZwQN2W3/uZNHJdCfL8cMuJD+k/+eLbGOqaKE8GAVXn1peiG
 PSQcnzeVlKSmgZqouDJTGwsfV54+70+RsScgnbcsSfxcOG06rQdQQCtPSsLqcRJ2cgEG
 by8RStOoPUR3vM/B1L3z6vEyPZX0NL5J7+DEfzlBQB/Yo/zV9mdHw+4rtI2Qp2KmAOK+
 +UOo7c7FzOE7we6PuDgErGTF6DenUv3hLLHBlGWKkCUYfz7xFJ1jX7dzFQ7SFtvwVfmy
 7wUZlB4SKciyrAOrdGQNGiBrbeq+I5IviVQ+mujMNFr/21DUJUJVYrox9qJHO5R+zRE3
 Gehw==
X-Gm-Message-State: AA+aEWbpQY4N759ugXgRg0DTBz05EYeK/KW8IPmbEF8pPzxNOIM5nfkv
 0aOfXGBF0Kjb4cAfDP1NgRfGrJIebu2t38es2Zk=
X-Google-Smtp-Source: AFSGD/U5UoHaJP43vVnrmmVmPmv5MouKvnzxvBKvLmZUH3RjvIkHxf+oYvna2/pSYDj/fYgU6k0oc6AYcHXJHqfLss4=
X-Received: by 2002:a05:6000:51:: with SMTP id
 k17mr10808219wrx.259.1545066582306; 
 Mon, 17 Dec 2018 09:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20181217023827.7947-1-andrew.smirnov@gmail.com>
 <20181217023827.7947-4-andrew.smirnov@gmail.com>
 <AM0PR04MB42114239FC75F5514554B55280BC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB42114239FC75F5514554B55280BC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 17 Dec 2018 09:09:31 -0800
Message-ID: <CAHQ1cqGO5bLOXM7sRAOkta3M7gemCDy5MtS3+kzXeLcTamrWWw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] reset: imx7: Add support for i.MX8MQ IP block
 variant
To: Aisheng Dong <aisheng.dong@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_090955_116988_7170B209 
X-CRM114-Status: GOOD (  16.09  )
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
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh@kernel.org>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>,
 "cphealy@gmail.com" <cphealy@gmail.com>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 16, 2018 at 8:30 PM Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Andrey Smirnov [mailto:andrew.smirnov@gmail.com]
> > Sent: Monday, December 17, 2018 10:38 AM
> > To: linux-kernel@vger.kernel.org
> > Cc: Andrey Smirnov <andrew.smirnov@gmail.com>; p.zabel@pengutronix.de;
> > Fabio Estevam <fabio.estevam@nxp.com>; cphealy@gmail.com;
> > l.stach@pengutronix.de; Leonard Crestez <leonard.crestez@nxp.com>; Aisheng
> > Dong <aisheng.dong@nxp.com>; Richard Zhu <hongxing.zhu@nxp.com>; Rob
> > Herring <robh@kernel.org>; devicetree@vger.kernel.org; dl-linux-imx
> > <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org
> > Subject: [PATCH v3 3/3] reset: imx7: Add support for i.MX8MQ IP block variant
> >
> > Add bits and pieces needed to support IP block variant found on i.MX8MQ
> > SoCs.
> >
> > Cc: p.zabel@pengutronix.de
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: cphealy@gmail.com
> > Cc: l.stach@pengutronix.de
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  drivers/reset/Kconfig      |   2 +-
> >  drivers/reset/reset-imx7.c | 106
> > +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 107 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig index
> > c21da9fe51ec..4909aab7401b 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -50,7 +50,7 @@ config RESET_HSDK
> >  config RESET_IMX7
> >       bool "i.MX7 Reset Driver" if COMPILE_TEST
> >       depends on HAS_IOMEM
> > -     default SOC_IMX7D
> > +     default SOC_IMX7D || SOC_IMX8MQ
>
> SOC_IMX8MQ has been removed in Shawn's tree.
> I'd suggest simply using ARCH_MXC.
>

Oh, that's right, will replace with (ARM64 && ARCH_MXC) in v4.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
