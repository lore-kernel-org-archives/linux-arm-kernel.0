Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7043BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:55:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BAA421850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WEkjkPu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAA421850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YVK8w/Rikx5DaGcfTtss8zGBQQszPyyYV03G42CdOn4=; b=WEkjkPu9lFUB7S
	HzbJCW0AQw5gAu2upm5lMYxmqfM+uiDvqRUpR/kLnxOMsyYKE0ImgALPOOknlPXUsKuCXLJWkgUi6
	RPhYqx6olb5VnGF+n6wi/SlTv+ED3xlBJZSjbmb9R5xsoySSv7hlPrs97z2mWxI6178IUD9YRZUGB
	H2aLn+WJk2QQFERCEJ3VaXB5yV9s87VHzGC1RRl8q2t02dIIdT+hMRDpkzEQLNe9uXa+nx6N5fDp3
	4fYBqyu7pXW6Pw6ChHHaIpVRUcazg2yS3B5I/T79g8cBAnyHmeoYmUkzpvE0Ih1te4Jb4ZF85tL5j
	feVaVEPJEVsQ3A7RlEyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGlw-0003k7-CE; Tue, 18 Dec 2018 14:55:00 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGls-0003id-D8; Tue, 18 Dec 2018 14:54:58 +0000
Received: by mail-ot1-f67.google.com with SMTP id t5so15951439otk.1;
 Tue, 18 Dec 2018 06:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=4k5kZxIdDFfoQz0/tRnJEj6f5m3tJzXJ5ZlNyDMUVzU=;
 b=gZkTlHY3EV0VTbK0yBkBW/ZzxnotufbrQ3VBO9SuhW+hiXPzqs/s4nCLIkslLvVOc5
 4x3wYuYHoqWkabrGK76yPA7VRmP2/8YjD2RWoFbbNAgQlFEwFsnuMhOgjs7RRFyGpKts
 B75tPkn3qnvurDkj3d2Z8ehNJOOAr/BXBp5ObENfb563fjgAuziNP4ZkYeKsCHyoslZN
 6Sgb/R44DRi+0mychvaqPNhPmTvzCYmpmRuzFKNHeGB1o/bqW3/ft7Y5GS05S+VR9QvM
 gBabAi5Y4uBDicqrNrDESTSGMsGtrc4Z8Snlu3/YkjC0VALkIuquEcR83cW/6VfnfTOa
 UA8A==
X-Gm-Message-State: AA+aEWZkBgfHaqpseLjNALKXpTQIum9VQXdP1/P8s/IYu3tykvUJJTZM
 xcHf0FOZ0zNYP55lRUWozQ==
X-Google-Smtp-Source: AFSGD/Uoogt6H9PwWIl7a41DSxWnEZV6v8OLqxpb77pArrv1WhL4PajgKZjBCewzsiuf75V7S7OePw==
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr13253162otl.343.1545144884729; 
 Tue, 18 Dec 2018 06:54:44 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id q128sm7846876oia.4.2018.12.18.06.54.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Dec 2018 06:54:44 -0800 (PST)
Date: Tue, 18 Dec 2018 08:54:43 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v6 08/11] dt-bindings: serial: Document RDA Micro UART
Message-ID: <20181218145443.GA5150@bogus>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
 <20181218080527.10801-9-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218080527.10801-9-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_065456_447902_193E37D2 
X-CRM114-Status: UNSURE (   8.73  )
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
Cc: devicetree@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, linux-unisoc@lists.infradead.org,
 linux-serial@vger.kernel.org, jslaby@suse.com, olof@lixom.net,
 afaerber@suse.de, linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 01:35:24PM +0530, Manivannan Sadhasivam wrote:
> From: Andreas F=E4rber <afaerber@suse.de>
> =

> Add an initial binding for the UART in RDA Micro RDA8810PL SoC.
> =

> Signed-off-by: Andreas F=E4rber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/serial/rda,8810pl-uart.txt         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-u=
art.txt

Please add acks/reviewed-bys when posting new versions.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
