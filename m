Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38C3C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:48:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C186F20666
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S5oloivc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="A6DRZnkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C186F20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z1PuYJUpVtYnqOUwT4qvlwJLsPwr5HluBPb9n9qIPNg=; b=S5oloivcKgLHFQ
	NqO2Soh4LVst2LTwTCM8/aYtfcQ56scH0rmd7FgPpzCbyACVvv6gjeAFMdD+K+i9ov/+718Sz6gtI
	u2Bd3JNNXXSgJy0qdzU9elawFF4CQFi7hliyMTxPRqvpEQI6wA53ci33eht6mUvizP+E8S9tjddTT
	KTq25GgNWu1cFJEi8AgwMd3+p3YPvKv/E39Qyfivipi4ZAKhvNTryIgR8PfUuYUmIuNE8gI7d6wTU
	+h8hoDfQkA0P4ywDSJVgXFvOQT8Mj026LS2J7Q+/1JhLb8hlIAIODTIh0+7L2U+cWI8jqwHF+DaqM
	mKevhNXVFbTGdHqzX2xQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTv93-0006XY-2s; Mon, 03 Dec 2018 20:48:45 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTv8o-0006GY-Ro
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 20:48:33 +0000
Received: by mail-lf1-x142.google.com with SMTP id p17so10264568lfh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 12:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mT2ERbSIRrRVqReUx2Q5vxI18oG0O2xWER6AZszkAEE=;
 b=A6DRZnkBQzAxL+IJ2hFIA6oLqt1lyap6Im65sck1mCWIwvv+BEw45JJnRVSFHHmc90
 Q52yHv1Wdg3Ga/QVnAbK8M/iy6O+Dg03+bz8xcTu6PsfXJ14UhUbvVg1DgR6xb1FPIuL
 8frgQfc4kM8bq8jXcIVWt9s9BJPBwGb8DFL9pOqxLCSXFrwXazHKcPJA1CAXSrnHfolQ
 jBE+P9cJ8+66yAdNdd/GFWu+C1kRHqG2xCydwHCNdLilYy0JH3vLIc4JyhqZTYodYyQj
 sbhbkiHI6r4oe99THgjXFjZhbFXhAx/59JQxARwQYIzYqY7XNcNpecJhkdqPIIdGVFKz
 JSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mT2ERbSIRrRVqReUx2Q5vxI18oG0O2xWER6AZszkAEE=;
 b=g0MsRaVqzobpTzsqRF8R0I4XCOWfwXyhsSgJeRaptct6JYYqaijPJaAdcSkfBugJ2o
 l2twk3c/yP56lECpjUOdOF8Ne1dtEX9GkpWPv9Q4FuAdCjtEoGAMcnvtSDkEbCa7aaDI
 WC1GiQUnrUc9fdkiEsWVa6fPVYIw+iT2cOKluoHEqHLi1S0mxxaLejvhRKeaAkyBZXix
 uoEflceAJKebSADDw+EDP/rhTAxUM8NDW0C6rcMfa+xbTsyVlXkokNMkfG53HjUdEZ8m
 5Zn5VIqL7kZrrZGIXOpJ5nTyoiX97NR3pabbFO7gEMVt4fli9hmy9eDrWUQcQ2KcLLjg
 v+Bg==
X-Gm-Message-State: AA+aEWYCsRrgjY16d5ddT/Cf7Y4L08q8WiBDAIxywW17C82S+ay2a2vR
 wGV7OTos5wv+++l3CLIsmmk4FA==
X-Google-Smtp-Source: AFSGD/UbRxjNrUXEiWypn/MLcXdAwGfdni5q2Z0XHTRRBXcyVdOR/6eQOJWEz+B+C6x5xqTV18wsIQ==
X-Received: by 2002:a19:4948:: with SMTP id l8mr2383785lfj.156.1543870098599; 
 Mon, 03 Dec 2018 12:48:18 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id t9-v6sm2688277ljj.87.2018.12.03.12.48.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 12:48:17 -0800 (PST)
Date: Mon, 3 Dec 2018 12:38:24 -0800
From: Olof Johansson <olof@lixom.net>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [GIT PULL] arm: mediatek: DT fixes for v4.20
Message-ID: <20181203203824.xsxgvoluw5wkouw4@localhost>
References: <d131fdd3-663c-9a5b-4296-94f2635f8c41@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d131fdd3-663c-9a5b-4296-94f2635f8c41@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_124830_899981_DC3E67F8 
X-CRM114-Status: GOOD (  16.78  )
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
Cc: arm-soc <arm@kernel.org>, "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>, Ryder Lee <ryder.lee@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 26, 2018 at 11:34:38AM +0100, Matthias Brugger wrote:
> Hi Olof,
> Hi Arnd,
> 
> There two issues with the mt7622 based boards in the current v4.20-rc cycle.
> Could you please pull the following fixes for the issues.
> 
> Thanks,
> Matthias
> ----
> 
> The following changes since commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6:
> 
>   Linux 4.20-rc3 (2018-11-18 13:33:44 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
> tags/v4.19-next-fixes
> 
> for you to fetch changes up to ce68cc6fad893eb33b69ef7ec186233a51696236:
> 
>   arm64: dts: mt7622: Drop the general purpose timer node (2018-11-26 11:19:19
> +0100)
> 
> ----------------------------------------------------------------
> DT mt7622:
> - kernelci awaits a working stdout-path.
>   Fix the path for reference board and bananapi-r64
> - general propouse timer has issues with clocks that didn't
>   get probed early. Delete the DT node as the timer isn't
>   need, a ARM arch timer exists on the system.

Merged to fixes now, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
