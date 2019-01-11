Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1423C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:37:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6555218D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IOyqVB0/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YI7mJhXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6555218D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=e3NOtTVy+28yJzbBgooUjW1vFjmDjO7BTknDdT0GD+w=; b=IOyqVB0/4uh27Q
	JTS72mKckxNo8nEMwwbk/JqnRI2r+lWHtOStywBGnhRlKbEUvFWQojyAZtR1p4iqVogPzPmRkml4X
	GPHX9pMR7tN4MahFdEOs6T11KlDxpD7B5/8e089Z68WmchaIIDywGgKpHLxYDNA4YosIVupDETrpj
	/axe6i3DUnv5XiHic9u+9JuBYNoADLhAChTaxk5jNpmTI5eyLT5GidtfHEEcnEARGOfDnWr+a0doy
	YdtJYUYR7vGSYJXibzIGBAIIsx49g2xmHPUig3oUZP1KyBeT4jMZdiT6jmH2XZZJcgoMRWGM5Xo3J
	xd92Sje8bE+qz6twIiDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi2c1-0000jl-Nr; Fri, 11 Jan 2019 19:37:01 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi2by-0000jJ-SL
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 19:37:00 +0000
Received: by mail-lf1-x143.google.com with SMTP id y14so11582890lfg.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 11:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=4pbV8yCzk3XiZ/ktSpZKMA5VtWzOBUVJbhXk/KdPJ5w=;
 b=YI7mJhXM986SuomNAFgEQFbYgoNdcOKxQnbN8zWzJGkZCk+AZbZDkwKcrQJRaAxaLj
 hPEdiPSFo6AaKHOsy6LG6XG9TI7tM2rL97Fqk443cVL9XIDt6uxz+RnRR6hBlnuE4KWU
 4HwqpPi0MjOJX4jpQl569HO5UAJzWZ0N8arFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=4pbV8yCzk3XiZ/ktSpZKMA5VtWzOBUVJbhXk/KdPJ5w=;
 b=oYWft86tvJzrvTbc/bfjmXnwbGYRE1qroBFd//9hTQRAqMIH+i4MRGrQERCqoObg3C
 OSqgDPYKYN9q2njfSwlkzzFJ3HGS1FmnD8SZPqHmwYCgHSAdJ7zKor48M7sy2lWXnhXn
 y1RMfApcqGMxpFiBS1E/XVVP8yw3/UxTP/8+Vue5ByNk/sDllSrswDoAi1RZhNfNz4Zv
 qvxlFBDS4vqP9zT2Hz9CMPvuYyWvAWcT/hWgPzkihdcUclCn42M8alcDnogt+OKGxjdn
 IQ/jsFGABdYjYe6P9lGkdGJxjlcc7bnavF7/+mRt3VziurItMpFXqgsXnZ2V+1JFBQGG
 1NXQ==
X-Gm-Message-State: AJcUukcQjMT8bO/EVkkza4ADsiJa7AtYyFk3PpivbWl/9oagmOfTgbb3
 82EbP8BU5WU9EAvTmkQq/45k8hBi1jaA8ULM8HuNzqK/jMAYJg==
X-Google-Smtp-Source: ALg8bN75svLWdZp/RW044gcZmlRoic8ymM6hHV0JAooC0ORhV+L3kHiY6NycN4Nk6I3qNtsaA2NbcI17/uDaemK5Bvk=
X-Received: by 2002:a19:5154:: with SMTP id f81mr9292717lfb.96.1547235416868; 
 Fri, 11 Jan 2019 11:36:56 -0800 (PST)
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 20:36:45 +0100
Message-ID: <CACRpkdZ-WSqRmL=J2LCEoU4dz1DrOTUwbF9tutVZaovEbat+qw@mail.gmail.com>
Subject: [GIT PULL] Nomadik defconfig update for v5.1
To: arm-soc <arm@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_113658_914848_B01B6DE4 
X-CRM114-Status: UNSURE (   8.68  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM SoC folks,

this is a defconfig update for the Nomadik. It is activating
drivers that finally fall in place in v5.1 so it is targetted for
v5.1/next.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/nomadik-config-v5.1

for you to fetch changes up to bf355705d7143b01894f60a713c5975bfddb7909:

  ARM: defconfig: Update NHK8815 defconfig (2019-01-11 20:15:08 +0100)

----------------------------------------------------------------
This updates the Nomadik NHK8815 defconfig adding a few
drivers that trickled in.

----------------------------------------------------------------
Linus Walleij (1):
      ARM: defconfig: Update NHK8815 defconfig

 arch/arm/configs/nhk8815_defconfig | 41 +++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 14 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
