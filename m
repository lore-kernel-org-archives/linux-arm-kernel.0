Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E40AC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:43:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7E32054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZwRHpaFh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hjQQCXZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7E32054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lPY45pJCiVSNwtONo1jN6VTGwRnn/gBiLc9tWN1jasw=; b=ZwRHpaFhZAlrNF
	CLm/NLuoikeo55k5YL/I9SuZaFZv2h7DqMx5w5Fe+kyXOqKJxX8Wv+/ZxkLH5EqbNxPfTuaIS18H9
	9JY7I7Z22dyxc9M6RymN/GaA/a10MHgegKjjHCub1q/xuF7ZMwA/RR6p+tW2b/MVaxuFOOgI5B6jC
	fvoKQHqUuSKfzf4j8xB12IJCvTWNhHjvP/GHZ0xk3o6xxEs59JaRxSy9xrR0AnImMwm2hdfb4kCe9
	ClfZ7MEPWB4Z1bfy6oo49C4fGGol7TmbqiItc0+2+X1h0nPcFWGmz1544pTaVx8yhm1AL3kyFIxLy
	cysc7jpzwfw65x89JiQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWjFX-0002oI-CJ; Tue, 11 Dec 2018 14:43:03 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjFS-0002ny-3J
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 14:43:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VsJjnyGFPMxouCaXHNYZdRwo7s95JdxU6otSl52Z03E=; b=hjQQCXZyA13mO5Ye8cJW5m96n
 qWncJ77bL0l06WpxwGcVZKqTNEnoFArwLAI6JRp3wyMNWifitdrbPQfzwZrgnLp2UMBGj6EP1FiOU
 xNPw/7xNR6YZZWB3hdLtUbsa/ct4+H2KRaBQllif36tdubvO40PxMnLSuhxqZrxmPhaMQ=;
Received: from n2100.armlinux.org.uk
 ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:44934)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gWjFB-000785-0w; Tue, 11 Dec 2018 14:42:41 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gWjEu-0000di-5K; Tue, 11 Dec 2018 14:42:25 +0000
Date: Tue, 11 Dec 2018 14:42:13 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] mmc: core: Lower max_seg_size if too high for DMA
Message-ID: <20181211144213.GF9507@n2100.armlinux.org.uk>
References: <20181031155738.18367-1-tony@atomide.com>
 <CAPDyKFqtMHRjHsJXcKTTzGYSsyab=2SfWdYiETS4Bo2f7Zw2CQ@mail.gmail.com>
 <20181129191332.GY53235@atomide.com>
 <CAPDyKFpgOjr1Zp=31b-_+KVOnvRnXXdXt5e8b0X1pGNVAihtyA@mail.gmail.com>
 <20181211131336.GD9507@n2100.armlinux.org.uk>
 <CAPDyKFr=vqNh+auGXjYJs+oq70+VksuOJNF7cFm-VifSKf6f9w@mail.gmail.com>
 <20181211134937.GE9507@n2100.armlinux.org.uk>
 <1ecb5b44-92a9-cf05-cb5f-eabb1f3b001f@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1ecb5b44-92a9-cf05-cb5f-eabb1f3b001f@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_064300_677597_9AAD4A8D 
X-CRM114-Status: GOOD (  26.04  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Kishon <kishon@ti.com>, linux-omap <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 04:33:26PM +0200, Peter Ujfalusi wrote:
> Russell,
> 
> On 11/12/2018 15.49, Russell King - ARM Linux wrote:
> >>> The only thing I can think of doing is adding into omap_hsmmc:
> >>>
> >>>         mmc->max_seg_size = min(mmc->max_req_size,
> >>>                                 min(dma_get_max_seg_size(host->rx_chan->device->dev),
> >>>                                     dma_get_max_seg_size(host->tx_chan->device->dev)));
> >>>
> >>> to limit the maximum segment size to that of the device _and_ dma
> >>> engine's capabilities.
> >>>
> >>> Doing this solves the problem for me.
> >>
> >> Thanks for the suggestion - it sounds like a reasonable way to fix the
> >> problem, at least for now.
> > 
> > I don't think there's any "at least for now" about this approach - it's
> > not something that the MMC core can know about, because whether a driver
> > uses DMA engine or not, and how many channels it uses is completely
> > driver specific.
> 
> I agree.
> 
> > The only questionable thing is around the dma_get_max_seg_size()
> > interface, but the only way that's going to get solved is to eliminate
> > it entirely as it isn't a per-device property with some DMA engines
> > such as omap-dma - it's a per-request property.  That also means
> > killing the check in the DMA debug code, which isn't going to go down
> > very well.
> > 
> >> Do you want to send to patch or do you expect someone else to do it?
> > 
> > I'll send a patch once I've checked the corner cases, and whether
> > we should go further and include other DMA parameters from the
> > dma engine.
> 
> There is one thing which I'm trying to figure out:
> sDMA (and EDMA also) have limitation on the length of each sg segment.
> 
> To make things a bit more interesting the limit is not in bytes, but in
> number of bursts:
> 
> 65535 * burst * addr_width = max_sg_segment_len in bytes.
> 
> We can not set this to a static value as depending on the addr_width and
> burst it can be different for each transfer.

However, it does have to be a static value as it's at device level,
rather than per-channel or per-request.  If it is set dynamically
by a request submission, it could vary wildly depending on the burst
and address width of the last request submitted to DMA engine, and
so the parameter becomes meaningless.

Consider what would happen to the value if we had one channel being
used with burst=32 addr_width=4 and another channel also being used
simultaneously with burst=8 addr_width=1...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
