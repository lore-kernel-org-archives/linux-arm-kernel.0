Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10E2C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:24:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C9DE2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZcNVp+2v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyRBPFna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9DE2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uqj3i0GcBrBvmzY/xUmcBCZswL4+e0kw1BI1+/bCXMQ=; b=ZcNVp+2vREPksX
	3YeBB5VK+X+KZpWGbFmLjX5Ot1YWbvcU0l6ra7CtOwoFtxls4LmvA14PDNxIn2kMmIyGhIzofNyl1
	eKjmYUnZtg92i4/p/tua7ZYy/1bP0Tf/L7hpimD81G2DsG/AVdl/FggsONCn10ZK1BKR6Qv5JJXRM
	JpocgUejX0jGCySNI6BOM27siXvkbSGKbFEs+LNnXmEdXYPZ0AcPQy3WPTNNUHhhiGIwcA5+xSkpX
	z5VO+no8cB2yJi2HseQvGhdJr9b6nbIjHkhi5qAXMWG9kWw5fJlHfTtgWN4M7b7g6g9NnGtQCkAtg
	Q9Hb53j5pfToOlIL+oQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBaI-00013F-TT; Mon, 28 Jan 2019 18:24:38 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBZf-0000NV-Nz
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:24:10 +0000
Received: by mail-wm1-x342.google.com with SMTP id d15so15082250wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Xj0d7I32fuOoqVi/A/OMH6CHS57j+7/CkGP/z0TtpYo=;
 b=DyRBPFnaOtHAe58P28Ksxfr8kQ9iztZPGwdqJND42tFnfs0mkVaU0Ni1na9iebvPr0
 riU2eO7DtqEg0bJhRiOaygMeNgKSMW7+Gkur8bqM/zfqSd9DE1GZHW4UxiKkcj2/cLJD
 1yABo0h5Tl8dsod21VE1Ss/4YGlX0gmcig0uxJ3GZ66a0IDRke6egMG/Abx4heXCa4Ow
 9VXnG2H9lFjNz/f/0GU2XAxT+iMTzktW68Ygd9sFRsRvWw/iLq431D2xJj9E0NhtWoV6
 t13dPcDXcLs2abwAwQsaZivo7nN7C57Sk8exyYm8EHuVGcjho/nso0n0rd+2MUFirGqs
 KFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xj0d7I32fuOoqVi/A/OMH6CHS57j+7/CkGP/z0TtpYo=;
 b=L62wI+pfLa0YnTopwESk4XCz/diBDbXV3lTzjkH5qyojzwiu1bgc6Rg3HHpnnfrb1M
 2GvWO37gwilVjcAakCB3eGmIuKwFLftBZCKhowJBmAVyUMtA9Cz+7LMTTB9gAfGAzC1K
 +zwM1Nd0lPcGqD38C/GL0qzUMLpnSw/5z6qT3j9vdXkB9TDXAQRF0lI6Rph9bs8DbdA5
 lKV2IUu3By90Yl5WqcTWhlImjC4Ih7kIY5MvPZfKUi+9LinsTy67J5QC6iXgYDyiTrzI
 aDv4wAaH5oZfNeQr2KeGwLDYckm0x1npAl4vL0WK5/RtbuKtrje8q3yFM+8JSAttDf0O
 inng==
X-Gm-Message-State: AJcUukd6e57NA4VayO2tzp7wer+Q0WZEpFagD9WKP/ysZSQxvTdu51+D
 VzNi4ozUDz86r2TON2QL1/I=
X-Google-Smtp-Source: ALg8bN5yTpyDsiVwfOmewXm63lxTer9dRcYX5iq2Nh5OnyJ2MskdmF1E3Sbs+oLlBOelH08kGROn5Q==
X-Received: by 2002:a1c:9a4c:: with SMTP id c73mr18785268wme.35.1548699837472; 
 Mon, 28 Jan 2019 10:23:57 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:2c9c:e1a3:b321:9449?
 (p200300EA8BF1E2002C9CE1A3B3219449.dip0.t-ipconnect.de.
 [2003:ea:8bf1:e200:2c9c:e1a3:b321:9449])
 by smtp.googlemail.com with ESMTPSA id m4sm213090wml.2.2019.01.28.10.23.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 10:23:56 -0800 (PST)
Subject: Re: [PATCH 0/3] at803x: Add quirk to disable SmartEEE
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 Carlo Caione <ccaione@baylibre.com>
References: <20190125125513.23656-1-ccaione@baylibre.com>
 <20190125130612.npknjuzjmny4yohg@e5254000004ec.dyn.armlinux.org.uk>
 <20190125184330.dm3kaoewvbwddacy@xps>
 <a8b8e82f-2b68-ed9d-6106-0542dddc1181@gmail.com>
 <20190125191947.um4w4e5jpsv2kcxc@e5254000004ec.dyn.armlinux.org.uk>
 <3e09ef54-f817-2659-4e9e-74a88a80cbcc@gmail.com>
 <20190128104620.3e724lfm5xv5il4x@xps>
 <20190128155739.yyftnu7a5hz6if7d@e5254000004ec.dyn.armlinux.org.uk>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <9118a1cc-7ad7-cdfc-4925-d609efbc8265@gmail.com>
Date: Mon, 28 Jan 2019 19:23:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128155739.yyftnu7a5hz6if7d@e5254000004ec.dyn.armlinux.org.uk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_102400_779416_C4B9853F 
X-CRM114-Status: GOOD (  28.66  )
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
Cc: mark.rutland@arm.com, andrew@lunn.ch, f.fainelli@gmail.com,
 devicetree@vger.kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
 abailon@baylibre.com, kernel@pengutronix.de, fabio.estevam@nxp.com,
 shawnguo@kernel.org, aisheng.dong@nxp.com,
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 28.01.2019 16:57, Russell King - ARM Linux admin wrote:
> On Mon, Jan 28, 2019 at 10:46:20AM +0000, Carlo Caione wrote:
>> On 25/01/19 20:27, Heiner Kallweit wrote:
>>> OK, then the description of the referenced patch isn't fully correct
>>> and SmartEEE and EEE are partially compatible, and the problem is
>>> just that we don't know exactly to which extent.
>>
>> Reading from the datasheet at [0] it seems that SmartEEE is compatible with
>> EEE but it's something different.
> 
> As I understand it, SmartEEE is just like normal EEE as far as the link
> partner is concerned.  The difference is between the PHY and MAC.  What
> follows is a simplified understanding of the differences.
> 
> In conventional EEE, the MAC takes part in EEE - the local MAC requests
> that its attached PHY enters LPI mode, which signals to the link partner
> PHY that the data stream on the link is going to pause.  When the local
> MAC wants to transmit, it first has to signal to the attached PHY that
> the link should be woken up, and the MAC has to wait for the link to
> exit LPI before transmitting.
> 
> With SmartEEE, the decision to enter LPI mode is taken not by the local
> MAC but by the PHY instead, since SmartEEE is designed to produce power
> savings for MACs that do not support LPI.  Of course, they won't achieve
> the same power saving as real EEE, but they do help to reduce the power
> dissipation in the PHY.
> 
> PHYs that support this buffer some data from the MAC, and that buffering
> has to be sufficient for the delay in the link coming out of LPI mode
> without losing data.
> 
> As far as the link partner is concerned, EEE and SmartEEE appear the
> same.
> 
>> With SmartEEE the PHY can actually enter LPI state even if this is not
>> supported by the link partner since the LPI pattern is generated inside the
>> PHY itself, so auto-implementing a sort of EEE.
> 
> It sounds to me like you have this the wrong way round.  SmartEEE isn't
> about the link partner not supporting LPI, it's about the local MAC not
> supporting EEE, but still getting some power savings.
> 
> EEE (of either kind) can only be entered on the link when both the
> local PHY and remote PHY indicate support for EEE, and have negotiated
> that they support EEE.
> 
> Most of the power dissipation is from driving the signals into the
> network cable (which is a lossy environment) to ensure that the far
> end has sufficient signal to keep the link established.  SmartEEE is
> about giving a way to enter 802.3az EEE mode on the _cable_ with a
> MAC that does not support EEE.
> 
> I've monitored the signals on a link with an Atheros AR8035 with
> SmartEEE mode enabled, and a Marvell 88e1514 PHY in a Marvell switch
> on the other end, and seen the signals on the cable quiesce as a
> result of SmartEEE, but only when _both_ partners are set to allow
> EEE in the negotiated link mode.
> 

If SmartEEE is compatible with EEE on a PHY level, then I'd expect that
advertisement of SmartEEE at different speeds can be controlled via the
standard EEE MMD regs. Is this the case?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
