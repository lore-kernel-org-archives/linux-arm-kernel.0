Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733F4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:15:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7762083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lkxrwhun";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuNLPd8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7762083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZTCPMay2u+J7AOM5Imlhl3f5Lxlvjry1t+3PLdmJTCI=; b=LkxrwhunY2t26Q
	S/NVI2F5NINsC35ebmiZhftPbFUi6fyj5Auz1MnslgGp4lBYO8LPNySClbQLtnnfFkEjOdSm2onfO
	L+AD/R4j0nDsCRJq/T4O1ZzsApjw/JhcaZaKw3WPup0b/RiyOAxDiSRLbRvCmcX6nmMEcWw3Qvh5U
	lovCIOFI+Di3RCIsakv1sJ4raUQvq1vQE7ZDxAAnOxAOT2O1wtzPW+i24cGph1B2NscDry86zELvq
	d06vLBy3fPw+L7u+H00iduc/QMrdNhZaYp85LrO7cNVK1XDjbyT0EG0i2TPvVlMtch/IjzpNRTAMz
	GA2cNv56ybt/X5rvL4Pg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyj8S-0004SP-La; Tue, 26 Feb 2019 20:15:28 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyj8Q-0004S3-Ak
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 20:15:27 +0000
Received: by mail-pf1-x430.google.com with SMTP id a3so6750738pff.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 12:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WP6DvkVKwOLwO6Tw1PILQXbrpy/q83TaLNSLgLd6DC4=;
 b=LuNLPd8oWeP3D04NhZt30G5aPfktxfEOqFsIie/GmmoSu/92unFx1MbHleYUws5ToU
 vaC/H7IOXBjnyiUqkQgbpoeUq3JN2Mp9/wuxOfJvcBudD6gUtFk2ZvdHuHd+O6R5PIfI
 j6jfPosTppNHVEHCUypdlDldguVXoyWjeGbrpFbf983f49/Jft1xbT33EoJH/M4Zximu
 jz2xdffX3hD3tYyKtNir+s3viwhgCGQzcrBXlumW4W5Vuv/KrmNNXRht1mO4IbNXuI9G
 ZXHqBu5PsKACIdiOGTi/EuMv3j/imD4CAZQjq/23wcIY4MpgIRhIgiPIhxtWUeCX8xuL
 9a7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WP6DvkVKwOLwO6Tw1PILQXbrpy/q83TaLNSLgLd6DC4=;
 b=dIkYvqciLgyA7i1NIfD2Udkvj+9y6dAIH06RpLwG8Fb9leV2rljy4kh7w1f61sjcMB
 ZGF++wEPmaRK5UcLznAwD8sm31BHgOONZETKMeEHrsmZj44YDuPBSGXk2P02ZEVnGsm1
 pMwgAg+2LWeb4tO09UC3X/Odw2MNLO0S9tLS6wYXf8/6OB4Z5iSckhxLaCHfMvB8H2CX
 B/HxLJrE69eOqOldziT3X3JsG7OazZ9P5C6d3PlKnMpAJBfVS05c1U89r0eyDWHLKg1p
 u7YDD3B9YRsmpSSJzoFmNCnnzWCjqAS9SsbewP/XPRC4OvJcGoIvPFSROkRWvXkrX3xo
 NS2A==
X-Gm-Message-State: AHQUAuYXlNuhGa0lbq6Q0cclRRjQyC8J7QuAFwGJ3VAIBbV03Ezm1f0b
 0IVkIEB/a6FOG6VUTuazHeg=
X-Google-Smtp-Source: AHgI3IZ2MGPXHPrrZe4U2HmrXm+GtnQDOaSL0PvfMzLMtUP9E5cXZcktAc89IjLw8UfBeeWGqQbcNg==
X-Received: by 2002:a65:6491:: with SMTP id e17mr25935585pgv.418.1551212124431; 
 Tue, 26 Feb 2019 12:15:24 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id q86sm36539802pfi.171.2019.02.26.12.15.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Feb 2019 12:15:23 -0800 (PST)
Date: Tue, 26 Feb 2019 12:15:19 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in Linux next with dma cma changes
Message-ID: <20190226201518.GA3205@Asurada-Nvidia.nvidia.com>
References: <20190226200155.GE39872@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190226200155.GE39872@atomide.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_121526_397307_7CDC7830 
X-CRM114-Status: GOOD (  12.49  )
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
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-omap@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 12:01:55PM -0800, Tony Lindgren wrote:
> Looks like commit d222e42e8816 ("dma-contiguous: do not allocate a
> single page from CMA area") caused a regression at least for
> omap dss where we now get the following error on init:
> 
> omapdss_dispc 58001000.dispc:
> dispc_errata_i734_wa_init: dma_alloc_writecombine failed
> 
> Any ideas what might be going wrong?

It's probably because the dma_alloc_from_contiguous() call in
this path doesn't rebound to allocate a normal single page.

And I guess we should have left the change within dma-direct.

Christoph, do you agree?

I am submitting a revert first.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
