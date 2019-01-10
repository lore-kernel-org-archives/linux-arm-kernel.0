Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AC9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:25:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A279920651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cedQUStz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIJpWIzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A279920651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jvtNNFwDXeCVEk5G0GO5Z4Dj4X/F0OKjzk0sD3WsDRE=; b=cedQUStzUnl7dz
	EOk27GCuAs1rhnZJkOFIn+GzlwijobhjUBmZeHlEiNbaFNSnByRY9VR4X84i5BU3Hc8S172jOGu38
	RcLOZFSa2TpSR3yLIoLABoTIgud0jRH80lWvQNR/ElmTC5AGm1ldUPsUV5ITKjdyDe5LLVBanPn0S
	rPyEJwP+9N4DKTJr3x74O3YJk+BJGaTKFgcaOo4bu5gisyuOj6vWbjNzaV4ztFd4rFGTqCYIwxaAb
	7tvlXA9oq1ZjvvW9/VUsmDDYpSCBG03WsOoz1vNfD3/tn+Mo75pFRWVMoV1LAYTaFYMXfFMqkBO9I
	dyoYBLsCPybX2lKS61Nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghfxS-0002UJ-5L; Thu, 10 Jan 2019 19:25:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghfxN-0002TM-9o
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 19:25:36 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8B8C220651;
 Thu, 10 Jan 2019 19:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547148331;
 bh=/vR7LskhHHSTMwzevIJBqkXpkfEf+ABm3ogsIzBsb7A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fIJpWIzwCdjQEVAZMDq4Sh4f4Spa7TVjYDR++txQnfi9dt8G1NrWTnSCC1pXE1Wz6
 kCe+BtkENC9yf+/aKLqxIFroKdM6mQkex7hzm3e0NGbrPp1sFTNuX1cpuQgZqf74Zd
 ZQFaqlTSB/hfEdogklntQVSZCa3sSBn2T1IPHfBc=
Date: Thu, 10 Jan 2019 20:25:22 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 4/4] drm/atmel-hlcdc: do not immediately disable planes,
 wait for next frame
Message-ID: <20190110202522.10206f2d@bbrezillon>
In-Reply-To: <a31e6514-1643-9e47-cbb4-3323183fd370@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110151020.30468-5-peda@axentia.se>
 <20190110182904.5efd08f2@bbrezillon>
 <a31e6514-1643-9e47-cbb4-3323183fd370@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_112534_319680_5DDB93C7 
X-CRM114-Status: GOOD (  19.58  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 10 Jan 2019 18:51:21 +0000
Peter Rosin <peda@axentia.se> wrote:

> On 2019-01-10 18:29, Boris Brezillon wrote:
> > On Thu, 10 Jan 2019 15:10:48 +0000
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> The A2Q and UPDATE bits have no effect in the channel disable registers.
> >> However, since they are present, assume that the intention is to disable
> >> planes, not immediately as indicated by the RST bit, but on the next
> >> frame shift since that is what A2Q and UPDATE means in the channel enable
> >> registers.
> >>
> >> Disabling the plane on the next frame shift is done with the EN bit,
> >> so use that.  
> > 
> > It's been a long time, but I think I had a good reason for forcing a
> > reset. IIRC, when you don't do that and the CRTC is disabled before the
> > plane, the EN bit stays around, and next time you queue a plane update,
> > you'll start with an invalid buf pointer.  
> 
> It might be possible to clear the EN bit in ...CHDR before enabling the
> plane in ...CHER. Or is that too late?

I think I tried that, but I'm not sure (BTW, this change was done in
bd4248bb5e8b ("drm: atmel-hlcdc: reset layer A2Q and UPDATE bits when
disabling it")). Anyway, I'm not even sure this is still needed now
that atomic updates have a wait_for_flip_done/vblank() in the commit
path.

> But this patch is not overly
> important, I just wanted to avoid the resulting "black hole" when the
> plane DMA is disabled mid-frame. But disabling planes is probably not
> something that happens frequently and will perhaps not be noticed at
> all...

Okay. Other patches look good to me, I'm just waiting for Nicolas
feedback before applying them.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
