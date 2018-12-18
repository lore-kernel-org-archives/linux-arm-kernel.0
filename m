Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B9DC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:57:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26AA721873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O0tkAXKR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J/uKzHzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26AA721873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bV4jyO7DankvU1N4yFtZNkiLxqAi0ixaiFB3GPb4Alw=; b=O0tkAXKRDLsl4C
	7+wvyUX8SvY3o7OtW0py4/9lSD68sVbE4i7UF4EXjQKqh+edq3PNQAhRmSVaGkyHQJmQWn8xSZH8Z
	sID/FZuEV1QWvLKhzlKzdJlYfnGXHHU2pEkfFRF+exJQjqo5cllkltEyx0Afa1ARtvw3LEr24txms
	wfsKC2Gbt4c2sGGq3g84htfrrGlyZx6nghDwtldox/QltHZknjNfUAA84weV29kZqQf3yTDvn4vOw
	Zy3Qu4Q8xGGw3MDQti3qf1lN3EKeS+UkaNrhRusWtmi4aPmH7cZi7O2yq0Gsi253eoH6kkl2rgUyZ
	ItHtMKo8Uqd33d+yVCFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGoo-0005lj-0r; Tue, 18 Dec 2018 14:57:58 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGok-0005iX-Df
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 14:57:55 +0000
Received: by mail-pl1-x643.google.com with SMTP id e5so7945163plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 06:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=oPB8RR+121EFL6hJxdpqH9a7Rzs6OxHUxpWYpeBbqVE=;
 b=J/uKzHzTJbz/I4UR5vW8rnKaBvgH4q/HxaFhUmG+v8FLAc3Dxu5pbWXgQBzhIiF7oI
 oEN0oAuXcS7S82Mn4WoMadBt00GVonjsJUkw4eAE/d9pRDwdDEXF820xe6+g3RTe61O3
 4petINecqiL8LczvuWdAalCg/e4HXQ4AnQm04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=oPB8RR+121EFL6hJxdpqH9a7Rzs6OxHUxpWYpeBbqVE=;
 b=P5PsV25O25eP5Rl/6EboRxr4wjYnSQBdpQXEEZunRCN3dJUuAAITUxH0rtfi4xZJ6B
 d06FQpQzGI40iGfOgAG1cYlRMcW7Y6dspKTiOFaS9fzv7j3KA0y0R3HXr5pjWhTsJclt
 suBwOQZVA5POb+4uSwGXlILhp1L901xMIuoF0QdMXkNqBG8zZbqFcJVUc3FD4rhVP0V4
 nJ5zFaYadniOOadiLd7DYO/S9xeM7wFM0Qnzccq/qjsFnDMhutE3XlqT2sJJKRyRLfKc
 deHDiR9C2diCqp0wuXFVwieBmwbbuK48GFo5ELfZYcEdnr0+jtMlKAFAWyhglJOplVKt
 qDAA==
X-Gm-Message-State: AA+aEWYXvUWlgXvAfDYLBVpxxPME0rDYi3KYPg1VuQbU8oqU3uZ+yLaH
 R0exQl+XaR4h8uid7QBtLvQ2
X-Google-Smtp-Source: AFSGD/XbkKHNv6vUO7lTSsVI93TGxtAlY7xLnt9nlCoIPUXW4wRHb2lMzPuI9Mv/hZRbk+I1dvRrBA==
X-Received: by 2002:a17:902:bd0a:: with SMTP id
 p10mr16185671pls.322.1545145063665; 
 Tue, 18 Dec 2018 06:57:43 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id l69sm32517835pfb.75.2018.12.18.06.57.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Dec 2018 06:57:43 -0800 (PST)
Date: Tue, 18 Dec 2018 20:27:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 08/11] dt-bindings: serial: Document RDA Micro UART
Message-ID: <20181218145732.GA22420@Mani-XPS-13-9360>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
 <20181218080527.10801-9-manivannan.sadhasivam@linaro.org>
 <20181218145443.GA5150@bogus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218145443.GA5150@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_065754_481196_78656BBE 
X-CRM114-Status: GOOD (  11.60  )
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
Cc: devicetree@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, linux-unisoc@lists.infradead.org,
 linux-serial@vger.kernel.org, jslaby@suse.com, olof@lixom.net,
 afaerber@suse.de, linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 08:54:43AM -0600, Rob Herring wrote:
> On Tue, Dec 18, 2018 at 01:35:24PM +0530, Manivannan Sadhasivam wrote:
> > From: Andreas F=E4rber <afaerber@suse.de>
> > =

> > Add an initial binding for the UART in RDA Micro RDA8810PL SoC.
> > =

> > Signed-off-by: Andreas F=E4rber <afaerber@suse.de>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../bindings/serial/rda,8810pl-uart.txt         | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl=
-uart.txt
> =

> Please add acks/reviewed-bys when posting new versions.
>

Hi Rob,

Sorry for that. I missed your Reviewed-by tag here. Will add it in the
next iteration which I'm going to send to ARM SoC list.

Regards,
Mani

> Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
