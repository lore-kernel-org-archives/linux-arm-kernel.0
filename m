Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89867C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:55:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E7E21924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ffKRmE4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E7E21924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HVeiismvB73qpK/Uj6WUWq00Pyh6vmM8EC/m1dqKTRY=; b=ffKRmE4HyRkQV7
	PvsLAyPqTFPydaG92ZHfZgRdabIEkUZkbJg6vrq23LTWz8/V8/FnpaEHPHOFHufy0RtzFK32L2GZ1
	K0xVIRbztXRbxbMWc0JeAjyLCPb+QJfEYt/b8Onu7+r/lIu+czQplwsq2pMrQZCz6g6dh2Q1pjYF5
	FvLTilWhaziPMe2XZ/A2XYDJoxws+KjPEyU9S+PihFj8aaiKLAvey/kF/qii+szLAULjtATpvmgSy
	qx/zA2BK+dLAL9oJ3+rykeEtCfTz8DX3J1b1S4CsWsWJrK3wNlsLWGgycWcGmNVZ2iYfDEA6C3tOw
	aSL4QazDlRNBQX2UnitQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugln-00007Y-2S; Fri, 15 Feb 2019 16:55:23 +0000
Received: from mail-qk1-f176.google.com ([209.85.222.176])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guglj-00007A-Ip
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:55:21 +0000
Received: by mail-qk1-f176.google.com with SMTP id f196so6054776qke.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:55:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BemCv2ezk5kQuLCDI43Xh7k28A5krBzV/RVWmMVopiM=;
 b=Id66TEG05M3cZyRl3d/H0o+P4WpsW38P73Ofw7NhzhuyoSLfguVOKQLYPn6HrANJmj
 mlsoouSGfK89wGr0GHiHf6Tm+AV1gVgGya5Eu+1ONK5r/+fRO7p0tLxL+fiA0Y9lPuu6
 4mg2dcPwCPcl4++ZGQlgusK9AJkegNfSJkWQXu2DSGAoo3f4GrsIpGsnL5UH+tRKg0/O
 Utf4SEc7h44+lIoJThIiDWGT68MJhAUTTR/iG0xPk9KdM/xIrStkDglP9hnqj5anMPNR
 w2eiJRhDLZhl88t3Od12PryOjr3KhHLqo1Tr/0xDjVce/ooKXpJIkvmjo0PuSVf0hA7N
 BnLw==
X-Gm-Message-State: AHQUAuaiI9S2qImzrOx8PY+/oFW352e50iGw65SvKXtSdyKjQV4CC8Q3
 bHRgo7l1BreexKBG4aOJ+d/RPF8CXMreAVtM//MMog==
X-Google-Smtp-Source: AHgI3IZCpUosEc0nQAaewKavoYEQU5lrgr0F5DgakF4e0uSHN2XqE3bC0RRBPHn/wC0XqQOuIkcs918MQMBfc+mGwws=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr7562241qkf.330.1550249718234; 
 Fri, 15 Feb 2019 08:55:18 -0800 (PST)
MIME-Version: 1.0
References: <20190201084533.12881-1-nsekhar@ti.com>
In-Reply-To: <20190201084533.12881-1-nsekhar@ti.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:55:01 +0100
Message-ID: <CAK8P3a15Vym=LK7qGBSnVsRavAEV=+fgvWh=SgHSL6h-W2d6Yg@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] DaVinci SoC updates for v5.1
To: Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_085519_614369_9C424F47 
X-CRM114-Status: UNSURE (   9.85  )
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
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, ARM-SoC Maintainers <arm@kernel.org>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
 Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 1, 2019 at 9:45 AM Sekhar Nori <nsekhar@ti.com> wrote:
>--------------------------------------------------------------
> DaVinci SoC support updates for v5.1
>
> This pull request contains changes needed to modernize the at24
> EEPROM driver and remove the legacy platform data structure in
> favor of device properties. DaVinci was the only user of at24
> platform data.
>
> The branch is shared with at24 maintainer as immutable commit
> to build upon.

I already merged part 2, which includes these, just noticed I
had not replied to this pull request.

   Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
