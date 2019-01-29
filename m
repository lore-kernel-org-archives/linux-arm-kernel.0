Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F25C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:55:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0523214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AgrHGDTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0523214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=frB+I+Ye33iJHI+AEW/j5dRddsSoDVyi2AR6L/eHlcA=; b=AgrHGDTh4AjVlz
	XPz58Snp8CXycH9/0nu6mCJBWMxmZ7UfU1/FCsFPuzgXJrnRrcoloEHGcWN/ELpgC7VtXLKaUbpvD
	h3IiKz+7qRotClykPgdrW0CCrS28tTIojEyua8jz/pmE+TBFCdu5yzPZRyCbwyqvmyp2UhMxuBKGm
	C2daHx639W4BDRPeOjonkWO/b/G9vf9YgfrmZC7+eI/0fmv6OZbVenVIve1rfNLbO1UXPzs2WJF66
	c1/dDIEndofH1LxcEI5fsiqxeegTOj+7UdGErC9R3NDbYHWINgqkpZSVyf1ebScY+gItlA0jwh+wW
	rAFU6VZ7r1qfQeJkehzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goWf4-00062Y-BV; Tue, 29 Jan 2019 16:54:58 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goWf2-00061x-4U
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 16:54:57 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 18B71804F;
 Tue, 29 Jan 2019 16:55:04 +0000 (UTC)
Date: Tue, 29 Jan 2019 08:54:52 -0800
From: Tony Lindgren <tony@atomide.com>
To: Yizhuo <yzhai003@ucr.edu>
Subject: Re: [PATCH] ARM: OMAP2+: Variable "reg" in function
 omap4_dsi_mux_pads() could be uninitialized
Message-ID: <20190129165452.GB5720@atomide.com>
References: <20190126063221.8257-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190126063221.8257-1-yzhai003@ucr.edu>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_085456_214178_D7EA66E0 
X-CRM114-Status: UNSURE (   6.14  )
X-CRM114-Notice: Please train this message.
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
Cc: csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Yizhuo <yzhai003@ucr.edu> [190125 22:32]:
> In function omap4_dsi_mux_pads(), local variable "reg" could
> be uninitialized if function regmap_read() returns -EINVAL.
> However, it will be used directly in the later context, which
> is potentially unsafe.

Thanks applying into omap-for-v5.0/fixes-v2.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
