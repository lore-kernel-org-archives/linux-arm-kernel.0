Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF51C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:07:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C55E20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J8vKrf76";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwiAmyOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C55E20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2U8NAKOE+Nx/yW1dIOeQKfzkQGDS247y6IgblYZYW0U=; b=J8vKrf762pbWGF
	Um2efrjTe3MfY3I9eggQ3/gIwtzv769jMlIXoqdtjRqSD1p9cz+zK/owYQZhTbRr5Xbq9ajvoS13J
	OY3cDGLsAXCQlUdfN8zwvDw0cGG2YFsMFrCnV7LxDt7UysQ0o3gskO7ULV5yCLW9mKzK1FnByvlos
	o/qLkIleC5xHZ0JI8jf6jHxePd2v/KFxtAbpnYrW+LPRusr2zwhGaaS/EmYwtCidD/yOKEzSkBjB8
	aIAVXxi8PzIRERmZBGrl8m4X/fpwXsrZI18ns9C0fxrTduxOW0Ume3esRuHTt77e2gggUHAcFbSdC
	zDznoQ5/+6Kyqztu7fnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gycS4-0008T5-BV; Tue, 26 Feb 2019 13:07:16 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gycRx-0008Pn-Tl
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 13:07:12 +0000
Received: by mail-ed1-x541.google.com with SMTP id c55so10683259edb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 05:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BasbKuVfT3BNQiGcELRXYcPC3x2rxGGt3gjri0wpcJ4=;
 b=QwiAmyOJG1oaZ1fWJi3JQmcmzR78PnjFK97gMHLgpK5CzKcK24fWbislxBHFyRNNyb
 CY4md0dr5LVEB+RnHcmAljrf0lINN2mjZPFSHlSesWnoJRcHdruHJGCfwoyDOD8BC3d9
 bOpPLqRd7I9iFDHDjH+ZlxjGAL2Mg811Uw3dzd3rFKEOeVGfU0OVZqjJeXpayNMO6YRA
 0zvnudlquxHlqbnk08a2lWC/KCF/qMyUZUNgL9YT6P3HSejnCxoYuqdRiJFBXxS3pPeR
 9LF2HSo/YegNwVTA4JnT2gbZBQ2MptQyzTCVn/c+Q/5MQ0CgbdEGFgPJOu7t0t4RmEvM
 3KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BasbKuVfT3BNQiGcELRXYcPC3x2rxGGt3gjri0wpcJ4=;
 b=FtJpt4lXVsIklkJhWtW1tzL1r4uhppC/+0+BmDiUhePu6n+yvbvoLyMwb/7FBYFIlJ
 69egUYfbtgEGYH60v54omYoYyDnltjb1Vz42LGgqdS0kN7Z/O3J+QXEoMYAJvq/+7Vz/
 53HLHDF8aGby/JLmrDVfnMhF33o6+DLTPzKp5/PT2hLqDuBVWB2nbqVHgqJ5zyD8R2bQ
 G26vPa1HrdDeFNAQoZ04MwabejDZE4rZSt3IM/xIybBlEXTknw/u/g2Hm74w6LsQlnES
 DlOfMKNxm/5tCa5f+Uv8IS6+yNLuxfSZChnJ9eowyjDUqr2IqhPc27/gNLwRhvo2unKl
 D71g==
X-Gm-Message-State: AHQUAuYaLohiG9Y3Be9rkDVQxUTN1r6jyrDoNNnkhJ19iRQHWiTZDOH7
 ww3Wes0FGmL95NRI8pgXWj6qGHjwQgm5gVqH4VQ=
X-Google-Smtp-Source: AHgI3IbjemB0Dt5wV2cyLR2XoDPL+/HeSYBhReESz4IPDzOXVkJEoIdzqI04zdBt9ayy82EiV4zzDz0pAel1y8tx2t0=
X-Received: by 2002:a50:aa2e:: with SMTP id o43mr6044338edc.67.1551186428529; 
 Tue, 26 Feb 2019 05:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20190226070742.30551-1-daniel.baluta@nxp.com>
 <20190226070742.30551-3-daniel.baluta@nxp.com>
 <CAOMZO5AzUzyr_xixDcntoNt1KNSRih_2ZRFnzQHcg6pZmHsYig@mail.gmail.com>
In-Reply-To: <CAOMZO5AzUzyr_xixDcntoNt1KNSRih_2ZRFnzQHcg6pZmHsYig@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 26 Feb 2019 15:06:56 +0200
Message-ID: <CAEnQRZBhR__V_J8LnwNCkhai_8WrSHtsKHtA07wDkScuqhacKA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] arm64: dts: imx8mq: Add SAI2 node
To: Fabio Estevam <festevam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_050710_679577_98AE6322 
X-CRM114-Status: GOOD (  11.55  )
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

On Tue, Feb 26, 2019 at 2:55 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Tue, Feb 26, 2019 at 4:08 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
> >
> > SAI2 is part of AIPS-3 memory region and it's the DAI through
> > which the wm8524 codec gets its data.
>
> Please do not mention wm8524 in a SoC dtsi file commit message.
>
> It is the imx8mq-evk board that uses this codec and this information
> is not SoC related.

Got it. Thanks for the comment. Will fix in next version.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
