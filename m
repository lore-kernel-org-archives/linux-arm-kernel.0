Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AFFC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:22:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A682082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QeFIXhDg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex/9PbAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A682082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JyB9eZ2+Wi6xbOH4ytL9pQ2Y02DePrZ4QzmfpVPjITQ=; b=QeFIXhDg7X1fee
	ZF1x6Qs44PLNsqIKQSJ/8a9ZNuoS+UrcS0X8U7IGeFfZNPqbY4nGfQ33Tfl0ke0ND9sdMQYK5XifR
	PK+UPWDeW3Jcv/DSM7+id4RLJ7Xxhwv09lpA+CfBqZTImA7fsuB0XCxqI2lzGUno3qtB/Y/U2dop0
	mdWbmyOOlXZEXRIn5U5hzjZbyonjf+bXjzUjxod6hVLE+OM6H/+CGN1JwSmGqK7GJ1wNiJ6QJPpEZ
	CZIGlwdHnNNzZEDyzM6Y1oKRoWAhQnmMK92V6UIrWmiegn4FBixMAz7KQ0ZzLQHS6yr2j/deqzTsd
	taQPj5zoMOFKHmXIuYtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqeCm-00010f-7g; Mon, 04 Feb 2019 13:22:32 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqeCi-00010K-Ns
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 13:22:30 +0000
Received: by mail-ot1-x344.google.com with SMTP id s5so12845351oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 05:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lSQdmd2kcJrVrwD0q0YsTpo8ja87IdZnCDO1avYLAAA=;
 b=Ex/9PbAABf4BXTVDGixv5v+Vwhs4JBt2B/yxr5mfbDLeHr+EoMeZtQXzAR3io1uTkx
 GSIj9As7Qcx+xG5rAoy0iCZa2nIo4MjkfybYNgF8RdplkmZxLzb6wuoDA5TA2nKSr+rR
 dnTXi8d6DziSPuaHABON3ZeCjs9vwLY0goHqed+3uwUhT3KF3D110q08a/EClGZRDzrF
 iiuu9moP/n3Tr8EOiC8am7RQyfdOByynO5y733jhgasbvVf4rm2Ax49o7L5QvfRoaZ2Y
 9vVdJ9XCIwWYrzB1GVwnwfFcywIjqQZYM0qNNq/pj6gjQEv/gRYpAamX1g35mN2jbHcT
 iHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lSQdmd2kcJrVrwD0q0YsTpo8ja87IdZnCDO1avYLAAA=;
 b=Ygh5AAZH8tIQABGp3FhMOutRridV+KgBFfqktZDN1k4EJ5vkmhQQOCz48g/hkNIBEx
 sZYgdHmjmNewpiMoFo7lZobTCF7Sp7xtPomUhldi6ZXx4qOqdT4gw7OTB8C4udubPyAi
 xImyKSs6ClcWoA5UybNqVd6Tt9KisrnpRKsC2+RJQ2SB64pS/tf/Xr+uEp7EvsJG4fao
 KpQSkTOMmVVwRK0WWwF769A7uSKV17vThhAw9//ci+bX9PfV98MrGmwuGQwb3bFYO6yF
 Hq2r4CuordQRTKWV1FO4ZKMWqQrqr7xhsklPJqZmQpKTWYntrWgk6646qeHKBCqRDiVG
 i4eg==
X-Gm-Message-State: AHQUAuZ1Iym+1yci3V1iaGubbGB7GgffjQ6MSvmhxYzpbfj3QTkaGDqg
 M/tonLwo7II6YJTvexvJ0xGDvWgpKU8yIx7giLs=
X-Google-Smtp-Source: ALg8bN4T5wE0BmGjYGMLuC0d5JWohewsUqguCamal61iHGds9rz3sxc3sYrs7e61GoVwasuM9DnQbuKHauagDPiFLhU=
X-Received: by 2002:aca:ab53:: with SMTP id u80mr27435127oie.261.1549286547053; 
 Mon, 04 Feb 2019 05:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20190129231711.21844-1-andrew@lunn.ch>
In-Reply-To: <20190129231711.21844-1-andrew@lunn.ch>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 4 Feb 2019 11:22:21 -0200
Message-ID: <CAOMZO5At_YthgUOexhNMwiZZcqh2bG5D_B8ZLXQbtfkeKYHf=w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610: Add ZII SSMB DTU board
To: Andrew Lunn <andrew@lunn.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_052228_811393_5317C295 
X-CRM114-Status: GOOD (  10.89  )
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
Cc: Shawn Guo <shawnguo@kernel.org>, Stefan Agner <stefan@agner.ch>,
 linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andrew,

On Tue, Jan 29, 2019 at 9:17 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Add the Zodiac Digital Tapping Unit, a VF610 based network device with
> 5 Ethernet ports. One of these ports supports 1000Base-T2.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Looks good. Only minor comments:

> +&i2c0 {
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c0>;
> +       status = "okay";
> +
> +       gpio6: pca9505@22 {

Node names should be generic:

gpio-expander@22

> +               compatible = "nxp,pca9554";
> +               reg = <0x22>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };
> +
> +       /* On SSMB */
> +       lm75@48 {

temperature-sensor@48

> +               compatible = "national,lm75";
> +               reg = <0x48>;
> +       };
> +
> +       /* On DSB */
> +       lm75@4d {

temperature-sensor@4d

> +               compatible = "national,lm75";
> +               reg = <0x4d>;
> +       };
> +
> +       at24c04@50 {

eeprom@50

> +               compatible = "atmel,24c04";
> +               reg = <0x50>;
> +               label = "nameplate";
> +       };
> +
> +       at24c04@52 {

eeprom@52

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
