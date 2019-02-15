Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C64C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:49:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118892192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eB1e8zEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118892192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PjCbfREsj349JHxdPym7GarJQKXg+pHAkX/59v+Kf78=; b=eB1e8zEcVj869Y
	6KqaY+qBWsq7z0ms2KGjAB0L/rNT4a+b02Z2rKVJ9tPSv8GWI5KnhpVo4JloOI1y+XlHqviTxPITb
	fP8VTIuCwQzQIrUokbUW0cDIq4UhNNJarf4xdD+//tA4OltErgcsI2wDrUB4N2+R+EiztA7SUywrf
	DnzFkfz1r+LC4WtZlxgHnZ90z6CZYA5ia7i4bL6nVgoUBSJTSWNzOTMlzssc6SNWYXyP2+rqrZKns
	RN9QxSDOJQZVpFYNBsAKNG8Q9GREQqmS9sEDyQ/Mm0ywtPAC9pC5AXjscauUDxMbTEqzi4BSUlvZ6
	/uts8Ze4wFSCB9/aNHYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufjz-0003Lv-I7; Fri, 15 Feb 2019 15:49:27 +0000
Received: from mail-qt1-f170.google.com ([209.85.160.170])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufjs-0003LX-Pr
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:49:25 +0000
Received: by mail-qt1-f170.google.com with SMTP id b8so11300802qtr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:49:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dnfh8CPwDVlA+I+SXiPa2DOiTS8jKElbqKpZEe0nP4U=;
 b=V5Wpzum7+kx4+DyRp3CggbIHARr2EisJy9Q5UGhAo3/d7Aw5s6efAsiawaMrtoLuCi
 3NXfqtdNUdq8CMvgnLuo4Vpj04Fv0EkKG4YshvO5Bku5G4jieN3UiL/ep4TskFfGKUSF
 EUER4KI8LlYoyfpls3wZr/AaDIfbDiLDBzMPuKpU0InmN5nERZVgkzApgBnTYnbdnTu7
 Ah9uTU7jvWWK3/iS3MWs+0KbauJ06WtImc3Ib+O4diHQOlVoPVBOleuu2XrT5yw+D37Z
 oTNQZOJZCUwvPWl/wJPY8uuDBGbOUZxHq/9S5oKlW1cB3LSK9yoV1f6yiOAm5u3LGjsf
 0c1g==
X-Gm-Message-State: AHQUAubmdU2ogtNlzO+MuvWVFG0L2+u09Jg/qlqet/hzrEp6al6cEH8j
 +57odCSOElkOjjte1YxXxNP/UAQdXT+wzFIqKu0=
X-Google-Smtp-Source: AHgI3IZmuWqWhKMJtK++1RgSiRfsI5Mnlf7svS8ccHiiE44HllQ3HAo1fsc0J6GI1nO46MXTFDpm/8/8qXf7F3Qwnnw=
X-Received: by 2002:a0c:e98f:: with SMTP id z15mr7840458qvn.115.1550245759750; 
 Fri, 15 Feb 2019 07:49:19 -0800 (PST)
MIME-Version: 1.0
References: <20190208150935.32108-1-thierry.reding@gmail.com>
 <20190208150935.32108-10-thierry.reding@gmail.com>
In-Reply-To: <20190208150935.32108-10-thierry.reding@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:49:03 +0100
Message-ID: <CAK8P3a1ze=SfAR7L-CLB--d_ngRXC7HGSxNPmXHThMrKecNqpw@mail.gmail.com>
Subject: Re: [GIT PULL 9/9] arm64: tegra: Default configuration changes for
 v5.1-rc1
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_074924_059243_288DB694 
X-CRM114-Status: UNSURE (   8.42  )
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
Cc: "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 4:09 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> arm64: tegra: Default configuration changes for v5.1-rc1
>
> Enables the TCU driver to be built into the kernel, so that the TCU can
> be used as debug serial on Jetson Xavier. This also enables the MAX8973
> regulator driver that is required for CPU frequency scaling on Tegra210.
>

Pulled into arm/defconfig, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
