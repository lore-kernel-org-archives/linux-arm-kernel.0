Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94403C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:09:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C53217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OPZLTzG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C53217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QRd7eBVM1ftxcnZ/+xHqfEVpsz87bO5h3ZVDqENYRNI=; b=OPZLTzG+X0YwT4
	J2KT4g+ugVHxweOXBoSbpDIYZb+DoijC6CiIbGTS1w9lfHt6tRagjpewAqJoZ0y6Fx1ufVW72PLCI
	l/SQ1ecJuTinkY4pRsE6+6QPv+xMUa9+kr+Gt9yHhMJracHu70HJDykmuFb2Gdfu0WVHkaJZsO/0/
	lVk49qXXNUd6dtqODezopPz0Lje4ps3W4FkGxGzqRoqY4d4UDptqDS305PxoYO/LpnrBsQ+rowvnD
	UdMzRm+iGaykOtBYv1Chu9MHa51ieUM1xGyGUddNw8IdHb3xOaHVcU2Zi9hvmIeHHgxW/jOHEv6O1
	DNLi6iM6shlFrTtZRA+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvhk4-00083b-AM; Mon, 18 Feb 2019 12:09:48 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvhk1-00083F-Ma
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 12:09:46 +0000
Received: by mail-qt1-f195.google.com with SMTP id b8so18807790qtr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 04:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Rt8Onk5ZFIivNapcSYBDIp/BG20u3QyBL4v88MFsEog=;
 b=Y25jL9m3cOrcUEy7X+25N2RppyxI6tKVQakjXs20yT1F8A38MHQmOGmo7YDjip2YGz
 XGJu5+70sgyqr9VnvSjegpoCB4Jnha+ThIIEyfvTK9MZ932Ny+oY/N9ctWrJYTznlOHY
 HeGC+I8FNaEcHnYK9Hm0rBmDeLJW5srW/P3uYxMXAF92B+qauI9taTJoYDex8NJ2uNT3
 Q+E4VEHE4R5XPsYSCjVLs81onXRUQIk60Wtd7f3ZNjc9RQ+dkVUPi9dgVitoJpRsGa/o
 7gafF/bFW01PTWY/IOIoRtUvnFBq+HN91La10YQLwaiiu17ieeZuCLrZ4s23EZpwojjS
 qV3Q==
X-Gm-Message-State: AHQUAuYg2nYrO9E4k3u2looxMkxjcI9jl0VuP8g76V2Ikg5buK7Ao8dO
 h6qN3OaJDTVrUedaEiJ00HeDSY1/Iu5YisiqOp4=
X-Google-Smtp-Source: AHgI3IZ0H0QTGO2yfAXRK+DPKf1as5oE2i77Ox29VXi8tqA+s+QDSxx+jObbrp6qXqoWG80ldg63pd71KtD8FpcjdxI=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr17699767qtb.319.1550491784457; 
 Mon, 18 Feb 2019 04:09:44 -0800 (PST)
MIME-Version: 1.0
References: <1549628920-32623-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1549628920-32623-1-git-send-email-sugaya.taichi@socionext.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 13:09:27 +0100
Message-ID: <CAK8P3a15mLEgVAh1+jQ+GqOcQa0zhrePWofo8iGkTs5_bd=TmQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] ARM: dts: milbeaut: Add device tree set for the
 Milbeaut M10V board
To: Sugaya Taichi <sugaya.taichi@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_040945_741087_18069582 
X-CRM114-Status: GOOD (  11.62  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 1:28 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
> +
> +       aliases {
> +               serial1 = &uart1;
> +       };

Maybe start with serial0 here? It seems unusual to start
counting at 1.

> +       chosen {
> +               bootargs = "init=/sbin/finit rootwait earlycon";

The /sbin/finit argument seems user space specific, so you probably don't
want this in the dts file but rather pass it from the boot loader.
Possible drop the bootargs entirely.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
