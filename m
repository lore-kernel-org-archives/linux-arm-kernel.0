Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2847FC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:32:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6BE2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nhrIX6Jt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6BE2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=olcTE7k4una+gAwbTJCYrqnC/8331OjdrY5UrZzWhCE=; b=nhrIX6JtpFNLQs
	HqKwWF0iWJHj9q0qsQPzAmXjTcVzK5XDltyE8MMp0++yejZesf302GS6QdMcInc9xv9ASn/gRjrkl
	vn/CLhHz665/2T2yxbup0dxxq64uZuwK510a9uOQCP6Ml8SpExiEpOKNnPjEF2BZefK4CDSbI+cXd
	KvK6+QT0xC/pUF1zdnbtF31Xt2fvVbuxZqL3BK6u0qMXjE7E0J3a9hUA/K6OJONSb8/pG80tVtKF/
	HtW9Bw5y3EnkBDCrnNeFXRDyEK31MjS7R7sX9PvnKt8jt92EeR1+RN+gIU8+Y6GM2MRcn91NChgeL
	iKrcAnQixqKET0GrTNZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlWg-0000gk-J2; Mon, 03 Dec 2018 10:32:30 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlWd-0000gJ-Mq
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:32:29 +0000
Received: by mail-ed1-f67.google.com with SMTP id f9so3794728eds.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:32:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+sE+1U35myL/a0/KB5evo09ZYb4a3/tW7nLxw06aPoE=;
 b=dOx1bVafA4GStV+4uS3jy8MTn0Rx4dTZH3I5qUio0n/CfDZuJtVImLIzHQevaJuEGb
 Bt+UQDI0hy2Qjmt5qEWdSLeojUc6LFt9qwYIhQVhynZuVziRpkEhEj42RXXyj35QpSlI
 43hzBKVIvV+e6ueNIcQbbZuk9PANgZE8OHfltQw3Dv14XD752v4QRN4Msu2mrD5MAPyh
 ntSw6dKz2ZdSdAyt5fZPcagFV5DlnFxikkSFFPR4S1nzlC6UtnHhN5+y1LcmuspOw1mE
 7w9cvFimblMlIbgni/3LpHM7njx3SdlB+pVou2llxiXWISZ0PTa6qGnRcHKI5YTSPV9Q
 sJcw==
X-Gm-Message-State: AA+aEWZidF2nXZ8zPeAaybRZU9Tp7AxmRqEtZf3V0sPMZRgyfIWlc0X/
 ZT/fiMfxAB6pmgO3XCRUYXJVW3Y9h8qYRg==
X-Google-Smtp-Source: AFSGD/Uax4eXuq87uzqa0JcTOnBOT26VskeuTipDiFLKzA0y2KfI8RFw1/+8vQwbLO8iiQI1QnkHQg==
X-Received: by 2002:a17:906:3b11:: with SMTP id
 g17-v6mr12437818ejf.210.1543833136006; 
 Mon, 03 Dec 2018 02:32:16 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com.
 [209.85.128.50])
 by smtp.gmail.com with ESMTPSA id y17-v6sm2119004ejj.43.2018.12.03.02.32.15
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:32:15 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id n190so2717930wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:32:15 -0800 (PST)
X-Received: by 2002:a1c:e58c:: with SMTP id c134mr7509901wmh.124.1543833135222; 
 Mon, 03 Dec 2018 02:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
In-Reply-To: <20181203101547.16835-1-jagan@amarulasolutions.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 3 Dec 2018 18:32:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v67aqRC4-KPMDyE80ZHcvUJvB-tLXzAUL8atvzkcJchd5g@mail.gmail.com>
Message-ID: <CAGb2v67aqRC4-KPMDyE80ZHcvUJvB-tLXzAUL8atvzkcJchd5g@mail.gmail.com>
Subject: Re: [PATCH 1/9] dt-bindings: gpio-axp209: Add AXP803 GPIOs compatible
 (w/ AXP813 fallback)
To: Jagan Teki <jagan@amarulasolutions.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_023227_749493_C6F22039 
X-CRM114-Status: GOOD (  11.70  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi@googlegroups.com,
 Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
 Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 6:16 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> AXP803 PMIC has two GPIO's which is similar to the one in
> AXP813 PMIC.
>
> Add a compatible string for it with AXP813 fallback compatible string, in
> this case the AXP813 driver can be used.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

First of all, please write a cover letter.

Second, the GPIO stuff is covered already by Oskari Lemmela's
"AXP8x3 AC and battery power supply support" series. The device
tree patches from that series were merged last Friday. The driver
patches are pending. That already covers patches 1~3 and half of
patch 4 of your series.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
