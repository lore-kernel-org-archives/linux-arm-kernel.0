Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B88C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:39:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D9F2192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qtUTa+jF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D9F2192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nVuEoORa3ZHbTfzfEPSr421dK9XxLBv01LJif4s+ujU=; b=qtUTa+jF/9V+is
	GeDaIKgrsm636PU+5jt7Xe73wJNi25Ft9epB8gFMMNxGqgYXSJO8LOMS+5LRujOS9okE5j8xQFAhv
	I4Rr5QoF4nd9Lo/4crWKhpFnYAwLxRl0/fZOSc/22DhgBDha5mnNymUhzh2lypsuH8eLGkwxDN57G
	PxTZC3hqvg4ZlhezFqYR+uGk+zhcGgszgNHLt7QqWnFZBGd20/qw01cfSNkLZs2SqH6OHHtFFToSy
	pfl3aysq1m+HJkLkqidgdP4S8f5ckMQj6rvIoIUckbEyP/awLEs8xQ77aUDt1Gu/XIAZpL1mCSOY9
	jY56CI/NZUjOFa/ObzcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gueeZ-0001BT-MC; Fri, 15 Feb 2019 14:39:47 +0000
Received: from mail-qt1-f170.google.com ([209.85.160.170])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gueeW-0001B6-MB
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:39:45 +0000
Received: by mail-qt1-f170.google.com with SMTP id 2so11081118qtb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 06:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iHQa20uxFdUkS45psg1iPPhX8Vf891fQZ0XjO3evSSk=;
 b=C+MK2Xmtr/Ldv83LeybToVJvUA4hVksYlpvEq5UAHGrTvI5li9sPVRTz+9WRUZkS5E
 z1yOBK8gkKn/B2ljmBi8gnAaBV2pQh1owzFG1D7hWIc7RB0ORa/uI5JrJUKuPRB3QA2c
 oPmlRyzKCjU147WJ+hZYV7z5wqgfhVHWiekQCXkywK6KUm3aHeDfWbSZdSkF73/Q7x6S
 5MAWbxmou57fj+Y5ljsQT4x04g70vELI0KoRIqadX6tzh5xNjn41eouir02e6uQuWSF1
 /L6sl1yEQSn8u1eI14Yg9JxKrgn/yqqHA0wuUv06q8ru7Bpu7+GKb2H7ZUNLj4lSQxuW
 KM6w==
X-Gm-Message-State: AHQUAuYNM+n6lVfaLrxE03SUxdF+LziY7eFh8j0ps058hx3OkFvUxrEC
 M1s63CGlu9UebukYVmaKGtMe44OmDrK63xbQeJw=
X-Google-Smtp-Source: AHgI3IagM4kav/GirhSNWuIYrLuem0u/FUa3QdrCRbjaA+s6OyvH4oWnvMmO9GzaD56ZUYg2nLIMosqIBtwEGvqUJ9E=
X-Received: by 2002:ac8:445a:: with SMTP id m26mr7723156qtn.212.1550241583629; 
 Fri, 15 Feb 2019 06:39:43 -0800 (PST)
MIME-Version: 1.0
References: <20190204160210.18046-1-dinguyen@kernel.org>
 <20190204160210.18046-2-dinguyen@kernel.org>
In-Reply-To: <20190204160210.18046-2-dinguyen@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 15:39:27 +0100
Message-ID: <CAK8P3a3rWE63yB2h7AGqO78aqkKmsBoxJyo5X0zv12YWN36NmA@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] ARM: dts: socfpga: updates for v5.1
To: Dinh Nguyen <dinguyen@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_063944_726862_D73579F3 
X-CRM114-Status: UNSURE (   8.93  )
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
Cc: arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 4, 2019 at 5:02 PM Dinh Nguyen <dinguyen@kernel.org> wrote:
> SoCFPGA DTS updates for v5.1
> - Add SMMU node for Stratix10
> - Add vendor prefix fo Novtech
> - Add a new 96Boards Chameleon96 board that uses a Cyclone5 SoCFPGA
> - Add missing reset properties for all IP on Cyclone5 and Arria10
>

Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
