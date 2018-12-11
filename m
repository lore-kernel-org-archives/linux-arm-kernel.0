Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173F7C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:29:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCDB02081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K69GkMXA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="nCIhPgIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDB02081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BOo6lF8a1UXdzsaqasR5Abn+Ynx8B3YjG/IQMf88EWQ=; b=K69GkMXAxhWdah
	c/BitY03VX200WRqk5rrtcmHA03Hj6ZwvyBb6PeeLh18CD8A7fXcBf3zjHRD/RHQCOhp0AyxrWtgj
	NJTrmJcdRXGg/vfi2M3wYUw96KDqw6jSF63uc5UubLVrKWlAkf5VwifBzJKoH0OIeeYX0i8cFri8w
	0v34wa2bo5pHs0bavT4lJSFdjlbID64jRwZhlxBy1YeZjYcndxfKEKE1Lw1VFg7YAc0JuAMF0SIgG
	pXVkU1cQPcTV8WQXrVAzcY7FHT5vwWVCAYjz1zBcmxmhzuNmKcLwC9NVsmS3NxIRmH4C8+Ybh45Wc
	cf9Yd1VtILgBMxWYeoTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWku0-0004Z7-Db; Tue, 11 Dec 2018 16:28:56 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkeI-0004Sh-Vn
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:12:44 +0000
Received: by mail-lj1-x243.google.com with SMTP id u6-v6so13479095ljd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 08:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wdU7ke9Dvh41iBCqKp3P/+2DY3W9EeR1YjO35mWjBrk=;
 b=nCIhPgIud6hydjTrDw4YHoU5+7/d/IQH8++pKLn6twy0brs67UZes7/FSNauY7Akib
 cGc3eo7k6ufleYTNizporEGNXKPDu8tyahQ7wcmMG2K1Vz3YLyYBZv3uVJHs4m9M7j19
 T2OYWvK71w62K3JnMnUFLDBn7T1XGflLFhkjf/Jc4l0K9D6r8QmWxa/1FnuQKWKTnUBU
 DaiOussU2rs7TWzKjbqvy6R4GDr9gy3CyAbxfT9Q/KX9m5+lQw4NyMoOdj4l/yn5AgBS
 Xon0jzIBMedza6m9x8q6lNMTmjx7O20Dq7FLZKPb39s31ev1dKJjEJrteFE50Lzp3wUj
 9aHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wdU7ke9Dvh41iBCqKp3P/+2DY3W9EeR1YjO35mWjBrk=;
 b=nu6Q9gHeqHTIH+jy/D5dkN31drNLgXIgcM5Cx7DcMjMRSfCGcrZZ04B3IzvWyrdFru
 Koc8iYKdCCEWL1/kf2QTL5HYu37QWLEmZ/90U8EQvDiAZXdmDmpQOcSXeKJfjHbDW4lq
 GFzYVVaj7vXW6GUbSxFseYU6z+PJkf/1x4E5LrZFTfexAdYFBp8zd7gt/APzDPULsWTb
 Et85ZJ9LTF208CnVmqV98sw5gOSrmIsoReCc8aMm25k155FaW9ZDK63gaKuZn2eCIOjS
 eWMKq3ldUG4pOwmHMvtXZQhJti7G5J15x0Dh+ssKsywDDQAybl8+MRo+e2rAyb/bCo0w
 dgeQ==
X-Gm-Message-State: AA+aEWZ+Wd1yfUU6JFIUj1twP64nxezOqDQNRj/gGs9hjN4YYO6ahhFq
 eurp9ofLy9aqyFz7GHys24uqcw==
X-Google-Smtp-Source: AFSGD/UThbtoFSE/LttwugNAocW3cYxIjQpTrhejmbtBF1lvj/8M5Y705tV1nx/1BwLmqPPFs5/PEg==
X-Received: by 2002:a2e:b1ca:: with SMTP id
 e10-v6mr11237802lja.16.1544544751251; 
 Tue, 11 Dec 2018 08:12:31 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id 4-v6sm2719707ljw.84.2018.12.11.08.12.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 08:12:29 -0800 (PST)
Date: Tue, 11 Dec 2018 08:06:20 -0800
From: Olof Johansson <olof@lixom.net>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [GIT PULL 1/6] dt-bindings: Changes for v4.21-rc1
Message-ID: <20181211160620.ktqyixx35cjvkzj6@localhost>
References: <20181207141739.9085-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207141739.9085-1-thierry.reding@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_081243_021051_9C14CF6F 
X-CRM114-Status: GOOD (  14.52  )
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

On Fri, Dec 07, 2018 at 03:17:34PM +0100, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.21-dt-bindings
> 
> for you to fetch changes up to b4c7bf003cb57220af64b59e887581e74f0ce527:
> 
>   dt-bindings: tegra186-pmc: Add interrupt controller properties (2018-11-28 16:42:58 +0100)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> dt-bindings: Changes for v4.21-rc1
> 
> This contains a few cleanups of and additions to existing device tree
> bindings, such as XUSB, EMC, PMC and thermal.
> 
> ----------------------------------------------------------------
> Dmitry Osipenko (3):
>       dt: bindings: tegra20-emc: Document interrupt property
>       dt: bindings: tegra20-emc: Document clock property
>       dt: bindings: Move tegra20-emc binding to memory-controllers directory
> 
> Jon Hunter (1):
>       dt-bindings: usb: xhci-tegra: Add power-domain details
> 
> Thierry Reding (2):
>       dt-bindings: thermal: tegra-bpmp: Add Tegra194 support
>       dt-bindings: tegra186-pmc: Add interrupt controller properties

Small reminder to keep commit messages consistent.

Merged into next/dt.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
