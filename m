Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B28FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:41:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7E02192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jC5OoQBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7E02192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oq2f82tJtdWTOSfCDjTtkkjrRTfJBOxsIx1Hzrfr8Jw=; b=jC5OoQBVE/PFxr
	khhjM8umVP1vG20sNbnAi3PMEgfQag2SmwGzQDenE8GwDBxC/auUmy36/H+a0eX2WDH+fkF+LvMgO
	pcZ60+O1VBITYXdow5qgcRAkIpXZKHxSLDlQH9hM/8a+ZAsODyarruNhkVTrfRI6/rdZv5OYXQRSX
	/HkCmq7ZGf+17Hekx8nlKxoxtAE+gas++TPBvn0XzOkXbV3Iis5ByH9mvLbuDZgcGlVucVW8kRwuw
	q49eNnn2hwDAmPNBNXlebeqpTEBG3Wx7kYXMgwUecAWcDHlG8JqDbhzSVvlTFaFw3GKqKqYvnWhzY
	2zzZqVo3ADEnCBLKRSCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guefx-0002kY-6o; Fri, 15 Feb 2019 14:41:13 +0000
Received: from mail-qk1-f174.google.com ([209.85.222.174])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guefu-0002k1-5C
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:41:11 +0000
Received: by mail-qk1-f174.google.com with SMTP id w204so5818481qka.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 06:41:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4uNRJM7dazka7G4wiBtjiyv+VA94i45hBrC+e5bB04M=;
 b=TYUCHzcB2IYnMRdcriIKK8AoFHB6N24KFc33qrlvTw5vZWaNtoRW3Qi76I+MxQWTNg
 m/zVJwFs8KXQ+3c13rEzerxLQ3snuKKZF7smWt8wPD7oS9ixU2wHGQYgaSp1kgapb92y
 9JrfeHufSUyYZQEcy1JtD1pD2gxklhWJrraArnFrcNzdQ7l7a0IM36OvXRw9XrDrxGuO
 NibkWZEgiFAlfSI6HM3+4aG4ywE52G+hJ+PRkambvn1xofPSabc5kmSLhGgC7rCSkhXX
 SeuBkNVqlFv8aerRTYjeDKshw2hW817ViWNTt6ont1JutMyir4ftT3xokoCeEBdjFPpO
 0Zbg==
X-Gm-Message-State: AHQUAubC8bhw/C/bfJj4azjMoBUTUYCfJBjE4MWx7W06KjG0kaeIICwc
 Ga+8VVPjjc43+NE3crOUvvH5+hpUfABULJ565GM=
X-Google-Smtp-Source: AHgI3IaAKMd6gpTObloPLc7x3GkkOJQhAifyyFcJ34D9iTKa9bZ84K/D/QbTSl9qWZIVniKp3YodRwlShstEixDE/c4=
X-Received: by 2002:a05:620a:12a5:: with SMTP id
 x5mr7284370qki.291.1550241669009; 
 Fri, 15 Feb 2019 06:41:09 -0800 (PST)
MIME-Version: 1.0
References: <20190208102354.vwygnt2wevbjntwy@flea>
In-Reply-To: <20190208102354.vwygnt2wevbjntwy@flea>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 15:40:52 +0100
Message-ID: <CAK8P3a0oaEEfKJJVbicdY6p0ZHeTL7yCgYvFLms+u90isLiz8g@mail.gmail.com>
Subject: Re: [GIT PULL] Allwinner H3/H5 changes for 5.1
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_064110_194428_5EA82F1D 
X-CRM114-Status: UNSURE (   9.07  )
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
Cc: Chen-Yu Tsai <wens@csie.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 11:24 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> Allwinner H3 and H5 changes for 5.1
>
> Our usual round of DT changes shared between arm and arm64.
>
> We have a bunch of changes for board, improving the eMMC support on the H5
> variant of the All-H3-CC, enabling HDMI and reworking the CSI driver.

Pulled into arm/dt, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
