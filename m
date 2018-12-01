Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41EDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:02:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B145F20867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C8fsAKAf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="qb3C7yAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B145F20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0Q+Kkfmb0iEonhM3mX7XcupJK1xvDeIp+JPikbhptHo=; b=C8fsAKAfA9mU8Y
	qUpRGkxyas98cLzogVqjXALq+V0bGVLafzLp23t3XaEhD1xxG8KrhhPmPNrI99Cg9/j2ueyueAPWt
	ifpIr/gttjOjY+doD8FtTQkjntfc0NYLT9qnYL7ctLOyPBVwqOTVzBWJhVq/RJmAosLrFSS28fE+u
	pcUoKnqKSVvD/gSxlZQsMrwo+rwExdG78OcT0Lc1LEhu0qtRhC48GYjWJC6kxGhue0sdk2WhxI7Qg
	ZGKtNXzR8xx9BbphTTZEekPpVGyjyExSBRwVxFIZX10RUeJGwmMfSVa+iBHQdzK4r7vkPAJ527idZ
	xEv9t1pDSh3beRLKO1Zw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSskF-0008UH-Ca; Sat, 01 Dec 2018 00:02:51 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsi3-0006RE-Ap
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 00:01:07 +0000
Received: by mail-lj1-x242.google.com with SMTP id k19-v6so6460843lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 16:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=nOU3GfuFFAcBmABFv3gNX6G3EYqrF4u+sfkYBqaoHcA=;
 b=qb3C7yABYNZCkIUZ6XOqo+f0QtUy/W/muH1tbTqWGMBCp3hrlr5QFyWYbuzytnm0OH
 i08NBSo0aAeSRYAWKAQUv1hKGfVexQVty+zhPwfbuc16g0GZ85OC11Q+quo1xiKtiz/6
 dtFf5ckgRHCDztQcXfMMgE7VWokoM8SfM/C2d4VUhEnwDclT19f+mz2peNsxhTQPOyOM
 6+jnIbkvXzQ3AJt1f9qxmISDSit8Qk9a7+anFlUlQlUCjRmPomIqYjw3q0hxUwNt2egp
 i40YH/QGe7hnVggeFDECzdCBpAUPFul25wLNHqvikM/bp3DvXJnLTCJBifq81nqRiyA9
 ojgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nOU3GfuFFAcBmABFv3gNX6G3EYqrF4u+sfkYBqaoHcA=;
 b=h+e9NDPEbKX4zRnHzdXUNdA9QXk235iENAKVNZ0W0rwpkW98WozcJHnD4aJ5ofBCzT
 NuBbnfKgniAWMRyWLitu3UQw8KHLmtB4yBDLPGw1ifQOW6FcOMJUb6wGj5QpvAChFbct
 EYbjRJZFCmlcuoaZOus9Wfy8T3nubAkSyMlBPRu3R5/ORTPLD/q0D3lR4ynF0yYU1Ojo
 blWn++Fgwm46ErSghi0Kx/cfo4Ag+rlXH9sS6ZY4dDo+DXwuE2l59woRON7SF944+3e8
 k5yNnnNm/OijSX7yp/S5XVeURKTH5hGzi5kXZqeHZuBh1z1kSVFeSvoHHo+dFW0Xp4ZS
 iQdA==
X-Gm-Message-State: AA+aEWYbZZPhdT8uHWJ22/FvJ0ZjwnP48M+xHSNIcQ2XNl1NtFrH9UkF
 oJSr61o0efAZ/hZBu/b+xnadZrLlVWraVA==
X-Google-Smtp-Source: AFSGD/WFbkSBo3GBQZQP1SUh/9a2T0RTCbcKuJEJyAcDfQs/GXsYGlqRdX0d1K+Imvw4KuB9dYasBQ==
X-Received: by 2002:a2e:2b85:: with SMTP id r5-v6mr4914402ljr.91.1543622423561; 
 Fri, 30 Nov 2018 16:00:23 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id p23sm1050955lfh.47.2018.11.30.16.00.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 16:00:22 -0800 (PST)
Date: Fri, 30 Nov 2018 16:00:04 -0800
From: Olof Johansson <olof@lixom.net>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v4 18/20] ARM: mmp: add an instance of pxa-usb-phy to
 ttc_dkb and aspenite
Message-ID: <20181201000004.jxm6kwks4x5p5ejq@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-19-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128175324.163202-19-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_160036_027889_E818EB1D 
X-CRM114-Status: GOOD (  12.31  )
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
Cc: Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>,
 Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org,
 arm@kernel.org, Pavel Machek <pavel@ucw.cz>,
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 06:53:22PM +0100, Lubomir Rintel wrote:
> This will replace the *_pdata.phy_{de,}init()
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - Squashed patches with ttc_dkb and aspenite changes together.
> 
>  arch/arm/mach-mmp/aspenite.c | 4 ++++
>  arch/arm/mach-mmp/ttc_dkb.c  | 4 ++++
>  2 files changed, 8 insertions(+)

Applied to next/soc. Thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
