Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E567BC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:16:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1EB420851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qWfyzB3u";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="JbrW9wpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1EB420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LBJhA2DJPtCWIpppZAjqZ7LiEWV1PZCKz3Dz7SJm2a0=; b=qWfyzB3u/XTnuj
	WUVXaU4E0fk+3olwVw3Sd3gq+M9MGo7yT/ugvcb7YMFOYoYGrmhq+3/gJOkxQmCLVsTAXTXcb1uT+
	SSPg+godC8cAThdqbOegDO0b0CL95n1hEOixXYJ2X6XccOACyr5hg8eCQXwf6KuKanolIzPmNF2Al
	o4JWeLW3CLQ6VAqRoiIu8X5OVU68jKGeFNtJt29ooOkUNCvhkOm9ukN/ZRyCtTgwB+nl3ZCnvpUch
	I2gRn/xV5IRW4QxDZHYz7Sf2FhQUCwickfai+mY5Qn9YatNoYGoSrVsK1ENoBvKYxUNUYmE5NYNLP
	m5KIGTfue9KAvTPKbhlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBrz-0007o9-6Q; Wed, 12 Dec 2018 21:16:39 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBqW-00050q-JH
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:15:13 +0000
Received: by mail-lf1-x141.google.com with SMTP id p86so14667497lfg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3HkVUwkO7mSE5UKMfNW+Ny/9ELdxA2fRG0WljPCDgs8=;
 b=JbrW9wpuqkNyC5aWMhkJFKRZKlOzfVwvz+u7NGVAwjnTBSmWAAmpqRusj/aWNk7uDZ
 sLLc/9Hak/gc9ghM1NOL2id3gVU6LEHwmVp+EE0zHL1tGb5zyjbzL/r4VE5YS183Yn+B
 dX/dOrgw47QAWvsJmFFGcrFq5A1j87xHAYaWwSpqvx23dX9kjUApzqJO10Tis4KB1U1Q
 RJFbJsq0XeDdEEgRoUd2WMtn94j/0eE21WrdtQVEGTyor3jvwu69ZRpwla8gaF0/0QpM
 /9gJhOqzbjHEYNmaOCeEyVJDI3Cg89Kz2Ow00m2N88sYaplAmGrw83IH7D7LWSx56Brn
 l/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3HkVUwkO7mSE5UKMfNW+Ny/9ELdxA2fRG0WljPCDgs8=;
 b=GK8Xcrxv7hinWgnhxLPDgTHGn1N6ACb+bJMJzQhWllW7QnXcU2JP8/woNMDAv20uVf
 KnoP8Pk+JqX9Eh0NFvMwUPSqe+hm4t+WmMmBSy80KyrGdZu00cI1vJ+AdbFkEd8LEgXz
 XSaOUHfF9+ECcGlscLDhz1H/0CqHKv4pD476334+lFpfx1V/q6C4qcxtqG1kuBJ7WmWJ
 xibdHYPEw/D3WsggYuie2FP/ydmEkF/BY7VzyfBZF8Lq4RbBZ+/DnpeBK1f+rG2TKR2X
 n0Q5FjJv3xCVimMaFmvetljYQNk3d1+9lSlYaV8ohhXDEfoyAvqufHsvXpnGoLrVYJXX
 yRVw==
X-Gm-Message-State: AA+aEWa9bxIepi/wXXe8OtRw1e0yUorwUOHIJ2t6LZGMXouOabOSbOau
 6J0pqFvNuLm5o+lsKMiwMrMoyA==
X-Google-Smtp-Source: AFSGD/Xfi4Ba5L7+c6qHbuOPCnA78nqHN9nNp8AgqNAtuKn33MwOUeLl0cNEf4pVBN3w5sRFeS4syg==
X-Received: by 2002:a19:c18d:: with SMTP id r135mr434830lff.59.1544649296487; 
 Wed, 12 Dec 2018 13:14:56 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id r29-v6sm3329487ljd.44.2018.12.12.13.14.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 13:14:55 -0800 (PST)
Date: Wed, 12 Dec 2018 12:53:18 -0800
From: Olof Johansson <olof@lixom.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [GIT PULL 3/4] arm64: dts: exynos: Pull for v4.21
Message-ID: <20181212205318.tyfeilorpgfu6qbd@localhost>
References: <20181209114911.25194-1-krzk@kernel.org>
 <20181209114911.25194-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181209114911.25194-4-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_131509_075960_B37B5313 
X-CRM114-Status: GOOD (  13.49  )
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
Cc: linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, arm@kernel.org, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 09, 2018 at 12:49:10PM +0100, Krzysztof Kozlowski wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.21
> 
> for you to fetch changes up to 9deffb5ee78e41e2a5d6c448874a24caec6467d0:
> 
>   arm64: dts: exynos: Add all CPUs in cooling maps (2018-11-18 15:18:42 +0100)
> 
> ----------------------------------------------------------------
> Samsung DTS ARM64 changes for v4.21
> 
> 1. Update DWC3 hardware modules to Exynos5433 specific variant.
> 2. Update cooling maps to include all CPU devices in multiple DTS files.

Merged, thanks!


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
