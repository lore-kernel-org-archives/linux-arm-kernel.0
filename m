Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDB1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:37:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986C221720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YE7iq3Ii";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="gV+UXuSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986C221720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HGhtJnbbCHxsoI9vQfbsCNOPL37pKT0+g+ldMw5H0PM=; b=YE7iq3Ii0Iqi7m
	ml8cZFm3gOf4yYMYc5z7ZrDgJn+j9ffo8zDZbVUyUEhgCxAgkkSLJq25ShMemqaVvNpaZgCs0Qg1i
	v6Ly5fdwUIFsZ0t4r6TGtju060/wTMu+L36rwcixy3csmANVm9qpXdo3FKt+4M4R9LPp7NJlY3wTO
	AFfhGl3ATrfdAy1EShqKJJvPpiBUVDKP5MQLoTV1EnshG3VoiOaVctqXCVN5AEHkRSjHNSr1LrObh
	rPjRgsg6GxuBOI4GxX1tUuSz9QY6OHAlMptgJ9VUGifbDlvogyQcmgw56Yfge93x8rialGAzxkj+j
	fMAsSIV8on+Tz+eaVrGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge5F7-0008NV-I5; Mon, 31 Dec 2018 21:37:01 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge5D4-0005nP-RC
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 21:34:58 +0000
Received: by mail-lf1-x142.google.com with SMTP id b20so18830597lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 13:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WnbZWoy2rLro01Dt+uigzbc8yjgcIx3mAJ25r/vZItI=;
 b=gV+UXuSqxUprCMrOB/fnu1urzK3z7FXrlbV83DBYuc3nXekfwgM/ABfteyaqzLNfpl
 BQqbbZ4e340QeXe2fsLd1XyFQxX7VdMVW8Yzn6ibn7R8cXiMgGoCvklzIGu81to9K9X4
 WR7UkljSy8REQmc3zkR1Hg9eKDxfhw0gOtzGDpG6gtTT4n5kApPCGSDe6SdrGLQVh3OT
 0VERp3h0K/O4n3S4ZYQYHTty5BSxKO78bjYD6t1RoMvhgns5ZmJK35AdwAfZwI3cuv9r
 7RIAS0M24BF/Kv/byy9OGdvKRCTSbXgeJa6bizD6ZKGXF8+yqMSUjorTcJv3L7NBpnff
 hKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WnbZWoy2rLro01Dt+uigzbc8yjgcIx3mAJ25r/vZItI=;
 b=IOZNGxfPrukPmdstMRyMPnoA02Z24fPX9z1Iluzy7UTJjtoFmVusD+gxduqF4UrKnl
 Dwbpgr0NeDMZSEYCxaQQaSs4WWbTzcgF33VWzN4zKJze64yWpewUkJVFR2+OtZ66N3Pe
 PB2wr/tO85XoA2OevTqfy17HBfcjJ9m5bZ2t/P5H619qMDEyyIEESovsBS6NeecDvABD
 bKJ2T0K09aI0OeI5N5Tj/jiHm3meel+3gRr+BNZxwcORBtE8isfNr+xa7m6lrIXd3Asx
 EJKW7bgdZuhjUchYWyU3QUXaEkx7aHxD+R7awFdXux1WBENCfYqkic+6JDINBLuVVYy8
 CU7w==
X-Gm-Message-State: AA+aEWY02O18JsWHAqUOD4oZiF4pnXDdW9851QyKDIrqRABBf5mWIAzh
 1W+CKqnmEDIinX71ovNgcCG7ZQ==
X-Google-Smtp-Source: AFSGD/X+JEwWLAdr4ezbBQoPRrEQaw3ZjR7oDFv0TgKlas91iD5MAtK1yFIHt6BqyebGPar1FvYC+w==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr20296052lfi.19.1546292092792; 
 Mon, 31 Dec 2018 13:34:52 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id d15-v6sm10336661lja.38.2018.12.31.13.34.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 31 Dec 2018 13:34:51 -0800 (PST)
Date: Mon, 31 Dec 2018 13:12:31 -0800
From: Olof Johansson <olof@lixom.net>
To: Patrice CHOTARD <patrice.chotard@st.com>
Subject: Re: [GIT PULL] STi SoC update for v4.21 round 1
Message-ID: <20181231211231.gtqe7lvl3nokdcx6@localhost>
References: <9459cb9d-aafe-b712-9c95-30b2ff979d34@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9459cb9d-aafe-b712-9c95-30b2ff979d34@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_133455_451855_29395EC4 
X-CRM114-Status: GOOD (  14.23  )
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
Cc: "khilman@baylibre.com" <khilman@baylibre.com>,
 "arm@kernel.org" <arm@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 20, 2018 at 01:54:20PM +0000, Patrice CHOTARD wrote:
> Hi Arnd, Olof, Kevin
> 
> Please find STi SoC update for v4.21 round 1:
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git
> tags/sti-soc-for-v4.21-round1
> 
> for you to fetch changes up to 704cfd7f5f71c6bc6cdfaa63a16ed0f72882b1a1:
> 
>   ARM: sti: remove pen_release and boot_lock (2018-12-20 14:32:15 +0100)
> 
> ----------------------------------------------------------------
> 
> Highlights:
> -----------
> - Following pen_release and boot_lock cleanup initiated by
>   Russell King, .smp_prepare_cpus and .smp_boot_secondary STi callbacks
>   must be reworked to keep secondary CPU's bringup.

Merged into next/late, will submit for upstream towards end of merge window to
get a bit of soak time.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
