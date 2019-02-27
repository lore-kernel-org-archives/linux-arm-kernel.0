Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3CCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:43:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F624218E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XBGcoGez";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdFleDy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F624218E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+EYU7VDQnj7oOtn6QlSfLrAkkUPBnQWjoS8WjZWXk6A=; b=XBGcoGezt3/fWH
	5ZdUq8RZwv1uXBq5jKdpPIH88UwZ765c5gas4+q6Q4yx47a9ODcERpGRBfdHHdgL0g6exKdGRQXOU
	/MDocVvdYi1KDT7f9kiPJao+E+iBOyD/pHbAuVPfsE8wxsIvbX2etsduTh3U6xr8NMq4NTYHBcXfY
	ckJY5pV5G0tLIofVuFMFx1tldlZe317Ok94JYOdpHgNB9F/PzucCUizC6EvtjKutvWz91DMiRPotZ
	vH7c8HaAJA1m7CW9eJ3HXjKdBbb+ExdN+Dhl7tiQbB05cnWO+TRxa97KrLjiv3rSoM85LFtN5WQnD
	C7xlXbprCloDU0x0Drrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyoFN-0005KI-Tw; Wed, 27 Feb 2019 01:42:57 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyoFK-0005Bu-Ce
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 01:42:56 +0000
Received: by mail-oi1-x242.google.com with SMTP id a81so12090405oii.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 17:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8vCW/Wa8dcY8A4VZhcPLzXb5kVuJM8/rxF5r1eLFf1A=;
 b=jdFleDy/K/OpFEYG/BEAQsV3ZlQxOap9nG3Vs0jqfwT+wH0G6CRXDEMQML49Kydxbs
 5Q+qpxQy2ITIPdnNc5OjGPxqACsCupf7TgbQDhDc0/B9du96L3N0aRr6EiqgxyvNEyCO
 GaxNtuNzkUivMtBM9aZE/0bCfQMqK+dJLibpD4d0RBUovPQNQGUuWsIzndegVnavgI4s
 sIIs/sePzRJ0uR1ApKzGsx1rpnehjruAWHBF3lOdBMA8riJqalwirHCJWG3xcqmy8Lbf
 eme3ONiwNFqWmgRxy1aKgtGiBx/Cu0D0QufnkpwqjNfLqRMyomWMGc1OJpwlqmgbLjFG
 AZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8vCW/Wa8dcY8A4VZhcPLzXb5kVuJM8/rxF5r1eLFf1A=;
 b=nwhZPGkohaFjguFS1xb6CrMVz5JS3Ktkahf/azTav9Z1CVzBwtV54Vjjtg0oUMHinj
 bFdG7FxGP5EZsCFz7UE0hCUFX/Tv4ctnlJ0mM90VGNcmWdWoBB+dapibWdCDKAAdvT6b
 5iKLrljHVJavbFSCIkRbeu8LgqWKO+f1kOhndubV4QY70pb1/mRn5BvZH4OuGeN38ixw
 7WPQo/+fdCmAhGBqB2cTfGlatEbf9I9PTPkRTuwUA0xr9dPxk+91DxXodHyhfIXnRzqn
 Ep9KnaRwEnTSIzFl5cVs5h4YMM54adZteR6JCiOjCGtQT7tvH0B7EoK84hXfnjmOnlhi
 oykQ==
X-Gm-Message-State: AHQUAuZErTcMBFDkcIeDBk6nTWa0bi2X9x+yJaSKHhtjtnaXMsrQ/Te3
 wtKq9UspYcjd9Q9BgHYSNfWr51QdoyNM4rs6NGM=
X-Google-Smtp-Source: AHgI3Iag3I8rQGTloFiQlFwATou16YcDdDgnFdkS8hL1JGgcEQ6A86xFgCYWPkFmURaRoWeyWOONA5OokS6e7zkXaXE=
X-Received: by 2002:aca:b5c1:: with SMTP id e184mr4358645oif.75.1551231772955; 
 Tue, 26 Feb 2019 17:42:52 -0800 (PST)
MIME-Version: 1.0
References: <1551230622-30660-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551230622-30660-1-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Feb 2019 22:42:41 -0300
Message-ID: <CAOMZO5ADvmVO51fbrGjtGsDaN_AQcJs=+mBBQoPzRwhWasJLrw@mail.gmail.com>
Subject: Re: [PATCH RESEND V2 1/2] clk: imx8mq: add GPIO clocks to clock tree
To: Anson Huang <anson.huang@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_174254_981875_9A6A5409 
X-CRM114-Status: UNSURE (   7.91  )
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
 "agx@sigxcpu.org" <agx@sigxcpu.org>, Abel Vesa <abel.vesa@nxp.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 10:28 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> i.MX8MQ has clock gate for each GPIO bank, add them
> into clock tree for GPIO driver to manage.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
