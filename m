Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ACBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:19:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD3C20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jTIU8tre";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BejqA3X+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD3C20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/jY46B7AQfzpW+Z+JXmYL434EWYzr0SxJQjOT7aGs2Y=; b=jTIU8treryJ+FP
	DmAJzZqeeEiUrOi+k4c6YsL8SGzZp/E6ErMo1zsKtABo6lcQPRv6teZ9RviUWIQI1HAyujLJvAnL/
	oEQcpIda7p0oxOxPSfYy1PTgKhrKkp6JGi3hN8nMmVK368THvM3chhh+caHFkAxqTIX88YqdXqxml
	LJ7KokekWE4f7mrUJOl92lOnViSI0fE047ZbqZiUlZ9A6C2/QL9rHsgxWI3dN4uH9bvzpA7TOA6qu
	3QFDQE8mjH7lcdLcnyBwcWLHci2N5dhEb8qUzSkhxmAyTWdrt5qtLR35uOrCqBRrdsXdbT18EB75C
	JBIxUp+1xdNfAaDdKqNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU7nW-0002mt-5w; Tue, 04 Dec 2018 10:19:22 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU7nT-0002lH-Qt
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 10:19:21 +0000
Received: by mail-oi1-x244.google.com with SMTP id a77so13758573oii.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 02:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ks087rJNMucCjyXK8QciBOZcbUjlEFozJ15GONL0jy8=;
 b=BejqA3X+DeYoLNY43pL5hyyqxITYMA61jrl9RTCyBqAqFM5mSCNnXxCTTZsBzTsUQm
 1qZ0g9wH5tbyIaD858A069xM9QVQwmN7YxX7aE90ZGFuVcHX21e/ABx2DQJD9cJpHWat
 UAcrKyNBA0C8a6/Ith6h6LLRk0iFHJfZwiOdxzdPwI9Cx55q/KdFNMa9i3VprbOfMv8h
 s5loroSBQAyhmt95GTmS7zuTYcbPqUE79L91fNTRNiY4OyxzAhUoosoTH09oZp6Tbo7J
 JqPce7GihOPgcAFnihiI6wkgPjUqu67Mau2FjQcmumAyUL9QuxWT38jD2EMfuvxgWvQE
 4TfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ks087rJNMucCjyXK8QciBOZcbUjlEFozJ15GONL0jy8=;
 b=lwNEbmZv7H4FKRLFdwwRdkiChNQJqRKxCN6DBFIUC+2PI0bhBUxnIBgCtJ+pRL4VHZ
 Da2Tyv6ToVAyC6TvkgQYbmW8Rk9gx4Arn0own4Zmm19t6lel4j/C465I/7pnUqmihnvX
 Szgc9z/b3c57+0CoOxFrtUCwwgBOgFoMCefob9qXw3hrCzICpSKJj/rPeL8hfsRK238h
 adNeVtpCPgubTxxeBQtLuLBl+yghXbVkSJTyDrJVn6/zv4A4VaJqX4Bax2fqX4Brm3hx
 l+Scx0HFIINhXdNaVmyGmplJdTqLSiDesWitZ9tqR2sPlmFC/GCISvlJkNdpTkUHTSJ9
 k9jA==
X-Gm-Message-State: AA+aEWbdO9l0LwFX11YY5iGVe8SgjanGz2CXgb0BHuDtXIbwWIiSjcbk
 r2+LzaYIa62zS3RjmTWK7pEuANG1KezOiXV4Sv0=
X-Google-Smtp-Source: AFSGD/Uvl2zMeo5VrV7270WwbzuwAP+7dszbq6MsrSYAdl/F44w0Jn/ihm+kbSIXRlefSmJE21jT/j6FgYzT9tBxN5I=
X-Received: by 2002:aca:6155:: with SMTP id v82mr3186139oib.259.1543918748824; 
 Tue, 04 Dec 2018 02:19:08 -0800 (PST)
MIME-Version: 1.0
References: <1543913303-6216-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543913303-6216-1-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 4 Dec 2018 08:19:11 -0200
Message-ID: <CAOMZO5D_GTWvLUjJaPSmhPqgjadJh_4pTZqHKz92=1ZAeYkstg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabresd: add egalax touch screen
 support on i2c2 bus
To: Yongcai Huang <anson.huang@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_021919_875522_12DAAB1E 
X-CRM114-Status: UNSURE (   9.53  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anson,

On Tue, Dec 4, 2018 at 6:54 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Add egalax touch screen support on i2c2 bus.

Please improve the commit log saying that this newly introduced
touchscreen controller is connected to LVDS0 and the existing one on
I2C3 is connected to LVDS1.

Thanks

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
