Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D32C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 00:08:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 943F321903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 00:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PgC/xnqF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x8h6YhoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943F321903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bzGM0Fv/YW5rLtwm8bx61D1ZL2Y3wyAQUvQZvZ8v4q4=; b=PgC/xnqF/sdvZY
	X9c71ufsv9vrrtERxO8yA9UTQG7BbppYuTUgiNgHhANb81Frb+cr4VgzB/4vo8Xj78sqmF6vAJvg7
	gzKbR4d9TBSzCDb1dOdpMXk/5CKEKFICmYkpessfPydls1woq12eb6R4nrot0IBXx9blSdX31QVUG
	2UiPnk7Knbw6TsVNtP2Kucv39JS2uBIeIK0kaN7jPMbllhabHKjoLjbkclrYNf+H+MC/+Ico+cjyb
	TL/Q0JzyAa2bEMCjAuNBo2xBQcmEGLl+UQdCfTLJ4Ihsi6dk0SbSE6RoPFAqe1H6l4dhWG63FLXrX
	tTXOhLs+bNkDlj4vfrBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnXzS-0003GF-Uc; Sun, 27 Jan 2019 00:07:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnXzQ-0003Ft-DS
 for linux-arm-kernel@lists.infradead.org; Sun, 27 Jan 2019 00:07:57 +0000
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net
 [107.3.167.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3971B218CD;
 Sun, 27 Jan 2019 00:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548547675;
 bh=jMkfqoVZ3STo8cv96Vrd9G6L5fyZlOKr/E4M70cXCvg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=x8h6YhoOiPywx7kn1JCchLpbt+dDi5y8c2aymjX55uOoazejGenFq8IfECMx6MYO2
 +gjo7he81vhztqMhQe9aFcozzfm1CYtIyR4z41j+UuHYePyMXmIhJOmWbMVRUEeYBa
 fm1Qg5aYyfAO0kMP/G/eq7ti+IyUb3+UR0BpZkf8=
Date: Sat, 26 Jan 2019 16:07:53 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v2 0/4] crypto: fix crct10dif for ARM and arm64
Message-ID: <20190127000752.GC709@sol.localdomain>
References: <20190125084915.25411-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125084915.25411-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_160756_474212_7A81660E 
X-CRM114-Status: GOOD (  11.52  )
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
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 herbert@gondor.apana.org.au
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 09:49:11AM +0100, Ard Biesheuvel wrote:
> Fix the issues in both NEON implementations of the CRC-T10DIF routines,
> that were reported by Eric's new testing code.
> 
> v2:
> - keep alignment specifiers where possible (#1)
> - clarify/fix commit log (#2)
> - add fixes/cc-stable/etc tags
> - add patches that drop the now unreacheable code (#3 - #4)
> 
> Ard Biesheuvel (4):
>   crypto: arm/crct10dif - revert to C code for short inputs
>   crypto: arm64/crct10dif - revert to C code for short inputs
>   crypto: arm/crct10dif - remove dead code
>   crypto: arm64/crct10dif - remove dead code
> 
>  arch/arm/crypto/crct10dif-ce-core.S   | 27 +++++---------------
>  arch/arm/crypto/crct10dif-ce-glue.c   | 23 +++++------------
>  arch/arm64/crypto/crct10dif-ce-core.S | 11 --------
>  arch/arm64/crypto/crct10dif-ce-glue.c | 25 +++++-------------
>  4 files changed, 19 insertions(+), 67 deletions(-)
> 

In the commit message of patches 1-2, "more than 16 bytes" should be
"at least 16 bytes".

Otherwise for all 4 patches:

	Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
