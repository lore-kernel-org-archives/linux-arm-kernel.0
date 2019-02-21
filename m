Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230DDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:28:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48F420880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O0E4rnJy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rW/GpLyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48F420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2A9Fi25eQPQq7QcZ7Lv1xfD21/BXvWUURa5uRTWo/1w=; b=O0E4rnJy1YNyoy
	z6J/NyMD8NpawPKEEM5dgVkSlZbB5FjzwRjN+qRzzy3uwgr2Z1xmcwfbfUj7EZHNeE93CUI42DxYj
	V/B+oQMQ4FJBEaieI7t5Uf30I9eUx7m9SBL+8lEhzyrvUWJstPotFkvnXudRphazmjA6MmUX3h5HV
	wfbDCwE2iO0D5B7UwdAKi1GDyAvjFPLqkaVp1nK992mOQYVasK+4gH4ZDriUgbTcNZa9qtKE+UWXM
	EZPVQF7nIemO68i2CdHsReIbFevrpc/rQlfEUmCoCwcGXp5vkZP/MJSZBPrvBJoskzz19g7Dq8l7R
	pAh4NNoiszQ/LE+mEwyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwlaA-000134-74; Thu, 21 Feb 2019 10:27:58 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwla6-00012Q-4g
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 10:27:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2JaQ1PlJuxYqC6O7MhBRM+XSftOK69SiRyCGOTj0M3M=; b=rW/GpLyy1CzueMsETvh0Zm0qE
 svcRP8s79ytpYQXpymfIgjMs6hW22joHJAxIoTHo6ESMiIOhnV7CB9a/6w2TdpqoPlWWE+TJf+E5P
 n1glSG2c5INVDgEdKYAm9nrVfSl3+zA4gvtfMHPkDK+MU5MjAHMidIoWtsNdA2rkedCWvHN3MAxH8
 1bXqdxmtXEVN1rLp9v+lqFsQ4/y2VBiagkbsHKzNQcnmeuJiNANs/6JBTW3MFrwy6WC+39IXiRhKL
 lVA+6hWjxnO2J3W/ElOsVQqQEKI7i+Dvv1rVB9Ys+3GI3dg8qLFARZ3SSobAelGRbJNcyhaTwwTw6
 tIbwZJ/pw==;
Received: from shell.armlinux.org.uk
 ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:54670)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gwlZv-0001jk-NA; Thu, 21 Feb 2019 10:27:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gwlZs-0001HJ-37; Thu, 21 Feb 2019 10:27:40 +0000
Date: Thu, 21 Feb 2019 10:27:39 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Ludovic Barre <ludovic.Barre@st.com>
Subject: Re: [PATCH 0/2] mmc: mmci: add quirk property to add stm32 transfer
 mode
Message-ID: <20190221102739.cc37au6elqu6gvfe@shell.armlinux.org.uk>
References: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_022754_381359_74944FA9 
X-CRM114-Status: GOOD (  13.71  )
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
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Alexandre Torgue <alexandre.torgue@st.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 11:10:49AM +0100, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch series introduces a bitmap of hardware quirks that require
> some special action. This should reduce the number of boolean
> into variant structure. 
> And adds quirk bit to define sdmmc specific transfer modes.

Please find some other way to deal with these differences.  As far as
I'm concerned, introducing a quirk bitmask such as what was done in
sdhci is a complete disaster and leads to long-term maintanability
problems.

We already have a way to deal with variants in mmci.

> 
> Ludovic Barre (2):
>   mmc: mmci: introduce a quirks property into variant struct
>   mmc: mmci: add quirk property to add stm32 transfer mode
> 
>  drivers/mmc/host/mmci.c | 11 +++++++++++
>  drivers/mmc/host/mmci.h |  9 +++++++++
>  2 files changed, 20 insertions(+)
> 
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
