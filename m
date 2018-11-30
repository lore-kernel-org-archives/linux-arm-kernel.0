Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB20AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:58:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F0A20867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K8aJywxK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="sdi3GBkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F0A20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RhF517vP7JhwDDWI6vUJgFwQTsxrLzXNZH0gsosoWCU=; b=K8aJywxKsooNor
	k5/Slrmw0zNq1yMHJwaGQviaaO77w9v/cB1P8gdA9bllqHEN1jFzNEHOeKp4QHFiFG4WQtFurXeR6
	P3IfjQH0gZ3WDWuSOFirVYwtgGkPQ3ETEH8DCThdkGQwmeUgDCsRR+PyFXL6l/DyDxDJKnxEVB3Fa
	hmMwXwZG3qXHNK5KTI10vf09f88S5MyG2J2icFCzWoq7rnf3h0FBrgNsJKo7h928Dv6jCsaH8eQYz
	3UAt/qGEllnu8UBiwpnGOt+t2nlchaoiy1UGMOmaRgG0dZo9tqFtN5zCy/+I35nsVM8RikGkIkVSn
	vWpk0i29KKV5NzgMjXrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSrjp-00058W-PL; Fri, 30 Nov 2018 22:58:21 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSriC-0003vG-SQ
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 22:56:46 +0000
Received: by mail-lf1-x142.google.com with SMTP id v5so5246598lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 14:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=V4s/27YSyocRRzFnTc/wh5m4dteVstvJFHgM8dnsjKA=;
 b=sdi3GBkW/WLsFkFmCV6GJrIIDLJ73JUzOVESTEfYK+v4vjNw+RXFczcGdGYcgNqKtL
 Bc4RoCX+luXBwMlXgLowVbfhXr+nuXF7vnQqAHm9xGzVMBT+TAUVleYzKQIUnexfJ5FA
 rIikeXZxX1KuPFjBO5l193J9u2NjSlMsVhaX6Rgi59f8uIxiZbT9Swn6LqQSuYrmACPL
 yp8veUUY9bMsbzF+vE/HIVyPgerxnfMXIwmw8LSV80IP0Hs2qG1ImCgM5G1tYkrXPDZG
 6GbZZwNPNlMjtpZv9onEPaM/iIY5wxw+PEVFUvHFuvk/G9hT7w72B+UJ4pHsUqe/7xjx
 0q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=V4s/27YSyocRRzFnTc/wh5m4dteVstvJFHgM8dnsjKA=;
 b=d0wz0tZ5o8uXeA7QeSoTnjaBDY6f+T+dXpFIJ8bCuqXU9AwBjH0CH8hT8Ww2PkAksI
 4f0c2uXz1eZyRQNLCKEYJhk8AdcuU8AT8iQzy4Vw/75XmPsu8r8da9mk44bOIonn6UA7
 6+VGyx55bsbfIo5+Dr/v2Q7hTNNNrtk37f7BOgLBOGH/gBPBVK56qP3WKCiASjHDLvY1
 k/cd0CQOgpNODyxTm/h+0rWHESYCqslqNuqesaakaXz4H9TivV149Tdg6GKc81ZiijZ1
 pXAmg0jJYDs6nRGCxSg1S50+aroWwORDFadYIJ9nNjX+VgvQh2oKdNIfI6ggNMNma6OW
 Lu2g==
X-Gm-Message-State: AA+aEWb4cjh5NdBle3fpo5JV8XR63e22b+wNKSs0yMWWY2/g3UvIUX0M
 duy7K1fvcKOc88e8yC8Kt+Gzsg==
X-Google-Smtp-Source: AFSGD/UFyUs6xrQAPoHpV5TjtiPU5r7yP6+Gz7AZlsGvl9jRsHQ6khjH3tSQaUbIDer5fG6MfiQ18A==
X-Received: by 2002:a19:d145:: with SMTP id i66mr4890293lfg.97.1543618588745; 
 Fri, 30 Nov 2018 14:56:28 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id g70-v6sm1018231ljg.92.2018.11.30.14.56.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 14:56:27 -0800 (PST)
Date: Fri, 30 Nov 2018 11:50:04 -0800
From: Olof Johansson <olof@lixom.net>
To: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [GIT PULL 1/2] Rockchip arm32 devicetree fixes for 4.20
Message-ID: <20181130195004.soz4sjyxhaodaug2@localhost>
References: <110221357.jpgQ0Qy0za@phil>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <110221357.jpgQ0Qy0za@phil>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_145641_370251_154C0E0D 
X-CRM114-Status: GOOD (  13.95  )
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
Cc: linux-rockchip@lists.infradead.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 22, 2018 at 01:32:04PM +0100, Heiko Stuebner wrote:
> Hi Arnd, Kevin, Olof,
> 
> please find below and in the second mail some fixes for Rockchip boards.
> Please pull.
> 
> Thanks
> Heiko
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.20-rockchip-dts32fixes-1
> 
> for you to fetch changes up to 672e60b72bbe7aace88721db55b380b6a51fb8f9:
> 
>   ARM: dts: rockchip: Remove @0 from the veyron memory node (2018-11-19 09:28:17 +0100)

Merged, thanks.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
