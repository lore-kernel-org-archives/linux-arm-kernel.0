Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D12C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:24:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208222080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t/HxnSrF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8EIzMfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208222080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tJ42VhcqzWaR+1OelZkpz+0PWkJYhGTlGlnhdQvgMNw=; b=t/HxnSrF13iL9j
	tjLrLimQ4PT9MYNn2Q53YHAy+OSaxaEq7bBUL075uAqkkF/ersL4Md9oKajv9fXbUC7pIbjM7SkiT
	8xTLIgPkkDNmEnPoVcMdRadiktAbGE/GW0ZZI1hrQivcxVHYgicHYEo/R2KyYCienkuyU+K9iYNUu
	U/E8cHsS2xqfQ4jz7DDLMvrhQ4dLR8ElLgYMWS5tRfYVbKEKr9Y6e7xNgnuwSbKjr3sMlTqIr7EKb
	Aji4czsZzWZ6yxrMIsoWbdCQiRJP5rwqps+6BS5HC/m0KvPO1s1oA9RFJZbk3x+lJIenDpiy4HEdG
	WRfq6M41yjTESUVzCMmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXhpd-0000fe-OF; Fri, 14 Dec 2018 07:24:21 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXhpY-0000d4-NY
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 07:24:18 +0000
Received: by mail-io1-xd43.google.com with SMTP id k7so3723346iob.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 23:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=upTfiP7iEd12IBycGzRmU4Z0acUxwmT5c1yFIwWuYd0=;
 b=K8EIzMfCOqFIj4GuH6k/sz4MW9JRkeMr3UaFHSBl2LOp9dRwjtVZstHRthKyikRRVq
 0QktT3jOQssB0Zk378XLCZ3CJnXLu2sM951yv3AlSQZkjJ1lRlcUkfH73z3bgUSj82Ab
 zdhjaXH9NlfNt+QoLb6FnUywZYJWX1l+VX76A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=upTfiP7iEd12IBycGzRmU4Z0acUxwmT5c1yFIwWuYd0=;
 b=gXfez5/6bdt/Cn5b28wqluegsOBcb0Bwc4T7w7b0FE7Gh80gcXFC16+TU2RrZOICuv
 jNyMiJOA/+LHjTIEfEptP+YuKuT1GlE2Ss57+yt8uccGNVI2QNGBtf6YY4oXgUPoxIcC
 /xIId7aQLG99aCzFT/7gsstD7XTv5VcZGVH8rDHe6getQelBAFigLOSoW2t120R30j2E
 IM7WXx+gz7HfAWp3stbAa8Xxfy79JjOYsT59nLV/wVY5+qmYIzEp7IPzFVGZNQERoN2i
 pAlsXiVqj7OEvH5Sr5V356vBy15SKzNyyLETtXXdsUVzU4joBVU0JhvHSI+bzQTurIm3
 PCVQ==
X-Gm-Message-State: AA+aEWb5IMwvlOIHJ4kdxVCIugXyUBvEhw4nbFjA4pfJ9A4cXRfWB9n5
 owrv0ze3C54DogwlEAqoVwTA1E1vFYgma7D2Etg91w==
X-Google-Smtp-Source: AFSGD/VNPhGUiANhgaIurvr9PdLT4FkdhdolieAqsX3nm31QvPxPs+KqsSAdSwf4SoDP+88TkPqB13+n3j+cCz7av/8=
X-Received: by 2002:a5e:cb0b:: with SMTP id p11mr1696773iom.60.1544772245087; 
 Thu, 13 Dec 2018 23:24:05 -0800 (PST)
MIME-Version: 1.0
References: <20181213052259.56352-1-cai@lca.pw>
 <20181214040819.58625-1-cai@lca.pw>
In-Reply-To: <20181214040819.58625-1-cai@lca.pw>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 14 Dec 2018 08:23:54 +0100
Message-ID: <CAKv+Gu80cxx6L3KYyYnsyjbrWN6iTp76jcdBio27b_h+dAzaHw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: invalidate TLB just before turning MMU on
To: Qian Cai <cai@lca.pw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_232416_769766_C95F84BC 
X-CRM114-Status: GOOD (  11.22  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>,
 Kexec Mailing List <kexec@lists.infradead.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 14 Dec 2018 at 05:08, Qian Cai <cai@lca.pw> wrote:
> Also tried to move the local TLB flush part around a bit inside
> __cpu_setup(), although it did complete kdump some times, it did trigger
> "Synchronous Exception" in EFI after a cold-reboot fairly often that
> seems no way to recover remotely without reinstalling the OS.

This doesn't make any sense to me. If the system gets into a weird
state out of cold reboot, how could this code be the culprit? Please
check your firmware, and try to reproduce the issue on a system that
doesn't have such defects.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
