Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A3DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:48:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE44E208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LIQeNj8g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfhlDcdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE44E208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RYGZ98uo5/DgOqY9Si0jS9OOr1JfuDMWTxP8vJ/EAeA=; b=LIQeNj8gTkBgyT
	PSySw7Lt5TzWx3RrzRSjK1vpK9Wd6OyDbmSRj0Erkh1OmzjWlC+/IYbL0o1/BWCw+SWUK9BR/4kGN
	myrmTxj/g4lEF1Fr0uFbuaEyeVUqgEpuFZ5vW/PVY6Vh8AVy5zT1MXb6Ek427ElhjPCX3UxGZH3ap
	5TPwcZ5aHqm3vNYx0Vjy1cVrAqIIPTRa4gSg9LPXlcaIeKVy853ZZ4im7NrQamqZ6WLoelCpWhJgP
	pXsgeoN72o+eJsL/ZiE/bq4bipLHI5TcZPesnUg+8BmaYE94ECHx7BkcBppKp5oBe126giMpfHrUk
	GU3BFDZxaDvnjTsMdrZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUimK-0001hD-Vb; Thu, 06 Dec 2018 01:48:37 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUimE-0001gX-S6
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 01:48:34 +0000
Received: by mail-ot1-x341.google.com with SMTP id u16so20614266otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 17:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ktRLrqEVd0rHe1ATQCTmpQipaPMRkC9on8qaW5eFxwQ=;
 b=KfhlDcdLy76j3M4SHQh6n0gNFVIaZqVMqC2Djrmtlpz/MIHd1Z2q9UYOZGC5MnZpKs
 x7FGX6KtlBR1GEmXI1Ip7zB6EEr081hhbPBLjkcJLugoF2nczVNxn3NeqoKzBYU2Ba0T
 y6dudlRvfiftXWRbRdD+9RSmUUyjnkHAnyIRjloElurj/JwSXfAYzDuPWlXtZ845HmyP
 mAzSLLX8iASMVUmxDSFiG9MzJUZyg+LL+X0BUTQuvgT/hygQSxnpMjX8nOPjCwCScYmI
 8/3mYXVzOhoQDuZoQ9KfZ0qqxMn05mzU2Q70Nx0dEv71aongIprzwyolq5t9+zj++c25
 NqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ktRLrqEVd0rHe1ATQCTmpQipaPMRkC9on8qaW5eFxwQ=;
 b=dJLPZpW8qgCkKMSUxWfGi2L35AT7VdyvQTC2HWNA5aPXzvfuQq74pM4j7Ju664BWSM
 CFWnh5m/bJ93w0aOOpHIHfbYaUpJKRm8NYuej6Q0FhwCxxBflaoIYHM/hxSNsIy2juNV
 rQkhjHjjRBdcQ32/GIurTHll1vtLH7itT0celx1+7CGsBOfeC0vxUQ/4jHfeEvzXPSg4
 wAtUOIkn+zJ7vPY9P/1UOL6jRTbAL+6gwr3j4QFT1k5HxBhLzmf4jiccFPAzcOQ+ir3/
 lvp4TYi7ebXXD+HfsRR1mv7+2jg7um+bab20omSphWK8nd9amutNjQQokXQREPreeVTc
 cbdQ==
X-Gm-Message-State: AA+aEWZ+YxRiAMt2hT4u+RIKMQCOG2ckRphv50zJk46zvAlH6JcDLA7i
 gUOXkFHdX8dP3KwV4wr5oRE/vd3+r+nIZb3Dl4g=
X-Google-Smtp-Source: AFSGD/U2ysRr8LvdamTeTexn5fIj+skIkFyASoCwpGBWeAJZQCBYyfacZnIDNnsvzHbNMXWLBmN0CzwSe0SE84UW2oo=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr18316264otp.225.1544060899603; 
 Wed, 05 Dec 2018 17:48:19 -0800 (PST)
MIME-Version: 1.0
References: <1544060203-22163-1-git-send-email-Anson.Huang@nxp.com>
 <1544060203-22163-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544060203-22163-2-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 5 Dec 2018 23:48:24 -0200
Message-ID: <CAOMZO5BUPAWJBb8XQrYF7dTfSdoBNbK85d10QN0e4+X=tUPbQg@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] ARM: dts: imx6qdl-sabresd: add light sensor support
To: Yongcai Huang <anson.huang@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_174830_902852_71A7ECFA 
X-CRM114-Status: GOOD (  10.70  )
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

On Wed, Dec 5, 2018 at 11:43 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Add isl29023 light sensor support on i2c3 bus, the light
> sensor's power is controlled by a fixed regulator, since
> the isl29023 driver and most of other sensors on same
> board like mag3110 and mma8451 do NOT support regulator
> operation currently, they are all controlled by this
> regulator, so this patch also adds the fixed regulator
> support and make it always on.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
