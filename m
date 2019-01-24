Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9C1C282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:04:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E232218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PtfdOCvV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mi1l0ZzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E232218C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L3KAjvHYacZUNYDT45rAV2lAQudn76oMKIffM2ZSaro=; b=PtfdOCvVBxXNHa
	9dZ9YW7Qd0qL3Jq3nhP69M8qU7q9N7IBUYRDRW8caQ6MiKwc6PgEdOwlaxcE0yXA0eO66N6Udl0GP
	GMr2EmcC5HgV2CLlCahVBsQY6Y8cIshAUidwzCu68KqhvLNrjeOcqCH8545J+qgdhQBcEN3KAm6/P
	bhE6YUwiNNZm+guBnmrpS3NJjpMzl2ySyH7X2L+hVUNUTGzU1v8KdoimdCOIgLHvhxkKYW2o/O1PH
	HqWkxSQD0LXlb15yP7pOEozIjB9stWAR89Fl3FVM3gcElNFU0fHLJ1r86QNDfpM6UETEO0VuuBUM4
	kezcvSaMlk1aeEij649w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmhUf-0007kS-Ds; Thu, 24 Jan 2019 16:04:41 +0000
Received: from conssluserg-03.nifty.com ([210.131.2.82])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmhUb-0007jX-GY
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 16:04:39 +0000
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id x0OG4NMP015853
 for <linux-arm-kernel@lists.infradead.org>; Fri, 25 Jan 2019 01:04:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x0OG4NMP015853
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1548345863;
 bh=QN2srEV54z/tZD5aguZyOGVsZO+FGm6s0oyJdmlgyMo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=mi1l0ZzAYWWy14yIKP4ooQot9GP80JjaFiphR0c1QyUUidgCHfVQ3A31ryredGYpA
 bnn0087smk59yytjUxzkpTAeMUfOHOh1LlQDgTG8gGhmjh+i+YcUAyfqpCNHvX52Ae
 YIFgcLaUi+G44fAl9gIKNHSIdmi8txrVc3HGrwqTOAkfozXoOT6vyxQObwJ//KSYGQ
 5EIA6cyUKcg7913mPmerUBkh4Ck7SgoFM8BAWb4yMEy0EcTlYcb6q2e05vNKaeNACh
 QjtTPj3wURb3wIZA52bPRO0tyWXMW8K0AY3ziHrZWACAyCTr9EdX+YCosHxpgr/Rtt
 92NAebUmjR0hA==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id d2so2176310ual.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 08:04:23 -0800 (PST)
X-Gm-Message-State: AJcUukeK7PM2QcS1ef6HAVw4w7otoJZYiDAiNRMmL1bcd/qyo3fuY/Oz
 iZ7bPI1jyAQzggy9Za37lzUeQth8yx37P/1+n3w=
X-Google-Smtp-Source: ALg8bN7I+2sXIYOQk1rjfI4gIKoyp8MM0grkYi1qWtLETRQn4OxTXxsmQ+IGfwZtye1oMyTdEPU8o6C+ySuHSfE4PuU=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr2935203uap.6.1548345862608;
 Thu, 24 Jan 2019 08:04:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1546888138.git.leonard.crestez@nxp.com>
 <VI1PR04MB553355D6D5EBC2604E1AD256EE9F0@VI1PR04MB5533.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB553355D6D5EBC2604E1AD256EE9F0@VI1PR04MB5533.eurprd04.prod.outlook.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 25 Jan 2019 01:03:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ+eNhkfNsjGEdAg+j2ButQ8R6NyZ10SckCGSP5MZ4jtg@mail.gmail.com>
Message-ID: <CAK7LNAQ+eNhkfNsjGEdAg+j2ButQ8R6NyZ10SckCGSP5MZ4jtg@mail.gmail.com>
Subject: Re: [PATCH 0/3] kbuild: Add wilddt function instead of listing dtbs
To: Leonard Crestez <leonard.crestez@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_080437_901247_BF3DE3BE 
X-CRM114-Status: GOOD (  13.79  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Aisheng Dong <aisheng.dong@nxp.com>,
 Michal Marek <michal.lkml@markovi.net>,
 "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Olof Johansson <olof@lixom.net>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 1:17 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On 1/7/2019 9:31 PM, Leonard Crestez wrote:
> > The dts makefiles go through a lot of pointless churn when boards are
> > added. Many SOCs (such as imx) have very simple naming conventions for
> > all boards using a certain chip and board listings can be easily
> > collapsed using wildcards.
> >
> > Add a "wilddt" function and use it for imx6/7/8 and layerscape. This can
> > be applied to many other soc families later.
> >
> > Previously sent as RFC: https://lore.kernel.org/patchwork/patch/1022737/
>
> Any feedback? This should be reviewed by kbuild and arm-soc
>
> I think this is a worthwhile cleanup, are there any corner cases or more
> exotic setup I should try in order to validate this series?



Personally, I prefer explicit listing
because I can browse the Makefile to get a quick idea
of which boards are compiled.

I like this to be consistent.


 - Exploit wildcard for all platforms

    or

- Do not do this at all


But, I am pessimistic about the former
when I look at AT91 platform.


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
