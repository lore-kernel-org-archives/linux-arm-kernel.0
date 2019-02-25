Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AADC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:13:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD06213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iaLkP0v1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAtGPX8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD06213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=svYnOWj7ArcK4rkXrw9RhDVxlbIMbT+qANh6GpXdPKM=; b=iaLkP0v14Wm7Eb
	RzTwVpkHfQrBoChRMaC5zq0X5ycVaCnRs3+o2che4AhOHABRHfaaV1JMuOGkvlwChm/Kbsc02PT0k
	we2OIf4YqOFT0f0NB3mqfyxXAiwEf10XyRCgX+gfEud6xldUH9pDZxu7yJ3kV8g/+gL/U2QQwQDrd
	o5LZer2T0IZcX64g4i7PHIFi0mWUl0XkI6Mtsoz1JwpXCreoGe83EgWgWhHegR0ed6zpfc/09s/G5
	xiTzbi+J1uloz26kfn0k9r/OXUJkRhQIHd3wk9aXzQhSDJF9LHctG53q7nJkuyOqcxTTJ6OHwsjlv
	OxXA7AwSf0SAZ3E3AQhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyH05-0005BB-RQ; Mon, 25 Feb 2019 14:12:57 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyH01-0005Ag-Rn
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 14:12:55 +0000
Received: by mail-ed1-x544.google.com with SMTP id p27so7670271edc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 06:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LEM1oXlnncLpowJ1n6g6z7vC7Tb7CbxjEz6a4dpcu0Q=;
 b=tAtGPX8KVAxwtd57C+AD1xhjoKVP3WPm1sStzJSFoMDWUhoOGWVW1cN/WwS4Dtll0m
 FHjW3nX42QnI8w6pyW7Kie5RN01e1guagCOg6LvgoHo3K9DX6ySZRd10ZCwo9E2qXaGG
 721WV+qVL59ZqQswaNeROcuRlyRqZ8JRxMqXnT56F/UyA4F+qlXH14mb9svPKgZHq1XO
 DG0AfaDDUovR5rNAB6bTtziukkf8gGJAb6fuSG6zki8p8+ugzx6wPH0HYafDOrK9dBQq
 H4QaHa7ktv1HrYCP3Act3dKWizLln2F69N3FRWTOdt/xrPFQ+lev/GMa45k4wFDROukI
 wAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LEM1oXlnncLpowJ1n6g6z7vC7Tb7CbxjEz6a4dpcu0Q=;
 b=h8sVDCQ/rxADFhGhpiuLG+GyGzwdgKZFas7NueSka/fvqvKB6casJlba49Ar8Z6ueB
 IfND/4Zx6G91IXOG0sss3DV4+3SaHNvotHovK0phDtm3IfsGI861nmJAByfhmXwUfjv1
 2DDa/S1+eIQSsIeU82CoWS/C2Aa/6r/fL1ZJfrOEpKHMxzQ1Wsg6lSUdpfGiCoW1zqh0
 419PTs92RkZnBBlZ1fCuMCi6CQ47EoLdeV/ghztkDMlHY1Gyvo9qLp8Of1qqfuodGlkf
 /B8p/3gzqRLOZ2fsGbBbss8Y4lV7gIpCSzs8nDjMg+SJG5/VqRpwTnnR0H9LXoccPkrC
 vKpw==
X-Gm-Message-State: AHQUAuaiMO8HqXuGBRQNqyWBqWCo5asVe7nkTj8j28nDrPDyPObkn0eM
 6V99nWHTQhfkhgdhnl+wpQqqqBLxfQbzPnQNyKQ=
X-Google-Smtp-Source: AHgI3IYcWUQ059d+peIp4lqM7RKFu+N8sSg9a34L4T5YAPP3KSWycBmhHUzxwkAkAt+CJpxzyFqQwTWVPgxruKo0ht4=
X-Received: by 2002:a50:b847:: with SMTP id k7mr14589254ede.265.1551103972045; 
 Mon, 25 Feb 2019 06:12:52 -0800 (PST)
MIME-Version: 1.0
References: <20190225132617.10987-1-daniel.baluta@nxp.com>
 <CAGUNXRQdETxnJGP9uQs91mn1w9qJrh4PhZz72bwEh63hrKCX7A@mail.gmail.com>
In-Reply-To: <CAGUNXRQdETxnJGP9uQs91mn1w9qJrh4PhZz72bwEh63hrKCX7A@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 25 Feb 2019 16:12:40 +0200
Message-ID: <CAEnQRZDviDcZPJ2cP8_g6v67=T212G5KZosvEMqMeGGE9NL30g@mail.gmail.com>
Subject: Re: [PATCH 0/5 v2] Enable wm8524 on i.MX8MQ
To: Chris Spencer <spencercw@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_061253_900280_6B2608CB 
X-CRM114-Status: UNSURE (   9.87  )
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
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 Abel Vesa <abel.vesa@nxp.com>, "ccaione@baylibre.com" <ccaione@baylibre.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
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

On Mon, Feb 25, 2019 at 4:02 PM Chris Spencer <spencercw@gmail.com> wrote:
>
> Hi Daniel,
>
> On Mon, 25 Feb 2019 at 13:26, Daniel Baluta <daniel.baluta@nxp.com> wrote:
> >   arm64: dts: imx8mq: Add SDMA nodes
> >   arm64: dts: imx8mq: Add SAI2 node
> >   arm64: dts: imx8qm: Add SAI pinctrl configuration
> >   arm64: dts: imx8qm: Enable SAI2 for wm8524 codec
> >   arm64: dts: imx8qm: Enable wm8524 codec
>
> imx8qm ought to be imx8mq here by the looks of it.

Hi Chris,

You are right :), will fix with v3. Will send v3 tomorrow to allow some
time for more feedback.

Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
