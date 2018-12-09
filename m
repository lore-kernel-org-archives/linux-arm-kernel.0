Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655DCC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:24:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3CF2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CgefsO0R";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="JvbBau9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3CF2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kLgODsjbtKshSFoqx0NCCclcdfFKEkF+JRfmMShWnwo=; b=CgefsO0Rs92IEM
	zvhSkZCj9JfaJULD1kWil8HLwCThuIE8QUeCMRBEhVrjVQW3Fv6sURXvPfAPdIYWcv/pE/eIXZBAP
	FPOgn14P1IGaBgDg+qPI+I9vKxFDMsH8Sy9wuJ4iGeN5e2NaHDRNOR043TnMnXA12LigjzKwU4gFf
	9J9R9iVzs4wT3G63vswbkkNZI4RsORIk8/jVXYp3MrHtxaWhvQQrR/+QDCO22JB0tSfAokVwomOc1
	ZSST/bLtr1F1fv4hLuBcxHfW6seGdKTB8Rn2jY0te+C16qVFyV8MKuCLvBoNjQWYEpE1rikzGYCcr
	ZO0lLBAB0rkp+BEljmCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWAJE-000088-Ca; Mon, 10 Dec 2018 01:24:32 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWAIh-00086Y-SE
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 01:24:02 +0000
Received: by mail-lj1-x244.google.com with SMTP id u6-v6so8111337ljd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 17:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Ra2xvFRBCQMgqVUXgWGPeXj7wiD49f0QGgSsWkKUrF8=;
 b=JvbBau9VzR1O24Lbvr2IHAlEOcKNKtgQmEA/jnoyWt9prqVQKu8vGqV46Nc2f6dT4j
 DPRUf92t6kdewQHcic/J7vexYwIJ+YCcBJUmwi9nfnfp7GrsTblfOMiCnBeZwZEd1got
 3SRhW0O5A9rCy+2QOmIvZEsbnoSyvaeCCWIS9ow4VuavQnJ2Pug10cTotnrnAhScbMdC
 foDKIzEGfHtUciy3QOP4kdlVHzi3GjEe1uZnY1Cw9MNschl+PbjQUHSsh4UwgSRXhYvI
 4LZ/751MS+kl9EMsoDbZ3EmL4IwCun0FYR0IXIgYHQBu1AW48UCI+j2nJbMXVPqNP71a
 RvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ra2xvFRBCQMgqVUXgWGPeXj7wiD49f0QGgSsWkKUrF8=;
 b=THM3yxMQrR+fS2yDY15wS3QKrsTHMWC1l8P5jfg18fPmGIVuatS8V+ojtFLVNc0jC/
 VqCMJAq9FMAIU0SiJR65rTP1cDHBNroqA2FlNkKWkHM+WHTi0I3SNSYAkboHqS1gcTCA
 s/lw/NnmtQ1tnjPuK8Iq3cujsPVJQzo6y87eK4x021tMgs4bGj5PgybyfGuWOHO0bLPw
 VzvFjtse8rDL0Fpnf7WBLkqbENxMwIGVJQ5gdlrKkjIyz1fVEGMDvdjXiAvjX1dCC58l
 wrss9oF7ZI4rM5orRxctfdeTQ99/EYzcNIhz5raQVts6MdsKlFkkcrMDa+Yj6mDYPxwl
 YLLQ==
X-Gm-Message-State: AA+aEWaPMDkL1QvLXNWCdp9VnQp4HN/9SNYNcTnWBT8Jon0oayDxbb9b
 4DJO+I8ClGLOvdcxZYVG1I/Bvz73q9A=
X-Google-Smtp-Source: AFSGD/WAykamOLJNVYXKwiUL8bcquJf13pih6PSTmOTR2zrnnR9YscsV36mdHdNehm9X8Ftn2Wio8A==
X-Received: by 2002:a2e:2281:: with SMTP id
 i123-v6mr5109597lji.154.1544405027828; 
 Sun, 09 Dec 2018 17:23:47 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id a2-v6sm1900799lji.13.2018.12.09.17.23.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 09 Dec 2018 17:23:46 -0800 (PST)
Date: Sun, 9 Dec 2018 10:27:31 -0800
From: Olof Johansson <olof@lixom.net>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [GIT PULL] Allwinner fixes for 4.20
Message-ID: <20181209182731.7um6fs7e3wcplzlj@localhost>
References: <20181207141819.3sg63se2pgbcaqgi@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207141819.3sg63se2pgbcaqgi@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_172359_917821_E31D87CC 
X-CRM114-Status: GOOD (  15.92  )
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
Cc: Chen-Yu Tsai <wens@csie.org>, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 03:18:19PM +0100, Maxime Ripard wrote:
> Hi Arnd, Kevin, Olof,
> 
> Here is a fix for the 4.20 release.
> 
> Thanks!
> Maxime
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-fixes-for-4.20
> 
> for you to fetch changes up to 5f8208f557065163f9a8089ea2ea7888f9d96922:
> 
>   ARM: dts: sun8i: a83t: bananapi-m3: increase vcc-pd voltage to 3.3V (2018-11-14 15:10:57 +0800)
> 
> ----------------------------------------------------------------
> Allwinner fixes for 4.20
> 
> One small fix for a regulator range on the Banana Pi M3

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
