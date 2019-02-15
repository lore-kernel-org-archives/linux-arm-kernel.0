Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650D6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:47:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 343F42190C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V1Jv8ARS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343F42190C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r3XyVMKDxKWRAGO93EXjH7tlDH0BCzkUl8sB0zr8yKs=; b=V1Jv8ARSuWr0aO
	9KAmE21WxHKDIM4q1S/W/q6m6CoZuvOat+LYkicVtVRbG7LL7KlvviX5w5qbbKyCsQhPiye/C35eq
	wJCDnFQtLJnbEe0VYjYbTrMENZzPnUyqQkYUO3pHqtYYhE5RrXIU+ru5plsRUaYPaOv9D3auJxe2E
	ZhjT0TRjfiSLFeErPbkiP5mtk3nz69pfrflmzPxCNyuZp1V68klkzTqr1QDcpqfTa3+pqjXX0GilZ
	1pjvNwA3trBUfXyIGxK6wNzsbwGXNgIy53BaBtblblFATZYRmAjcWWC+R1TDWkyPydHisds6G9h0n
	f45l9olNN/1skZIBU2vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufhk-00021i-6z; Fri, 15 Feb 2019 15:47:08 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufhd-00021P-K0
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:47:06 +0000
Received: by mail-qt1-f195.google.com with SMTP id p25so11059323qtb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WaPfjy+XgMdRFsg07k2IRtUtJun93tqOJo/jyUAA4to=;
 b=lzHi/AUX+RMpMXzQ8wlQ3c3pPyBCTIvrrXlZWFA7az8XFIGH8BKYBjXGENIa62NmqU
 oYkVE87iN8cUklJLkRBxzHD7K3ZadrYDim71hPDj+YAfA35URaBBoWbSZNbSpFHpM07o
 MVTgqkfzfRhZnxNzsFO0BqHzvdiFGbajzHRppJUeiGi5z+y32PJ+VSPPqhd1CZXspnb7
 VRs3ufN460K2wuoEaItskpVpIb9ddKqvHAODauk7346HT3fjOSg93/EfzQ4I6Y5fYMAz
 B2f5Z1SDE67xd8ArH1BqRqCObQQvbr8i9QRVwjDKpuVaH63hh3COptwfNgdzBtXNZo5V
 NgzA==
X-Gm-Message-State: AHQUAubZbaU460R1LoVYGx/m9XbGo3zXSb9y044bOzro//ohvO8TOzUA
 TUHiw4BaiOvk8eIRtHs7SI041POufnOjOt+ZAhoVCA==
X-Google-Smtp-Source: AHgI3IZPyiqAQrv6X1xhfAklvNxYwHHiDiMnlt1BUJ1R+BxN0qdcH5HI2kvyiVN9qZ9xi8lu3NgCnRTZ3BKTRcjMtk4=
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr7593064qve.180.1550245620766; 
 Fri, 15 Feb 2019 07:47:00 -0800 (PST)
MIME-Version: 1.0
References: <pull-1550167958-188990@atomide.com>
In-Reply-To: <pull-1550167958-188990@atomide.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:46:44 +0100
Message-ID: <CAK8P3a0N3J3uvFN0JxqBx+pJbUuQaoLgGu73_XLeOD6_fxBHzQ@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] defconfig changes for omaps for v5.1
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_074705_198277_8639D9F6 
X-CRM114-Status: UNSURE (   9.92  )
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
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 7:13 PM Tony Lindgren <tony@atomide.com> wrote:

> ----------------------------------------------------------------
> Defconfig changes for omaps
>
> Drop PROVE_LOCKING as it should not be enabled in the defconfig. It
> causes quite a bit overhead as noted in the patch description.
>
> Then let's update omap2plus_defconfig for dropped options and moved
> options. That way makesavedefconfig can actually be used to generate
> patches against omap2plus_defconfig.

Thanks a lot for doing it this thoroughly, pulled into arm/defconfigs,

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
