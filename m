Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154E0C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:10:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D31CC20673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s2PZchog";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="BHNA5i5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31CC20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2CTDGGWklpsr0aw4KUBcMg9fEo2b3zTbohiQNHLwkbM=; b=s2PZchogA3YTo5
	RFsh/1JDtlDDJ+VARq2zQE9UWkzGVYTq3IG3akUCk6Peguhg+IyJlIGyH/OVWK0reNKwpZHGMI3ga
	qq2cLFOsvs9GoXn4Pj7Wn5B7ElxK6mvbd3cOldeo1DrFCpABzNkZcUfdbz77/9vwTDFNfalJWO/db
	/315ZPqVdpODeMWL/TjlL41dOK9T1ICAX4Q2+exvPk8Olo+yImd9HalXe8bEMD6sgKur7k6req+Hg
	F5REWznEsCzLdm/Nkpn39OkQdoyB3kR+2UXq/0xANRqHd+N2yk2yQVhfyTQB4dtAMZnP5sh/SROJI
	tIV33ozja3wEbPF2Jbgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsrk-0003gw-KC; Sat, 01 Dec 2018 00:10:36 +0000
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsea-000233-R7
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:07 +0000
Received: by mail-lj1-x230.google.com with SMTP id x85-v6so6494531ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=n4xrENvlA/4B3KIZNTtzEadisupSIPNb/+I3saFHdns=;
 b=BHNA5i5DCxeUjLTXcxWGwOuzX4aKt50Ia87VZTZ9Nw+f75YUo3bfBiSa4byJ7lfk92
 UQbcVn8vBfYxkwXQ2Z98FEAML/LjQ0LKbhv8n7go+lzVD8fLSc3E4EmJg3KdAlg8y9JG
 vF+RT6wiW2jXpNvuGpMMc5ualTUnXxwuSFoHXpz5WO4AkO20LsInNG6jDcC8jsNYAGKv
 9Gq+v2Aa360LKNbBDMGMMDXg/oSgMvaLIILv38StpMblGmOw89+4Adc3mcNJhZaiaAKp
 bQehHZEMjRUxg1IeETZZ9762xq5fSXzKI8CMEGR8S3yC88vlV02j51iSyjRe1ESpA431
 J40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=n4xrENvlA/4B3KIZNTtzEadisupSIPNb/+I3saFHdns=;
 b=CwWtXtM/0tBcLr/Rm73dOebwobGEbEJ3Ug8pJ90kULVlsnKiFwMJcP3kcaLndE/2eE
 VSxd0xlzMnk3/DlygW4rV2JIxejsn0x3FW0/bFM4uTSwozOJGacEOrJJsUu/CjXQ4KD+
 XWPWC4yRqaOQBqEw7+uG9Ub9GcO1eAxf3zA5YotSF1Azt7Q8C9ZsLOHMAF9HCpjcwH+0
 QisQYFkVhUNSjxjRhP8y2wKwewr6DjB7BmJFUEEkWc7fU6uWFm/hmH4egAHsmSgei17h
 wSVZQkovI1CKjPa787bt7TOsOVI32XB8CH0Fmt2qSYu6Tdi+BEplCsgRHZGL7FLz4dnX
 +5Ww==
X-Gm-Message-State: AA+aEWajqyXbor+a19sRWdvtHKh/0Xwc4eVkeOFJvNxsKbmLz9tlhu1a
 MUKJo5jrDECbGEDETG3gRrPNODD1dyGRyg==
X-Google-Smtp-Source: AFSGD/XGESYEoiSMLBI3+zero1ZNBGKpktxhcosTPUxL3FDYst456jKyP8D2iFKE2oqg6gaRzFO9RA==
X-Received: by 2002:a2e:8187:: with SMTP id e7-v6mr5144871ljg.50.1543622208588; 
 Fri, 30 Nov 2018 15:56:48 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id q127-v6sm1145761ljq.45.2018.11.30.15.56.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:56:47 -0800 (PST)
Date: Fri, 30 Nov 2018 15:10:17 -0800
From: Olof Johansson <olof@lixom.net>
To: Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [GIT PULL 2/2] ARM: dts: socfpga: updates for v5.0
Message-ID: <20181130231017.vu6rjwdxkdtmozl7@localhost>
References: <20181128154403.12872-1-dinguyen@kernel.org>
 <20181128154403.12872-2-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128154403.12872-2-dinguyen@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155701_436899_C76C1386 
X-CRM114-Status: GOOD (  15.59  )
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
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 09:44:03AM -0600, Dinh Nguyen wrote:
> Hi Arnd, Kevin, and Olof:
> 
> Please pull in these DTS updates for v5.0.
> 
> Thanks,
> Dinh
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_updates_for_v5.0
> 
> for you to fetch changes up to 8bb4f3f55961954154967d4747686ababb67df0d:
> 
>   arm64: dts: stratix10: use "altr,stratix10-rst-mgr" binding (2018-11-28 09:24:52 -0600)
> 
> ----------------------------------------------------------------
> SoCFPGA DTS updates for v5.0
> - Use SPDX license identifier for all SoCFPGA DTS files.
> - Remove dma-mask property as it has been deprecated.
> - Use tabs in DTS files.
> - Use the specific "altr,stratix10-rst-mgr" property for the Stratix10
>   reset manager.
> 
> ----------------------------------------------------------------
> Dinh Nguyen (2):
>       arm: dts: socfpga: remove dma-mask property
>       arm64: dts: stratix10: use "altr,stratix10-rst-mgr" binding
> 
> Simon Goldschmidt (2):
>       arm: dts: socfpga*.dts*: use SPDX-License-Identifier
>       ARM: dts: socfpga: use tabs for indentation

Tiny nit for future patches: We use ARM: and arm64: as prefix.

I've been meaning to fix checkpatch to catch it, but life's too short to
program in Perl in 2018. :-)


Merged now. Thanks!


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
