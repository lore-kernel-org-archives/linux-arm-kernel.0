Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD20C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:45:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8928D217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nwDacWOr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DNE2olsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8928D217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ywi2qsIkZhqU1yNH2W7sFSRHpF+NCzcY2wV/yFIcZ8I=; b=nwDacWOr2gpwgi
	KNdAj1kJgfE4m9jotR+HG3vuHnG2fV94Cstmijlf9mBClBOvYdbJHmINJplew33kgQRd+wjMqmyQm
	v5sHKpRRP6DMtah9dA0u+ga13Rp4JXCv0P0xT2JdvR504YHsU6HDPcWsaU+zjZwIQgdLZ2BRAVOpG
	90oH/GMfj7Hq+E0Tnf+fmfIt6Zp6JtZgDwC9lLYmFerr7tnW8grI4MPb69Pu+7QPYqrjHu7CM8YeX
	6bwdCAWFzd817naoRs/D3LDDEPgiuKQn8HtXi96WM5/ojGw0KeOH9ZUiHL+vKnKZUI63I35IGKoiF
	pZQl7iPtMyimpWK8gq6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZCsu-0002NR-EV; Tue, 18 Dec 2018 10:45:56 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZCsr-0002Kp-87
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 10:45:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lHWQL5ZkkZOHZm9RFneFu3rdbyqynYoSp+SPVhSSX/c=; b=DNE2olszgXnx60fA2Bvm2RYpY
 QJqTcKlCT3V6v6EugC5mEfj8zAfVfmnHLp+TaKsQqxW/sJHG7m4gabMVbXZ2jLMcLY5mMHU8XMK79
 9//45ZtPtLHbnLFpMoyYgLN/jdIddpExzHPIQRiTAK6Urk4TteJf7EGc5C5QI1JIYm4xk=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:38318)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gZCsP-0005eW-7v; Tue, 18 Dec 2018 10:45:25 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gZCsH-0006Bp-Ry; Tue, 18 Dec 2018 10:45:18 +0000
Date: Tue, 18 Dec 2018 10:45:13 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCH v4 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range
Message-ID: <20181218104513.GM26090@n2100.armlinux.org.uk>
References: <20181217202246.GA10500@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181217202246.GA10500@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_024553_289632_DA40B27B 
X-CRM114-Status: GOOD (  18.28  )
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
Cc: mhocko@suse.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-mm@kvack.org, stefanr@s5r6.in-berlin.de, akpm@linux-foundation.org,
 linux1394-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 01:52:46AM +0530, Souptick Joarder wrote:
> Convert to use vm_insert_range to map range of kernel memory
> to user vma.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <willy@infradead.org>
> ---
>  drivers/firewire/core-iso.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
> index 35e784c..7bf28bb 100644
> --- a/drivers/firewire/core-iso.c
> +++ b/drivers/firewire/core-iso.c
> @@ -107,19 +107,8 @@ int fw_iso_buffer_init(struct fw_iso_buffer *buffer, struct fw_card *card,
>  int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
>  			  struct vm_area_struct *vma)
>  {
> -	unsigned long uaddr;
> -	int i, err;
> -
> -	uaddr = vma->vm_start;
> -	for (i = 0; i < buffer->page_count; i++) {
> -		err = vm_insert_page(vma, uaddr, buffer->pages[i]);
> -		if (err)
> -			return err;
> -
> -		uaddr += PAGE_SIZE;
> -	}
> -
> -	return 0;
> +	return vm_insert_range(vma, vma->vm_start, buffer->pages,
> +				buffer->page_count);

This looks functionally equivalent.  Note that if we go with my
proposal to your patch 4, that would cause an issue for this
implementation.

Maybe we need two functions, but that then causes problems with
which function should be used (which makes it easy to get wrong.)

I'm beginning to wonder if the risks of causing regressions and
introducing bugs is actually worth the effort of trying to clean
this up.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
