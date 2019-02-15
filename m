Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9742AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:15:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604F1222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pZgTkh70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604F1222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FDau9eTA11BMwvMHjSOv/23UkL6J99WCZWuoDWMNHQU=; b=pZgTkh70QqqqK9
	5RhNZ0DnFpfkOWN+QINvHeuZpn9OFBrYPwArSCdVQStC7ZmjQvnLrDyA31BJUEsflGlfYtrSgH35x
	buo/+jNogXeJh2oY2k/HhgT0VZ13AnBztKB22F85HWFE9YBafqtEsjJgZx5wmI1DLHoSDt8VIeOfa
	6eAgQuPeLWXr2wa6xhd9+yrbQ+2aLg+VmiGvVpbKr/NbinRpGzr5Peojo/ZmHVax6BMufKG4SMDCP
	ujahunLFwKP4zu+R6t6386NOORZGxxHn3ja28TMk1zHdrNxv1GTLHbeQM70EQNJIsctAsQAzB8vUB
	g25ZczoDpEtvjuFAF/VQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gujt1-0005im-L5; Fri, 15 Feb 2019 20:15:03 +0000
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]
 helo=smtp.smtpout.orange.fr)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gujsw-0005dq-VI
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 20:15:01 +0000
Received: from belgarion ([90.76.35.80]) by mwinf5d29 with ME
 id d8Em1z00C1jkVcS038EnfN; Fri, 15 Feb 2019 21:14:51 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 15 Feb 2019 21:14:51 +0100
X-ME-IP: 90.76.35.80
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] ARM: pxa: ssp: Fix "WARNING: invalid free of devm_
 allocated data"
References: <20190129080324.18708-1-yuehaibing@huawei.com>
X-URL: http://belgarath.falguerolles.org/
Date: Fri, 15 Feb 2019 21:14:46 +0100
In-Reply-To: <20190129080324.18708-1-yuehaibing@huawei.com> (YueHaibing's
 message of "Tue, 29 Jan 2019 16:03:24 +0800")
Message-ID: <877ee0u7ux.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_121459_286520_1B27DA64 
X-CRM114-Status: GOOD (  11.74  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
 daniel@zonque.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

YueHaibing <yuehaibing@huawei.com> writes:

> Since commit 1c459de1e645 ("ARM: pxa: ssp: use devm_ functions")
> kfree, iounmap, clk_put etc no need do any more in remove path.
>
> Fixes: 1c459de1e645 ("ARM: pxa: ssp: use devm_ functions")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Sorry for the late reply, I had forgotten to answer.

Queued to pxa/for-next with a small spelling fix in the commit message, thanks.

Cheers.

--
Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
