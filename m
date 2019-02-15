Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0E0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:02:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 744C421A80
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wkg4a8iC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744C421A80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nZM1atwt87GPCG7HhJfVwQMy87M1mRFuaY+DHsIQG74=; b=Wkg4a8iCnQg5BJ
	Ni0HYmAa4rzQdJVzaQ8r5mZfneJtS9wavAwfEPgHjySucDmmglvX/vU2hRY7l9H2W130VErYOtmd2
	hkfbm4WSXs+YhhUdbF5hOzEuhLBkSBvkGS8UF05EliMll52rUXTTli3RkKLJXKWZyhZen2EHFywu9
	crehs47n41boU8C9TygXcKKEJPFe/LmLlRPUMWHu5YafVRbZxvwk/QtlK0vJStp6vNMC4TpmglFT3
	OUH7ur34lqOr6gUnm4KljMUUV3pXhn9671sUR3Nb1KyymPXhw7pCMx/J1OjWAlTVeuQ76PJAq+kYU
	0A8WoeWFQQ9ghwm9efKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gud8L-0003qk-RP; Fri, 15 Feb 2019 13:02:25 +0000
Received: from mail-qt1-f179.google.com ([209.85.160.179])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gud8F-0003mr-3o
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 13:02:24 +0000
Received: by mail-qt1-f179.google.com with SMTP id y20so10644831qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 05:02:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S07xj2waXpk4u9fhM6uE8vSunkZ79sh5tZ+KnlNea48=;
 b=jPN4igDUnd76B9DxtfvHhqp08/mcZlpGWj8FF5DVkki1ueFNkDeaptbfWowrd+ddWc
 PlpBYQxTr8PgCaxQ2zuIE3E/+sDKHCW60a44OMFPyeIy3IiDnTjYrRbD6VyYwicEbOD3
 BuUHD5hMzV1XOGbdK1pSGYbFjbQZYd64BM547MJyHBUE0a/9hL5XmGxm1IfGDqS1qTwz
 6L5TOefF/5ZWwVNmfpfuaK+KKV17xSt2dQLxPHSDP5CBgNe7FR6Ni0fD7egJr8t6Qa31
 ocQU1aUhJpheUVxJ4HTVRPkvYqSRoo1+a3B9Ncy8AIzoakPWb7dN8w3OQGh6TBBi0bcC
 lHPw==
X-Gm-Message-State: AHQUAuYg0evcTeXF7eI9aJUslEbDArCbYcmP31eSxc0fJEnTuNYV7TQD
 AWQk7jzWsMvSKuPtrH9g0uC9hX0UJdx6FWkT+YA=
X-Google-Smtp-Source: AHgI3IbhHvnui7ZQCFsZ0C6/Y6zmdc+Qt9Ej98gh9klpOGhj9URqiKAlz3BTu4SzqRMGJw23VwmQ4YeG/zk68ip2ACE=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr7123399qtm.96.1550235738048;
 Fri, 15 Feb 2019 05:02:18 -0800 (PST)
MIME-Version: 1.0
References: <20190201084533.12881-1-nsekhar@ti.com>
 <20190201084533.12881-2-nsekhar@ti.com>
In-Reply-To: <20190201084533.12881-2-nsekhar@ti.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 14:02:01 +0100
Message-ID: <CAK8P3a0ca02XpFWk2gEfvj0BStJyxh-xm+PczAe55rZ5FL1gYw@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] DaVinci DT updates for v5.1
To: Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_050219_149864_D5657619 
X-CRM114-Status: UNSURE (   7.54  )
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>,
 ARM-SoC Maintainers <arm@kernel.org>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
 Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 1, 2019 at 9:45 AM Sekhar Nori <nsekhar@ti.com> wrote:
>
>
> ----------------------------------------------------------------
> DaVinci device-tree updates for v5.1 contains a patch to enable analog
> mic input on da850 LCDK board.

Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
