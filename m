Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3FBC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:16:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6A120851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ezi8aKLV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="i/2jI3sJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6A120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aysWVqmBLttdhKD6iwfGCrjMIS5EUFuEvmNgMOtEmO8=; b=ezi8aKLVXV32B9
	tHH+J35Hetdid9GSNWQCKuHAGgusKIvgvr2B058A1dlcx03x8XjQcXB/tF9qMn+rEWEzdHduKsaqd
	WXba3Kkhnv8W54T1Nerw1Q87fbvsFuS6AoMJcwEihS9XAGpFWGwwfHK+5CiXiqbbCDU4vUtMfJuEv
	JgMepFOdIZ8687pjkwbVCkoPng+Me/ZeU3Whmbe3gQfnoz1e8y3hvAifBiktqYMnN8a9sj2EQ6rZI
	e4MzkbwuPDOnPpZ0j986uLwCYW563r0SuBFvaw/eNPN3nKti3N7D1KKq64ZDsXgWq2XLhypM3AYep
	qw64s2mH97TeGIw2AK+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCnl-0006iJ-Jr; Wed, 12 Dec 2018 22:16:21 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCnG-000641-Ut
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:15:52 +0000
Received: by mail-lj1-x243.google.com with SMTP id c19-v6so5037lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=UIm5TRrVoa5ea8S63TZGavOM7pheN/JLzJ4Mbff0Oco=;
 b=i/2jI3sJBXrGQDAe+5tGuRMSLZe7BRKv4pfRbFd2EI3zPb+I9fcHnmKDKApECz2E2r
 V66qudRK6hsKNe2RZXp2HlwCQcnVtn4A8xmqA395oB49Hm6eZm7CiXP8KSw0XBZjahkQ
 Caiq4DWU8dX8ZkKL+XkXKhzIv6Y1vV0zesztvOcN5E1WDO83+LdLwkcTJrq0wZLlQq0d
 T6J+h/o5SYLkDzXR52qtPwWHMX4azbQKcwscwHWCuO0hXtkB/6H0tyYF2QZuSZ4kcsVZ
 jp+sPXQIdByic8hBLqdIMHpVJvjaJjE6PIOPV2F058zB4nryLtrKV8lpccM+So+wTPij
 gHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=UIm5TRrVoa5ea8S63TZGavOM7pheN/JLzJ4Mbff0Oco=;
 b=Qc3suZUEYU1RAyjUBsx5rA2OE5aPjzb0XPE7aE5obJVryiRCNmXfZUsWSzdI3shfmN
 QA4ZAme0p23RNoBGp6ZOaH2xBwPWcGq7+54aTOWHebLk2xvVEgvHB6pGyQ7XckJilsgA
 EdXZenZeIHapAmNy9DuAm8RMTawFTxJ7wZeXlfe230MUxOP9sRdtuKHZ1vM7i69oUyJs
 0AzUxG255GEiYcZaGignXXeuUv75CIM8w4Yz0+6LFStzn74qZQvy9vd+cywJJCjsJfid
 hvWCGCVM1faGfL76/cpJm5UNDvwDVbyPcxLBrXCLfQuvs3qPLVz7X4RToa20gb7/VlVb
 lpSw==
X-Gm-Message-State: AA+aEWYrWOsOiPN2bxOc1riBdczLnS2ME/1uH4HllKjceFxHEY82DCuU
 t24V5NizHjR/ErZfddxyVoeLJw==
X-Google-Smtp-Source: AFSGD/XK9LsH740Kk01B8PN+IL/ieCufKDVHuIWM/veKC+qGNbdpbie1Ao20n+1X+BTq9/woK8emVg==
X-Received: by 2002:a2e:80d3:: with SMTP id
 r19-v6mr13371624ljg.151.1544652938937; 
 Wed, 12 Dec 2018 14:15:38 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id r27-v6sm825lja.65.2018.12.12.14.15.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:15:36 -0800 (PST)
Date: Wed, 12 Dec 2018 13:31:23 -0800
From: Olof Johansson <olof@lixom.net>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [GIT PULL 3/6] firmware: tegra: Changes for v4.21-rc1
Message-ID: <20181212213123.vv3vuut5bqyfps4s@localhost>
References: <20181207141739.9085-1-thierry.reding@gmail.com>
 <20181207141739.9085-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207141739.9085-3-thierry.reding@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141551_016011_4DAE1458 
X-CRM114-Status: GOOD (  15.44  )
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
Cc: linux-tegra@vger.kernel.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 03:17:36PM +0100, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.21-firmware
> 
> for you to fetch changes up to af51c25fb59d4365c259ab93f388462e0998a2ed:
> 
>   firmware: tegra: Use in-band messages for firmware version query (2018-11-08 12:49:26 +0100)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> firmware: tegra: Changes for v4.21-rc1
> 
> These changes update the BPMP ABI header and implement a new variant of
> the BPMP firmware version tag query if supported.

The header changes seem to be a bit churny, and most of them are spelling
changes in comments? It'd nice to avoid that in the future if it becomes
a frequent thing, but a one-off is fine.

Merged into next/drivers.


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
