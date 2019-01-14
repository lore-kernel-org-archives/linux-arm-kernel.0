Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57F8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:19:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E682086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RumZhdzR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VpLH4LRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E682086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+TOxjZNc41aZbasqciLkdQt3WqFd5JXeLz5KBRvSbEk=; b=RumZhdzRpS3Qm8
	P9dyq9odat2mDrzPkpH5F85B0j9pv3hAV/kgZEKWPAUlsGVMZMp9Fuv42YUA0tIpB76PeTRkGfreD
	tGld8qLWVEYzuR+Ui35asu/R5Q2vj4JvkmL3Etb+NUx10wVkfkjJvmTbSSTGwyYwXn77RR2slnkA/
	RuXPuchEezRUeb1U+0tpmj4fPPikK1swhrbNxX2pl8fiFzVqanLz73jtrOV0TJlqo0Shm+ConYbOV
	LikFZnEYV/QOWUpneoeMMAs4vFi8j+2NzlmWU3HMdeDpDDvHPKeRFLOJgsvDeChrBUkpjSaCz0QEZ
	bCIVjSf/MgTCN8jDI8Jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giyOe-0005zj-9B; Mon, 14 Jan 2019 09:19:04 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giyOa-0005yq-N2
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 09:19:02 +0000
Received: by mail-pg1-x544.google.com with SMTP id w7so9181266pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 01:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=NKxgYoIUcONgbn8ufUpcNn9ZL20a+ylRBVSbkZW3TEY=;
 b=VpLH4LRcoO6Zjsq8bpGf/7JP6fVTCBxALOVWuhGEtxgKz3T5nKIA7ukHbtJ/75a9IW
 5/Upibc1vEQGhsRT3EYFRcU/ciGxhG/qRQD7JyLRsUakBRgWYWQTCJjihPdY4dJcsUgo
 /4OWAd1+HFOAmFbr/vtoN8B1ckpaBuxHcb0Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NKxgYoIUcONgbn8ufUpcNn9ZL20a+ylRBVSbkZW3TEY=;
 b=Drp8N2qwqdbg+CnpdnmWhPu2MBL81OwxTaWmmesE1bPzmqCVV6GTmRBYV4uxrtXDiE
 tKonLTZHIJyIgKckj4sQbOvDH8QFJAXN4kP/iqJHQeqwM+VDoqwYkVRT2R6al21HLo6u
 kkVPa03gZidFXzw1yRA+9Bi22quX+oFBLyuyybL9wjsARHqCuXVhgKg5d8v3HIBfmBxI
 LxT5AN08U+mPQuVO9nxsK3G2rvz6kT9lVWRxGmAaJoDa5dKcbM9cpaUvyayqk/OuYcPD
 9q88RfsOYZ0fLz0AAzuJN5EGGpVUMEDaxqqrgNY+dA7aVdYCtMv5Udv6xyVhnS4VyXdn
 UKCg==
X-Gm-Message-State: AJcUukfZ89VTf+sd2dw7jeAWE3Y/w9UhEVOtIC51hnsV1sK2b6qIcTMp
 4sIloQUfDGtxDKkL7XQgKQLK
X-Google-Smtp-Source: ALg8bN4hHNIddDDH2wJowj13Ec3GzhUcCxPt7u0SyCRXCXQNXkASOZkydHFVl7H+jB/Yt6/LVH7b3Q==
X-Received: by 2002:a62:7c47:: with SMTP id x68mr24767559pfc.209.1547457539354; 
 Mon, 14 Jan 2019 01:18:59 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6306:f12b:7d9b:d1a4:6536:aa21])
 by smtp.gmail.com with ESMTPSA id l19sm191860928pfi.71.2019.01.14.01.18.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Jan 2019 01:18:58 -0800 (PST)
Date: Mon, 14 Jan 2019 14:48:50 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 0/6] Add clock support for Actions Semi S500 SoC
Message-ID: <20190114091850.GB13162@Mani-XPS-13-9360>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
 <154724706468.169631.2903523518830581075@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154724706468.169631.2903523518830581075@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_011900_745309_CB36BC4F 
X-CRM114-Status: GOOD (  17.21  )
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
Cc: devicetree@vger.kernel.org, mturquette@baylibre.com,
 linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, robh+dt@kernel.org, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stephen,

On Fri, Jan 11, 2019 at 02:51:04PM -0800, Stephen Boyd wrote:
> Quoting Manivannan Sadhasivam (2018-12-31 10:55:11)
> > Hello,
> > 
> > This patchset adds common clock support for Actions Semi S500 SoC of
> > the Owl family SoCs. This series is based on the initial work done
> > by Edgar Bernardi Righi. https://patchwork.kernel.org/cover/10587527/
> > 
> > Since there isn't any update from him for long time, I took the liberty
> > to modify his patches, address review comments and send to list for review.
> > 
> > This series has been tested on Allo Sparky SBC.
> > 
> > Thanks,
> > Mani
> > 
> > Edgar Bernardi Righi (1):
> >   dt-bindings: clock: Add DT bindings for Actions Semi S500 CMU
> > 
> > Manivannan Sadhasivam (5):
> >   clk: actions: Add configurable PLL delay
> >   ARM: dts: Add CMU support for Actions Semi Owl S500 SoC
> >   ARM: dts: Remove fake UART clock for S500 based SBCs
> >   clk: actions: Add clock driver for S500 SoC
> >   MAINTAINERS: Add linux-actions mailing list for Actions Semi
> 
> What's the merge strategy for these patches? Some are for clk, others
> are for arm-soc, etc. I see a sandwich of patches too so it sounds like
> I can't even take just the clk ones for fear of breaking something that
> the dts bits in the middle clear out of the way.
> 

As we did with previous patchsets, clk patches will go through your tree
and I'll take the ARM/MAINTAINERS patches through Actions sub-tree. Let's
target these for 5.1. Even if your patches reach first, there won't be
any regression with existing DTS.

Thanks,
Mani


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
