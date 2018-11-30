Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A010C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:28:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255EF2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tp0X+ARL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="SkUfI7Ka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255EF2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DriGc7SYCg4fO3VIpe03zoIWCkBy4kHgoB+H8texTSs=; b=Tp0X+ARL4Vl40/
	DrXvzFUkRMVQ/y5ZqUr7HnOBgXQu+F9nrVFbpS2mQhKFB1ZyLZK43mLYlnA8oIo1S3n8pISoQfKO8
	pZyo5Pu8vuYptI+eKE9xi3lsc7OyNDbo4cqNt4zlEyd33kPjl0o1zyUxmsLgDKoU2dDc7tcimIDsy
	2RmsgIvX0Y+HlQ5y7u2wWjNvEARsBf0DTopnUdtd71YWI9zw2iQECu4ZzvTDNDS7/XWzGomMhWUQA
	Ci7WepcdRSjb9HSmqNrjTlhfMnrIWVJg4jErX9Dpf2XH6RrrnCk9WiEvnioSpxCCyV+golJjs6Qsq
	9vKBj83jzb11rX43irdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSg2S-0003jE-Fm; Fri, 30 Nov 2018 10:28:48 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSg2O-0003ib-VR
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 10:28:46 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id D0E0A25B71D;
 Fri, 30 Nov 2018 21:28:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1543573710; bh=7sfaD/9m6c6NM2P6wPyNcHbhg7qyW3IhRqnqHN3nWVM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SkUfI7KaQyr47ltK8IglZ0m92axNck/cG1lLax5pNpz1UkxzfyuslsF13Ny4nyv+O
 ZZ5oE3IoM5pdwevyu8HKk+0W4/ODzXfQhFPTaEMSoz12lI8mBvvUFTPLPLsYiqhrcN
 +QP7X/a03/9OdwuigxClNMKQn5QRIizs+uSy7qCM=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 291269402F8; Fri, 30 Nov 2018 11:28:28 +0100 (CET)
Date: Fri, 30 Nov 2018 11:28:28 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/2] ARM: shmobile: R-Mobile: Clean up struct
 rmobile_pm_domain
Message-ID: <20181130102827.ps33kf7ywonpyitn@verge.net.au>
References: <20181129110931.11783-1-geert+renesas@glider.be>
 <20181129110931.11783-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129110931.11783-2-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_022845_197975_3CF64AE2 
X-CRM114-Status: GOOD (  10.44  )
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
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 12:09:30PM +0100, Geert Uytterhoeven wrote:
> Commit 59b89af1d5551c12 ("ARM: shmobile: sh7372: Remove Legacy C
> SoC code") removed the last user of the rmobile_pm_domain.resume()
> callback.
> 
> Commit 44d88c754e57a6d9 ("ARM: shmobile: Remove legacy SoC code
> for R-Mobile A1") removed the last user of the rmobile_pm_domain.no_debug
> flag and of the "pm-rmobile.h" header file (outside the actual driver).
> 
> Hence remove no longer used rmobile_pm_domain members, and absorb the
> header file into the driver.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied for v4.21.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
