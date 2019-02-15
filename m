Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72EBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:45:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7499A21929
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HyzJ3u4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7499A21929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0mFAo+4NH80kg54SuOeDGnBGqfDxbirN0Y/6kul3GtE=; b=HyzJ3u4wsKOc7B
	knK2wEyI5fpM9ObJfMOJ+onnlzciMTpsv6o+JFJJYHEHqbcQaqgkOOgPZ6F68xGWWmR6vbO71aMPC
	ILNZhPyTHOqfYurC3b7U177EAzQYBlwqReIArIFCP19avmPt6wjjACZ2qoe4PO9VDS0QdeZlDxd1i
	nuneGd2IMJLa7Gf7LPndf/PMjDuqYz9tjz/jUw4tO2S6QEcaEjUlzeUwd2Hoaa94jTXcR9kDVKGLR
	VqE0LAxp129JsYExrr0sIKr4oTUeytfIkvQgAOhj41stne+ow3NmruQqxn04qGWNvDx8CbB/6jYb4
	e4bNGBU8gnGndkkQYd+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gudnz-000251-2J; Fri, 15 Feb 2019 13:45:27 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gudnv-00024c-Sd; Fri, 15 Feb 2019 13:45:25 +0000
Received: by mail-qt1-f195.google.com with SMTP id d18so806577qtg.12;
 Fri, 15 Feb 2019 05:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QyOqICY3eZNFIbTxTfNef2jzPJWfWrD0zD5rE/jrKis=;
 b=P2HT+NucfLPvVbOIL+ym311ewMVQhAyLIxQaQasPggNVRhIU+y7h4yE5Q1DKABqIyE
 rvfH4fZqoWSl/ncjcjG856wHIkOlGzmBYAN4nNWPqh5jDtd6fWFy/aaGt5v8GXDCUJu8
 3z1Ps+Ua2fNnOfGsfRLx08yvBDSfB/j4FhT4ONEOI9xe9ibCbiSL+Y/mPb8AIwb/394K
 5gW9ukryhiD5PQA53gQLupft0BdVSXtMW4mZTIeNFGUGzxf59/XseyNxp5RocoNPmcun
 t9IlPAbe9bPwVvTGIdnkPoTufTlufUMPQboG0mFkKjUXfmEw6KZaWFSGzyjwo5qtXdOO
 TQiA==
X-Gm-Message-State: AHQUAuaQ70F7eCj/12cFUb20vsNGPOnMB5MNrpZ75mbehY0GqNF602EX
 t6mtlvdADPOCtexVYD28k4qRVrShSIXOnmBgmsoA5Q==
X-Google-Smtp-Source: AHgI3Ibi9Br09JkFC8MX8HZ/LfD26HeZEtUc40fhkz6WbQTN7z9IzEsf8mfJLd3LT+NAgKSl3nQDHzurAAM3VDrHWGM=
X-Received: by 2002:a0c:98c8:: with SMTP id g8mr7381666qvd.161.1550238322531; 
 Fri, 15 Feb 2019 05:45:22 -0800 (PST)
MIME-Version: 1.0
References: <2570520.8EeqtpO5V7@phil> <1744093.FyxTZ0jN5f@phil>
In-Reply-To: <1744093.FyxTZ0jN5f@phil>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 14:45:06 +0100
Message-ID: <CAK8P3a2drxVzNgsKcM2ii62+NsVmsCiOKGirQeby0kOFRQnX_g@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] Rockchip dts64 updates for 5.1
To: Heiko Stuebner <heiko@sntech.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_054523_922446_3774D5FD 
X-CRM114-Status: UNSURE (   6.84  )
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
Cc: "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 1, 2019 at 12:24 PM Heiko Stuebner <heiko@sntech.de> wrote:
> New boards are the Rock Pi 4, NanoPC-T4 and NanoPi-M4, with the last
> two being part of a family and sharing bigger parts of the devicetree.
> rk3328 got sound-related upgrades and a wider patch drops mmc display-wp
> fields from nodes which shouldn't use it.

Pulled into arm/dt, nice to see the additional rk3399 boards. Thanks,

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
