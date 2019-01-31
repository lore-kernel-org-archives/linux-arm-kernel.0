Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187EEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:06:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E135E2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gs6xfHpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E135E2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R8VNQt7K1eEfGm4wmtfNw1C8OpUZ05SxFvQ9xW+xhPE=; b=Gs6xfHpOjsU13r
	hyoZcCrikgrvCTJ4vwh8KHYmM98GyHTxHerbfqCMSOnL1Ak9dQjMG/CTk91W54Tn1jcdIqw8HQJBQ
	o4HaZgVs+kFhUiMqmbaUt/uK6VFGH8KsbP88MNQ7NxMinOaSfYbgp6kV7+tNO7n+BHbk8IF1m/rvj
	/daSzLUXQK2LuqcVYANfwzKM6lCrpKHWBHODbIcHhDOtdv6fqudFafz9CgxOeeO69f1ZwLTOSe81W
	0mfegsQh/6C3ri5i8DzV8wrK/h3lxOz5vtGv5qMhOQOo8m2/BWVpWbdGff9YsG7ibbUCTplvF8wQz
	HDeX0RgZtZOEcCJbvYgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpB6s-0002pC-SN; Thu, 31 Jan 2019 12:06:22 +0000
Received: from orcrist.hmeau.com ([104.223.48.154] helo=deadmen.hmeau.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpB6n-0002o4-V5
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 12:06:20 +0000
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1gpB6V-0004wT-In; Thu, 31 Jan 2019 20:05:59 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1gpB6E-0003hY-L5; Thu, 31 Jan 2019 20:05:42 +0800
Date: Thu, 31 Jan 2019 20:05:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v6 0/4] Introduce TEE bus driver framework
Message-ID: <20190131120542.g7wtnhzuz5nuqbcc@gondor.apana.org.au>
References: <1548740978-28495-1-git-send-email-sumit.garg@linaro.org>
 <20190131084142.GA21196@jax.urgonet>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190131084142.GA21196@jax.urgonet>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_040618_271764_3EA3AFCA 
X-CRM114-Status: UNSURE (   9.92  )
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
Cc: mark.rutland@arm.com, Sumit Garg <sumit.garg@linaro.org>,
 daniel.thompson@linaro.org, michal.lkml@markovi.net, arnd@arndb.de,
 ard.biesheuvel@linaro.org, bhsharma@redhat.com, linux-kernel@vger.kernel.org,
 tee-dev@lists.linaro.org, yamada.masahiro@socionext.com, robh+dt@kernel.org,
 linux-crypto@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
 Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 09:41:43AM +0100, Jens Wiklander wrote:
>
> I think this patch series is good now. It has received comments which
> has been addressed and have also gathered a few R-B tags.
> 
> All patches but "hwrng: add OP-TEE based rng driver" covers what I
> normally send pull requests to arm-soc for.
> 
> Matt, Herbert, are you fine with the patch
> "hwrng: add OP-TEE based rng driver"?
> If so, is it also OK if I take it via my tree which I then will include
> in a pull request to arm-soc? An Acked-By tag would be nice to have.

Sure you can add my ack-by:

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
