Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23195C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:49:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8CDD222D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kd4/oEhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8CDD222D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ybPmDsiFr2G+2TWhbWCDsKhm134IkLJ+P2q9BakAn9s=; b=kd4/oEhqPGgPJp
	TJ0Z4EpjtUKM37MQvRRQHSDzfqnMsMELgkpIAaXgx8fcYBa70XBBP3JK9VPklsvx1frTdnx0MFoYB
	i00jX1W6wlR678omQMhkK+oGCxq/MDqKI087gA6rkt1JWGT3KpeZGxuDLyFBV7ZribrZ8+qSjfZCe
	KhjweJ583DM+OFLRALiignxLoo5PihCz1k2p2Mj9m39QL32KGiincvWswEum/xaIpNNBaDs2rv6gp
	A5C6GDjvsKjsV34Qh7AxHNS5eK5SkI3JwTIA73GyjTQHvrxhGRb4zzWOjvZIuCXZ1Ae/0IlqLtk2t
	KxjKeA2r1UhMvEXzfi1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gujUj-0003wP-E8; Fri, 15 Feb 2019 19:49:57 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gujUh-0003w5-4a
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 19:49:56 +0000
Received: by mail-qk1-f193.google.com with SMTP id o125so6453682qkf.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 11:49:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9GMVSspIzrSgyXNu5N95apPXMYodL7K9ulajQnobBJU=;
 b=DkfuMXrp46ELqyd8g818ifjlXdoYZsCm42QM6QsudlIgV7nC62AG+0iVL8flZlRM7k
 68+2zCrpwDAaJBnNj2ZnaRFzv0TnskqAvfKqnZeeYwtLqyVC6NZrL6l3HQsgnp6DNljj
 xzfbuw4vgDKvX+256bgqbagpDWebyz1JSzfU1GleoZar8GUiHJGFaV9CJukfvddB0FI3
 5kxV3KhQOWIXWXfdZwWamUMs5eSofE7MKO3zTH7xZUuVAFdiqBuG2nRp96LC2WPjjmJr
 vBepHCA95Ft7lVFCvLu99WJYM+ZY5l2r3fmykqR2NKKWk2LVAVi73u9tH5kvEtp0jjGz
 vZKg==
X-Gm-Message-State: AHQUAub9lxEKHdh4UBPO9A60uLWAfPW2JphLocBZ1ZbjbUDo96rXjPy5
 rNZwxN7JFsd5I+jASdH/d53fHMotClO+AOZQlag=
X-Google-Smtp-Source: AHgI3Ia2n/UA17maD4OJJI7T17uNF9nRRgDZrhjosPH6ZTrrUgH72gKhsrCJQzhM6rNl9csoIU56Mf85QuiblH2ahRU=
X-Received: by 2002:a37:d492:: with SMTP id s18mr7902361qks.343.1550260192263; 
 Fri, 15 Feb 2019 11:49:52 -0800 (PST)
MIME-Version: 1.0
References: <1550258500-19904-1-git-send-email-andy.gross@linaro.org>
In-Reply-To: <1550258500-19904-1-git-send-email-andy.gross@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 20:49:35 +0100
Message-ID: <CAK8P3a2XgWtUDV3dZpELVU5TRHgnkNQOuLS_=yhs=8=_XLw-3A@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm ARM64 DT updates for 5.1 - REVISED
To: Andy Gross <andy.gross@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_114955_177050_412A93B2 
X-CRM114-Status: GOOD (  15.33  )
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
Cc: Kevin Hilman <khilman@baylibre.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, arm-soc <arm@kernel.org>,
 linux-arm-msm@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 8:21 PM Andy Gross <andy.gross@linaro.org> wrote:
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-5.1
>
> for you to fetch changes up to 08585d21de9875a6064b350957faa0460a4c69a6:
>
>   arm64: dts: sdm845: Fixup dependency on RPMPD includes (2019-02-15 13:13:51 -0600)
>
> ----------------------------------------------------------------
> Qualcomm ARM64 Updates for v5.1
>
> * Add MSM8998 RPMCC, I2C, and USB related nodes
> * Add MSM8996 rpmpd node
> * Fix typo in MSM8996 pin definitions
> * Disable MSM8996 VFE smmu to fix security violation
> * Add I2C, SPI, rpmcc, uart, and WCN3990 wlan nodes on QCS404
> * Enable SDCC1 HS400 support on QCS404
> * Add a multitude of nodes on SDM845:
>   SD, UFS, USB, LPASS, SCM, QSPI, PDC, DPU, videocc, GPU, RPMh
>   bus interconnect, WCN3990 WLAN
> * Add gpio ranges to SDM845 TLMM
> * Fix regulator load on sdcard on MSM8998-mtp board
> * Add thermal trip points to cpufreq
> * Add SDM845 IOMMU info for SDHC, USB, and WLAN
> * Fix MSM8916 clock cell argument

Looks good now. I ended up using the original branch I had with
your earlier pull request after all, and then this on top, which adds
the latest changes and fixes the build regression.

Thanks for the speedy respin!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
