Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860D7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:58:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52CB520663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FCpxrEmb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="HfMLbMEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CB520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KdayxDJwflOZdXqC0RD6NVn9tlHy8ywF271Adixsr90=; b=FCpxrEmbATsesP
	M0L3mgi2XqTgURadtTGy0ARd7ETnIr9PXiazP/axDU9VjzFQt7s6plyQeIsVPFjaCjO8qzWGj3I0D
	8Z2oHP4E8P6qULuPjYum6d4QQah0iu7o6kmYnz2C4ZlSdFQlURnX3cTd5FNfxuSmKeysQDIjVRucX
	JGmSXImxh4U1lZBV6wb/nBIpaRpTJu0dIYUTxPT1zD6OGgPVhQMrV3qZdDVPR7QN/xTYtQ0dCQo+r
	HpU72eLSxGr5wbx5x4iUIYAOQCQ9yKNdjnxsBQ7MlK7Eg0iQ0iqPBBm9WEVsDTTLLPfnW02ab2tA3
	3PpaxyR8hB1hvHdEO2zQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsg9-0003fT-53; Fri, 30 Nov 2018 23:58:37 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsej-00028R-87
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:12 +0000
Received: by mail-lf1-x144.google.com with SMTP id e26so5349409lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=doiXlpRHq2PK2qKLGk6Plou58jqVj+fSYIX210nUrYM=;
 b=HfMLbMEEkb0+GdiSBusuGScvHNzz6y5rlBLT/U2/6dG+W84qCXnjUw2Wh2V+Z904l/
 nT2QeWSGGcKZDnzTrXhQjUo5ymTKvPpeqMPJrUm+UgQl00OPGdCPohpxrNyOSd5r+IiY
 lWHs07VvV4ohi2WQTMQ+oJPHkD+1z4ZK/HTXgqn4JcN8TQODWmo11pX/Lqx0qREqZuoz
 3gwoHTcDSC2b1pfKavjS5UnmwpKNnuNd+YtuX1/42ExE7tWxP2Ll2Pjna35BpE4C1Wpo
 4BMErqGs4sxy9kfU16hw3vBIrT7Q73Wk3+1FD76wdeHs+BKhAPNfivVmeIkMVWVdaQaD
 D50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=doiXlpRHq2PK2qKLGk6Plou58jqVj+fSYIX210nUrYM=;
 b=TQzL8ikUZcxQ+v845pGvzuW4kXcPEgI7GSTkbokEZHjfqZvCtJ88WR+r5I7PjItWo1
 6V8OYjL7oLhQPcmw4Co71ZI7X0/ZhL5CNSmXFcJrl7gfcvb7mrfjbpzOnop1rykOThrd
 11TljH/MoqbTsJtVYdnW60xFIGci/s3vZaIZy/fyLFsmCOcQJvEjlUhMWsC48rWPmXyx
 jlgPm1WNuCY/6RoeaDv5iiQfr/N3yoDujXS9ZdMXqZZw9wSqeSNSHFfZBbl/mGmVSnZk
 Gbkpqb4wJOQS36vRt0lasoenvyz/m1jRAQ/n4+CZOTJXeSThsInJvddTJCuC6TAvhgBp
 6U/Q==
X-Gm-Message-State: AA+aEWb2XUdbHGDvYrW7zjvXZIFFk+uExA5DuofZkjuIxYsWLsSxB4yE
 NEOIhLDQUA3M3j5JnWTAp5ApYQ==
X-Google-Smtp-Source: AFSGD/Wp+WJtuq7xmuGnrqr8ZcPSvRc2v19zu+7wz5RAoluIUq4N7PfPQi2nykmPLT5wHJBD9LI3MA==
X-Received: by 2002:a19:7919:: with SMTP id u25mr4478666lfc.18.1543622216985; 
 Fri, 30 Nov 2018 15:56:56 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id t18sm1013524lft.93.2018.11.30.15.56.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:56:55 -0800 (PST)
Date: Fri, 30 Nov 2018 15:17:45 -0800
From: Olof Johansson <olof@lixom.net>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 3/4] dts changes for omaps for v4.21
Message-ID: <20181130231745.myseygxlf6oarfx2@localhost>
References: <pull-1543521343-338334@atomide.com>
 <pull-1543521343-338334@atomide.com-3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <pull-1543521343-338334@atomide.com-3>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155709_464850_57737766 
X-CRM114-Status: GOOD (  13.10  )
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
Cc: linux-omap@vger.kernel.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 11:57:42AM -0800, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/dt-signed
> 
> for you to fetch changes up to 0ec47be539e323ef4919fd63ea2f4162bf74892e:
> 
>   ARM: dts: am437x-gp-evm: Add sleep state for beeper pins (2018-11-19 10:32:43 -0800)
> 
> ----------------------------------------------------------------
> Device tree changes for omaps for v4.21 merge window
> 
> These changes mostly configure pinctrl for am437x-gp-evm. There is
> also non-critical fix for a comment for Clang, and we enable earlycon
> for am3517-evm.

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
