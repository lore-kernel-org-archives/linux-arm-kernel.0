Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D62BC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:34:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9432086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E4jbOk+r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="caDuud3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9432086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o2QjlMSmG0Ce7eranC/T7LJKUsSmCcYSx65u1Jy8T4I=; b=E4jbOk+rJmKyaQ
	7bvTkIRMbuWeYDKUR4I4CEy9tDZykl0sdwMg+TRtKOp4e5lW/Lk4sO4tBZ/cc78+UIUt8rQhfAFBc
	J8MVYZYfg0w6o5FTn1xN3s6s9ySxdHZGUIljw/EHcTX+CVW0j/rE8LURgfWZXQlcK8l2TGzqbXjNC
	s8N1Qkr7dbmkc87AaTZcKlytvJ12cJSKb/p3Lcu/ThzQDbHsit2Bf6SX+7TrbmqWa2WM5FRKAVIXh
	Cbqz9MgpfCU9lZdm2DPPN7DBnoj1ua7tDMj7YhPsxxi/rB/DjmXkivQM2TfV/FT7c7j/raavHU5EV
	HpyhyVSazsMn0Gs0rQyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX1q7-0000KG-35; Wed, 12 Dec 2018 10:34:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX1q4-0000Jm-3J; Wed, 12 Dec 2018 10:34:01 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C138F2086D;
 Wed, 12 Dec 2018 10:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544610829;
 bh=e77rAmibzXjl4N1dIz50bpJuI36/JkdMqVTNhUu+YNA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=caDuud3CWYdlyCjgqwXtEENU4ceWeKs/vmhwXuhqh4NuTAAEyshv8xy33kBItuRe6
 vegGf+6t6wwuxuMYX613178Qnnwas7MpW7IzjNFQQ4eDw7zI1WlBPAoQVsWWn6GYI5
 PwYCMj94o1Ku1E7Y4Avy0mP2dRo1/kuMnm3Qzmx8=
Date: Wed, 12 Dec 2018 11:33:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: yuhui zhang <zhangyuhui89757@gmail.com>
Subject: Re: [PATCH] staging: mt7621-pci: Fix checkpatch errors
Message-ID: <20181212103347.GA16458@kroah.com>
References: <CALT5DkvTHn=TO5TDd+_qiNobkukdQ=M1zhRatOHD3QCbBkes4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALT5DkvTHn=TO5TDd+_qiNobkukdQ=M1zhRatOHD3QCbBkes4Q@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_023400_155347_A9888881 
X-CRM114-Status: GOOD (  11.64  )
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
Cc: peter.vernia@gmail.com, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, mamtashukla555@gmail.com, neil@brown.name,
 sergio.paracuellos@gmail.com, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 blogic@openwrt.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 03:23:06PM +0800, yuhui zhang wrote:
> This patch fixes the following checkpatch.pl errors in the
> drivers/staging/mt7621-pci:
> ERROR: space required after that ')'.
> ERROR: space required after that '='.
> 
> Signed-off-by: zhangyuhui <zhangyuhui89757@gmail.com>
> ---
>  drivers/staging/mt7621-pci/pci-mt7621.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

You sent this same patch 4 times.  Or at least I think it is the same
patch, I really do not know...

Please resend, properly, to the correct mailing lists and people, this
patch only one time.

Also, you need to fix up your from: and signed-off-by lines to match up.

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
