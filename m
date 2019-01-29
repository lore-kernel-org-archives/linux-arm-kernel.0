Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDF0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:07:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607CF21848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L1RoVjuy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aA0lz5/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607CF21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RePSXF6XkgK1G/Zq8qzlHn7f+0LyDSVnr9S0Q2g2Ifs=; b=L1RoVjuyEhQFs7
	4ClswTwBaFS3aH5+Yf3AEi49Tv5vJUU5EQhvExMQyNfhycCf3Sb2Y9HfzqoOTifBy4E760O1Tr0jc
	dBTNOahieJaufd9iE/SbQ7wF5NIxps3o4B4O/YE6jEgjgmzvUoM71+dyifXOk7piil29Ytw+GrF0u
	HKImb1EBmKJIu6oyxw11EmvM58VJDrw0+XF0hedBvxS/SMveKrKjDxLVneznAQD2HRxbPvxVx/OgF
	2iKsDWTXiisSDh8eypTwLbMwK8k2GRoLlHrX1+l+hiFeJVPEjODaFtxT/CqUujoXu3ZspMXUzOsDb
	q5FP6TtfoupYiwyt+xkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goXmz-0004Qr-FB; Tue, 29 Jan 2019 18:07:13 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goXmv-0004Px-BT
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 18:07:10 +0000
Received: by mail-wr1-x443.google.com with SMTP id u4so23153822wrp.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 10:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=NzDwDEgriwmCgRdcqLB9TL0tXHCXXVwXdPshYo2uub4=;
 b=aA0lz5/x4LFTqvA60ICnNMJoFbk39uJ7CnhkZYJOeb9pQcko04r2z8ek1EemQ/H7N1
 DUy0xRc7jeRdHJ/xh9wTj7kiZJdPNZElsZ+V07PNmqaHMoiEAZWO87U+2K8Bn7EV5FNE
 EuNgYshQBkNbbhTeKx0AOFK14Sx+r4G5w2+vPjpDkom9sVzpOEYuftscHANqhnIZHD1f
 xE8AtWvmRK1TYVbQ703NIGgw2zlj0baGYtivZ1NNsOVe2lQC2bE+f6p5ZsdwaBx9tAXK
 Z1pjWLVPX6Yy1lQ4iKc9hLMDuVYXAKSJEyAnugeho9MU9xZ4hnlFr29Rhmq27UR21i8k
 a3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=NzDwDEgriwmCgRdcqLB9TL0tXHCXXVwXdPshYo2uub4=;
 b=VkDqm2dfg79Y41vBgquk1040mtvkF5PuEwrqAW9tCNWu3HVXzBBhMyRbJpxwQrP/Ha
 p+9+VLeWE+r/ks0HXazGEXV8HcYxC81PBatR3f/LauUEcMrrnl9ohYmQ5v+Jdmi6Fihq
 G1xRl60adtL9pYj+sLuyeKZh20SH+BA3KsKfDxxvmx4JyGeBu/kl+Kk3Co9Bm16y/53h
 CdeIZpvQqvGuui/POBbsu0l/ilOjczUfmu2olf+XuHugXXMpXnXuETIPbu7KX+qPv+pd
 Wb/edtWOD5CTwfoK3hHPfla61lcDSHQWCr1w5IQgN3M67ACEUcl8SIFRPj1yszC3/sC1
 va/g==
X-Gm-Message-State: AJcUukeXfRung7sxE9869WNatzTLBZltZu8J7ehmxmjW0onnIoXgVUAH
 5oW8a60c+b61Y5e17RidOhI+Bg==
X-Google-Smtp-Source: ALg8bN5xbEoQ1ihFND9bwxaeig6iPfJJ+zuvOJCox2vVkZ+I7GSjseFGt4qud2fkXGXnmTOQMBeqZw==
X-Received: by 2002:a05:6000:108d:: with SMTP id
 y13mr25818527wrw.135.1548785227162; 
 Tue, 29 Jan 2019 10:07:07 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.gmail.com with ESMTPSA id
 j33sm192878674wre.91.2019.01.29.10.07.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 29 Jan 2019 10:07:06 -0800 (PST)
Message-ID: <f85275321c93c00494c82a8af19a70c229887944.camel@baylibre.com>
Subject: Re: [PATCH 04/14] clk: meson: move MESON_GATE to clk-regmap.h
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>,  Neil Armstrong <narmstrong@baylibre.com>
Date: Tue, 29 Jan 2019 19:07:01 +0100
In-Reply-To: <154878509992.136743.15892625146758066106@swboyd.mtv.corp.google.com>
References: <20190128180430.28689-1-jbrunet@baylibre.com>
 <20190128180430.28689-5-jbrunet@baylibre.com>
 <154878509992.136743.15892625146758066106@swboyd.mtv.corp.google.com>
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_100709_438840_2C861C4F 
X-CRM114-Status: UNSURE (   8.65  )
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
Cc: Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-01-29 at 10:04 -0800, Stephen Boyd wrote:
> Quoting Jerome Brunet (2019-01-28 10:04:20)
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> 
> And also make clk-regmap.c a module? Having any commit text would be
> good.

Stephen, 

As stated in the cover-letter, this patch (and several others) is meant to be
squashed with patch 14 of this series, keeping commit text of patch 14.

Details are provided in both the cover letter and patch 14

> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
