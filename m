Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8420C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:15:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B82D220842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XgXMxeBw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgAi8o1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82D220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8roeUlJO+N+w9zqGWcFiKYejXJrzVi4H5DW4xamm2LU=; b=XgXMxeBwxpNMiS
	ITBHM9BRcTu9Hc+ocFRT0Hg0ltMMU9kHMT0lrCDD7E8pJciZxQTwlUBWuHUPHkS5y8w459b2zWQb6
	zgQwwth75sYz2/hsCh59JxV7jApUwU1Oi0jcnLKsRiR6eOla0jzznRcZcb6RauilAgM2/4FLtm3/u
	PIB5lK8ef9Ghk0xqxd3mj16wHGtwZEEi13oiRsxmRmAcF0hHb2BYMCxnWbN4gGNYVQpsosII4CTJM
	k2fu9UEaloIwf1LKM+6mZe5a+b2P9ag72pVnBazE7mLJjhyJA7lz/cGdkumdArOpX03I7eJZ5rHM+
	uJYbINVN8JXGgJuQ0b2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtWy0-00084d-Mj; Tue, 12 Feb 2019 12:15:12 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtWxw-0007Q9-Hv
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 12:15:10 +0000
Received: by mail-ot1-x341.google.com with SMTP id u16so3974033otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 04:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OEOduNJ0RjW+YUJ0IVEj2dzwwQgGoMtGUNW/usiPNGQ=;
 b=pgAi8o1EwGJTeObiGthLjf6Sim83zww/PVb6khau6gXMnVhoaEaPtC4YME1l4/h80C
 Fl1vgAiKgbG28pgvKUUs3l+CGWG12NYevIKWvZqHPJGVgRyYww3cyFn9FtRVgJP/c3L9
 C7bv67a5yT+eojvigsCO2QcB3J2dfevZVnTS/1AZ7whXFi/1pphz1jzrUVyP/oqEh6Fl
 X/hCJU+y18JVmZi6k3w8QBSp3ya8ugEQ327yONrMX9aFm+q0LyOQmoyvU9t7vSXoxbiV
 didagrsKZlHlcpCc1tuvsg+wyiXnNMwHb9i26vrUdnuJgwhLP+pzQaviMxnWmtklqn97
 dBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OEOduNJ0RjW+YUJ0IVEj2dzwwQgGoMtGUNW/usiPNGQ=;
 b=mX391m+7tp7F++dxbSpCmxYV8vouL2WY8RddNAux+HAjeoGSbAmUXJ1YLego0OEluT
 Zdj9f0uj3r2Kw1Hm5PElJjL1NXvTPoMoaS7kYtTj176wYgrf4aVu9nkVE2uEeC+o1DEJ
 jsSMM3LasnOXqjZpeDTJ5163fDEC8gOd9eOauZ9OVOEiDjOc5QKblBG0GRmw9a9zWMSW
 eCHnFo7nmKPxwv3lmHdtgIz56DuMx+k2qXNWe318P2NeBDDZHG69Js421m9j8EjAtZe0
 fRckWzdKyKCyMjVUF05ydWhBXMtBHanEMIdWpDtJ7wBgF1zsAi23jLCDL3n1GQC7dv7t
 BtgA==
X-Gm-Message-State: AHQUAuYXwLuFrwDY/sR9KdvKbBy7P49j/gTVOas9a7DJQdQk64qVXYB3
 LCSXdSlPsn1nzaO/4nt9uK9hWZ5jl5gRauisQGw=
X-Google-Smtp-Source: AHgI3Ibilhy1y42eFwPUaYlPFd5yTFV4DGoIuhdnF09vbee28qzKRqSvOkz8QxTDmDa7QFOZjy6h/Z5eQB/gtU56dRM=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr3457366otk.203.1549973707260; 
 Tue, 12 Feb 2019 04:15:07 -0800 (PST)
MIME-Version: 1.0
References: <1549973439-26706-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1549973439-26706-1-git-send-email-abel.vesa@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Feb 2019 10:14:55 -0200
Message-ID: <CAOMZO5BgWYKv_sJ=pmknEs+CdOasdK47H32xbwtHub6s0yi=rQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add cpu opp table
To: Abel Vesa <abel.vesa@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_041508_603776_1936F216 
X-CRM114-Status: UNSURE (   9.13  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Anson Huang <anson.huang@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Abel,

On Tue, Feb 12, 2019 at 10:13 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> From: Anson Huang <Anson.Huang@nxp.com>
>
> Add i.MX8MQ cpu OPP table info for cpu-freq driver.

Has the imx8m cpufreq driver already been submitted?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
