Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61DDC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:22:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9004220672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c7019LnP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="OyMrrRYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9004220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D9MtUCuTi7yUbMGoW9g+hjHCzy2Kvs9ou7y2jZ7wrsM=; b=c7019LnPtdO+E1
	LaPqePBgyptT5lhfBqhNRiUh9b3ZCikJGgLnBs8VD4B5s4lUibuii/EG38CeYSqAU/0/WCe0RfiPo
	C/6EukHoHVgzNuyfKvuXzNk7NfMZbto+YjlVwAT2P0F5WKQwcl3aRB0at8TmgLebffSfu4ESfSNbz
	rYatFtfID24idg7ubDn+gcaQvIS3z4oWxlNN0pzAQx5v1AOqKqq81qEk0hmMwqnhnj6BupNnNB0No
	+iUpyS9qfuGflRXuaqISoCL5EmacBJm2hyoXByzob6gUqrpDNgtdvzUqLds/5QdmdaFB9d8g0jOwo
	Z+yYg6+3npG7A3q35XGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCtw-0004wB-Hl; Wed, 12 Dec 2018 22:22:44 +0000
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCog-0007Xp-KO
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:17:20 +0000
Received: by mail-lf1-x12d.google.com with SMTP id b20so14737320lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=eUBVAnYpq35IL1EeuWkwtrZ/rJsLg7nCXpD7DRN7ZMY=;
 b=OyMrrRYz4ceeDpAkwB2fpyRdjaqDaFIx61wLu+vYbLpRecQWvpUSQwBipGCZZaYmyR
 xSDFjdS9L9Rh6PuPIjn8nWWSyRTJM2kxRFvDSxacc5TdauNg+jb3K3S48lmaYegEKYi/
 hcqsiDp2Fu0vzOIx06ancCRdWKPq42RgvWmKnj1omXmXLq5qIwESByqxfnhav2JFrCzi
 VY9hvUkMq1PuajuYMUejy593RK4nMqq0Xn+80BToAv3hRmJrwDLgcaNMeG9iqBBflWQP
 BWkGEPNfIahdvqU4ogg9UQWEQZjpmCBY4XhubBBgEbHK9VmAW1aYqaJWpzgDfBGZgcVp
 J/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eUBVAnYpq35IL1EeuWkwtrZ/rJsLg7nCXpD7DRN7ZMY=;
 b=Iiry/WHvJK4mSxsZd8YuD084l0gFKLDh4Qp8TgFYiA3ZHSt2YG3p/2RMseHrzI2Pdn
 s2aJEcV2Ha8rfTaABjuzHksAlINoUEFHcy8PJQxDKrMLMyINldb8a2qxkJ9Gu+z4XXfw
 kKWnw+Zdcpjs5TQSc0SXoAJ/hDfC9LnqQfuzEnl4m6xf6HsfSAGYVu2TPG4SLu6fVnau
 0btEKSdlqf6Tsnr2zdyeMPitMADW338BO7Cv3Lc/k8cGfUsESDv8tPl5eaEdTuzVI688
 p8QBuyjd2k9qoPJY5iYWrwiEMdITyJNa/M9xv2mVjqIhTWWa6MWxWWKtwEnZfjqMT5qM
 +JNQ==
X-Gm-Message-State: AA+aEWa3vRYfaaZHRVz2yshdks5uud9a0a0fikqNoHf4VUWMBoz8GvKO
 oZpFkZcunaks+uTjx7+AlfNyyw==
X-Google-Smtp-Source: AFSGD/Wz0NfSkrfNwMesjC8raQ1/ijb5KldzPta5taK3/ra/+Zt4rl5DXxvJbAOaUlpekIhEXh0wXg==
X-Received: by 2002:a19:f204:: with SMTP id q4mr13570988lfh.133.1544653026696; 
 Wed, 12 Dec 2018 14:17:06 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id y24sm5136lfj.17.2018.12.12.14.17.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:17:05 -0800 (PST)
Date: Wed, 12 Dec 2018 14:00:15 -0800
From: Olof Johansson <olof@lixom.net>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [GIT PULL] Allwinner H3/H5 changes for 4.21
Message-ID: <20181212220015.kx3igybyodb4y253@localhost>
References: <20181207145400.7wazz6nyppbzgprk@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207145400.7wazz6nyppbzgprk@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141718_666552_8FE2ACA1 
X-CRM114-Status: GOOD (  14.60  )
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

On Fri, Dec 07, 2018 at 03:54:00PM +0100, Maxime Ripard wrote:
> Hi Arnd, Kevin, Olof,
> 
> Please pull the following changes for the next merge window.
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
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-h3-h5-for-4.21
> 
> for you to fetch changes up to 8be5b161bb3d07bc5a119dfe0285ec05d28202c9:
> 
>   arm64: dts: allwinner: h5: Add Video Engine node (2018-12-05 12:03:06 +0100)

Merged, thanks!


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
