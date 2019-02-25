Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7F2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:02:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF76420663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qgW2QsPf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwjFB5lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF76420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nwO5UQ/BmTkEX1T2PAbyIHun1p9eQELWDIYKA09yGPY=; b=qgW2QsPfPYTtqw
	iFNTUHmANXHxqmD28xCQjJ9k+dC0UFDg1qUbKYXlGA626u/dLEebGPcADrafgwgxINlo7/8QBEPR7
	IkV4hvtILhmZLm0b+MMRA11+R/qi6fa1MwnZv28gE+BpDY8WOaIl8RoASes6tAffYux+ZMyFf2snG
	yEDn1Ead48pFTok4nPFbh3pRl+YGYAEJmzWDge4G9p2BU34/Bm0zKPPWaQnaU7Ao5PYLn6HC6E0Zq
	6u8h68PWPEVEtSHcS53WiEU6Uykn79n75cvzBv8Qvv/M63CUokOUonr/s4nJyu0cLsdqb2/06clbn
	qN7K07g3BtfPGvVGw4IQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyGq5-0001Hq-Pz; Mon, 25 Feb 2019 14:02:37 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyGq2-0001HN-4y
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 14:02:35 +0000
Received: by mail-oi1-x241.google.com with SMTP id j135so7285086oib.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 06:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S+IP6+JPekbm8jAsqHfQ3Jf4WF9cDnYSkNQYtrDYJ8o=;
 b=EwjFB5lcJmCLcgEPexRP9rjGc4PxtyBW/atLnZLFuX3k5lbSwHsvzorA90feQ0bCqf
 VG9WIldyQR+b+5GjPdF9xKZ7pfFlNT1lgs1d95VeUMuyjb4PxUXbnImcCbuY1pSIqqK8
 2OGqwes2e/g2pdfyfgXv21Uh4QV66spuIpzyYsIucsZzurJjjIGj1Kd2pUhaLPHg1TEp
 gqJddc1i3haCV5AEVGZEYBWPsrsyLFMZXezhkS8tMWqLfkUX2v3+JV6DWIrpITnQFffD
 QJQWHD0Xt9KLYZW0GWzWEJinA23H/CHR52arNO0hgGfFJ5NJZI7mh8iDP4y2q08AvaAr
 MyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S+IP6+JPekbm8jAsqHfQ3Jf4WF9cDnYSkNQYtrDYJ8o=;
 b=JCXDv/+0DNV2OEa6iyAr9IhZ5zNrCyBYFnmvQwskV0F0Y8dedjGlo4VtLQ4sB5ED7U
 cGGhtWq0nfRsOERGat8ofzQo7HzotYTLjCRHYvVB72KAA1nB+1t0bMxl9nzNfyWjKOzh
 myca7N2QjsD2r348Nmf2cw+zivcMa04kRdHqSeKwV7/wN+LKcuD/WfzIRnDPyk92UA1Y
 UBnlxdfsV4PYZB8VJQRBljcNo+zYj/3r7mdTuYQ5u26YXJwAjc6udSZNULyZ92PCwk2W
 FHP2Q/eWfqBSGl5M0YLGm4lvhrmpdeZtQPkaqLNu9EItVJ/rKIlBDiDnCV3hTFSHH/iK
 PUPg==
X-Gm-Message-State: AHQUAuaT1ZIHPXieRTphl9GyhozMWFYTQmYrAnknnVXkzqh1ZTup34oD
 hetx5uMsDyB19R/GdW7Jgy5uDXNsvLBHOIc7UJs=
X-Google-Smtp-Source: AHgI3IbPkn4fcMh2B0k9NfZBp611Uv0f0xLQiL2WAeZJKaY3fsVDix/v94nbjEkceLYNo8fva+o09wXo0FBj/5aBDxA=
X-Received: by 2002:aca:b886:: with SMTP id i128mr11368051oif.65.1551103352609; 
 Mon, 25 Feb 2019 06:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20190225132617.10987-1-daniel.baluta@nxp.com>
In-Reply-To: <20190225132617.10987-1-daniel.baluta@nxp.com>
From: Chris Spencer <spencercw@gmail.com>
Date: Mon, 25 Feb 2019 14:02:21 +0000
Message-ID: <CAGUNXRQdETxnJGP9uQs91mn1w9qJrh4PhZz72bwEh63hrKCX7A@mail.gmail.com>
Subject: Re: [PATCH 0/5 v2] Enable wm8524 on i.MX8MQ
To: Daniel Baluta <daniel.baluta@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_060234_192999_37B0C51D 
X-CRM114-Status: UNSURE (   7.45  )
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
 "baruch@tkos.co.il" <baruch@tkos.co.il>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 Abel Vesa <abel.vesa@nxp.com>, "ccaione@baylibre.com" <ccaione@baylibre.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "angus@akkea.ca" <angus@akkea.ca>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "agx@sigxcpu.org" <agx@sigxcpu.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Daniel,

On Mon, 25 Feb 2019 at 13:26, Daniel Baluta <daniel.baluta@nxp.com> wrote:
>   arm64: dts: imx8mq: Add SDMA nodes
>   arm64: dts: imx8mq: Add SAI2 node
>   arm64: dts: imx8qm: Add SAI pinctrl configuration
>   arm64: dts: imx8qm: Enable SAI2 for wm8524 codec
>   arm64: dts: imx8qm: Enable wm8524 codec

imx8qm ought to be imx8mq here by the looks of it.

Thanks,
Chris

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
