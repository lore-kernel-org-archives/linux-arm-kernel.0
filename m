Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B83C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:31:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD5F92147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PjhUYyuj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tz1tjGzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5F92147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HXaTm53noJh8TAP2qCwd7ABfnvKZuZd3o2LDXsLe4gg=; b=PjhUYyujwxFgpe
	AZgQoi1S/sABjMsS70jO7BLHLOMRKFa41vO6EQs8k6zWTDZF3M/hUes2v+SFLKk4qom5f4Ocls/yJ
	y9PePo8HwzXHrWCGKQ+UIUMVbv1MMAB9zaJAiJTXnnVGcNyCrvjaeV0q3WxE0lQvEpRaUmpmblygt
	PzKwIgbDFn8wMGFxT5Oj8rhiCBV0EBNiQaSwYMKTi4AAtqcDgCLM+i82plZhBjG5+UyhcH3LwP8Mo
	+42ITHrSVI5gRx8LwAqIFsEKfwu4N1EkjgJTfTEaJtXrYsFQVBrU3+0L//Y1n1lZ3M7R2EJn7fgrL
	18ZG7z+0PJir7SMcr3eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwldA-0002ho-4B; Thu, 21 Feb 2019 10:31:04 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwld6-0002hQ-Uj
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 10:31:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ro6rtSWkeFE2MpIF/M02/1Mvd90anfjg0yuc3frVIjw=; b=tz1tjGzbyHMwdd6iEJZLyOG6l
 Vuu1qMT4eW8xM430BnaANT4uZIHiHAGX32wGL3HDaXZxk6Tn11ntVbfVE29Z2oxABKhS+I3YXWiXI
 ixtvb3936J55Z75DS6RIAo7ZIhW6hHziuU4cCUSOrOjIqRYDbJtqxKR92zP8ctlRxrc5e1JUG6TtC
 baePQ9bGuokRPAgNDXQVVpTJzz7490h3oPpnKLUmz6geILaM5xuYS1SEFKGC7jNJTHd24WRVBFHJW
 UD+iGgmYCbcYtAsl094hE0IVbx1OfZ5J9gWqXq/Gbgyb+YKtUwWOQRLFYQCgM+AFjq+BC7ckcRU6g
 WN/Mz3EhQ==;
Received: from shell.armlinux.org.uk
 ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:36974)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gwlcw-0001kv-Sm; Thu, 21 Feb 2019 10:30:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gwlcv-0001HR-8m; Thu, 21 Feb 2019 10:30:49 +0000
Date: Thu, 21 Feb 2019 10:30:49 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Ludovic Barre <ludovic.Barre@st.com>
Subject: Re: [PATCH 0/2] mmc: mmci: add quirk property to add stm32 transfer
 mode
Message-ID: <20190221103049.tspc5igoe6wmt3jd@shell.armlinux.org.uk>
References: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
 <20190221102739.cc37au6elqu6gvfe@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190221102739.cc37au6elqu6gvfe@shell.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_023100_987410_A28D9F84 
X-CRM114-Status: GOOD (  17.50  )
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

On Thu, Feb 21, 2019 at 10:27:39AM +0000, Russell King - ARM Linux admin wrote:
> On Thu, Feb 21, 2019 at 11:10:49AM +0100, Ludovic Barre wrote:
> > From: Ludovic Barre <ludovic.barre@st.com>
> > 
> > This patch series introduces a bitmap of hardware quirks that require
> > some special action. This should reduce the number of boolean
> > into variant structure. 
> > And adds quirk bit to define sdmmc specific transfer modes.
> 
> Please find some other way to deal with these differences.  As far as
> I'm concerned, introducing a quirk bitmask such as what was done in
> sdhci is a complete disaster and leads to long-term maintanability
> problems.
> 
> We already have a way to deal with variants in mmci.

... to finish what I was saying ...

and I think that:

        if (variant->blksz_datactrl16)
                datactrl = variant->datactrl_dpsm_enable | (data->blksz << 16);
        else if (variant->blksz_datactrl4)
                datactrl = variant->datactrl_dpsm_enable | (data->blksz << 4);
        else
                datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;

ought to become a variant function call which returns the appropriate
datactrl value.  This would shrink the amount of variant testing in this
path, and also means that going forward we aren't facing an endlessly
increasing number of tests here.

> 
> > 
> > Ludovic Barre (2):
> >   mmc: mmci: introduce a quirks property into variant struct
> >   mmc: mmci: add quirk property to add stm32 transfer mode
> > 
> >  drivers/mmc/host/mmci.c | 11 +++++++++++
> >  drivers/mmc/host/mmci.h |  9 +++++++++
> >  2 files changed, 20 insertions(+)
> > 
> > -- 
> > 2.7.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
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
