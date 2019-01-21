Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB7FC282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:30:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C555E20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i5iDQ40b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1iTp0+jt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C555E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C2qwCrzAou2ShA1w3woDhog46heN6CKccXmcmcaFN7E=; b=i5iDQ40bbAADaa
	0lIbs9BeHKzCUChn+3FBFHjsapOeNn40bHLI9THe74tzZWjNZEnQ7tJYOXOlHaxCLYmVYEkccpBID
	pjr92jMlWhs0MGRvRiMAZKRY/YTChFaQ3sYQOdqT8xeA3itlglGvu04MuCuoL6lKBpQmEosfcDNV3
	rLRbC9X2nPl6s6H1MdxrNMgye2tNJbEZFUA6+wMUzAGdTFXVrAhtjj4xw/aV7SayFGxRHURLt0/gg
	xtq0/BTwukHP3RqKnbRbgMj5DU/3JJPqTmcIglhYaw7GoBSgdW5zkbBbmiFTfSIwSuei3w34XmFkT
	3RMFQqwOpbMCBAdvl0XQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glWqh-00017l-MY; Mon, 21 Jan 2019 10:30:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glWqe-00017R-7u
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:30:33 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F40E92084A;
 Mon, 21 Jan 2019 10:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548066629;
 bh=tFA4GsYN4y88wPSWG9l+/tqPNXX2OXLhiorveQTLJZk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1iTp0+jtiIKtn9ftohRdtUsg/948t7aCHpHuYozzrfjfT42qcx/o4hXVAaLiEDhQq
 scQiRN2yIk6CDIDXSw+aGhOgYFgHkQhQnxhzr2BWlBLRDypLEq0P8cd0P2njEaYD1N
 sXBkLhRoMEUwxKX3YFM9kiKYFeHlUXEuoF/Qc2nw=
Date: Mon, 21 Jan 2019 11:30:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v4 4/4] hwrng: add OP-TEE based rng driver
Message-ID: <20190121103026.GB15590@kroah.com>
References: <1548062959-31860-1-git-send-email-sumit.garg@linaro.org>
 <1548062959-31860-5-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548062959-31860-5-git-send-email-sumit.garg@linaro.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_023032_293813_EB3E4EFE 
X-CRM114-Status: UNSURE (   8.77  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org,
 herbert@gondor.apana.org.au, arnd@arndb.de, ard.biesheuvel@linaro.org,
 bhsharma@redhat.com, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
 robh+dt@kernel.org, linux-crypto@vger.kernel.org, mpm@selenic.com,
 jens.wiklander@linaro.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 02:59:19PM +0530, Sumit Garg wrote:
> --- /dev/null
> +++ b/drivers/char/hw_random/optee-rng.c
> @@ -0,0 +1,272 @@
> +// SPDX-License-Identifier: GPL-2.0

Nice, but:

<snip>

> +MODULE_LICENSE("GPL");

This string means "GPL2+", you need "GPLv2" here instead.

Yeah, it's a pain, and everyone gets it wrong, we need to add a
checkpatch.pl rule for this to keep it from being added in new code.

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
