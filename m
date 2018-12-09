Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29423C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:35:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED7ED20865
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LcnYpWfx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNxikBmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7ED20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pHdzhlDO9soTBDXv6y6zpYWLoOjEjHMY+4y8CFzyFzk=; b=LcnYpWfxkni7YW
	6CkrYz2ACkFVi4yPjLEBUWVVUE8jt+tF+5tzVnOGtY3fDjSxc/QU/Y2OncRXbfbUAFVWNaSv2M4r0
	NZ8eyBHqiJgT8UpAsVwQxRdFvk4ZXwlXo8DHHJQzD9D6GBOKG84jrjtAkm+bjensV0iO4GvwqEQ8R
	lg07HMdbpeTW/Z/Bc2R76gxQvrjq7I0g/bvYOQEgW0gS8U5880pssXH9/l415lute+qzAtnCQlAZ/
	eRp4vy2ghQGy2TCbm0FqmfoFIiRP3AV0bdDgmQKY/h0KYnA4qFI5N545OsdqVrNYzHkvl+8DHmGYU
	GaklpV7tHgrej0HnJ/kw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW0BF-0006h8-F6; Sun, 09 Dec 2018 14:35:37 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW0BA-0006dZ-S6
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 14:35:35 +0000
Received: by mail-oi1-x243.google.com with SMTP id x23so7034560oix.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 06:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2YYL6SdlsnS8LvEcJiSWWic8y/Sq1+/soioBhtb8wzs=;
 b=YNxikBmUhzEUB88TlmfQ/ifjusKNul17kgrueqVDEBpj+bnexNXVRXxIqvewwhFW8l
 rjBrv77NC3Ydn93q1mz4cmDvGG1HhYEulOY4Y735hY7fiU46fAeGpmYMBpmlAibJgKXA
 MaXvr1twFp5iQ0G6ZG8RVk66huqvAaYQc5/o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2YYL6SdlsnS8LvEcJiSWWic8y/Sq1+/soioBhtb8wzs=;
 b=c5WqkQubP8oz5Y47bTqyMnFEl4CICwBRJMSYMhC/kjsxdmdni4v7b7oIZ4dmS7PUEJ
 QbBj5TDFVlYCWNyQaXdPUbXwBWBcx6qmBh7e4Wotle3C3I+90U9JogQgf+4jONrUxXw/
 fOTODEOuFbXso/R/y8gRobTTPq0frM+Q/9LCQaA6kyAx1mGDEGgQuDVeTD9u5i2Eqele
 8IkQsydRP819HVhgOKTOcLiBIsgn9h0xVXsrBOvPTbOgzNVuCU/GpVtssXRQxCzg9tb5
 bLxvaIlcI6QVssNzESSBYExmPsg0G7kJE5nKjQNlYPSH2VuoAD9q3+tHohEo4vyHhdx3
 9/3g==
X-Gm-Message-State: AA+aEWbWQkstZBViTGvohSZC56BC6A9pQR2GouQ0dzm4S6XlbvFXdfsC
 bygUbxvXtPdZNFGT+cuntXXAsw==
X-Google-Smtp-Source: AFSGD/XEvgvnC0VECDHYmfCQwoDqN7YbQFj57c68xIgFtqvMJaXUykYI7patCGVchQbXqViQpWoJZg==
X-Received: by 2002:aca:4fc5:: with SMTP id d188mr5225860oib.138.1544366121805; 
 Sun, 09 Dec 2018 06:35:21 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
 by smtp.gmail.com with ESMTPSA id r9sm5001224otq.81.2018.12.09.06.35.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 06:35:21 -0800 (PST)
Subject: Re: [PATCH v6 03/13] arm64/kvm: consistently handle host HCR_EL2 flags
To: Kristina Martsenko <kristina.martsenko@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-4-kristina.martsenko@arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <78a88508-7145-d58e-6275-937e1b23baa5@linaro.org>
Date: Sun, 9 Dec 2018 08:35:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181207183931.4285-4-kristina.martsenko@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_063532_902000_69B1B4B4 
X-CRM114-Status: GOOD (  17.02  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 Jacob Bramley <jacob.bramley@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Adam Wallis <awallis@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 Cyrill Gorcunov <gorcunov@gmail.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Kachhap <amit.kachhap@arm.com>, Dave P Martin <dave.martin@arm.com>,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/7/18 12:39 PM, Kristina Martsenko wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> In KVM we define the configuration of HCR_EL2 for a VHE HOST in
> HCR_HOST_VHE_FLAGS, but we don't have a similar definition for the
> non-VHE host flags, and open-code HCR_RW. Further, in head.S we
> open-code the flags for VHE and non-VHE configurations.
> 
> In future, we're going to want to configure more flags for the host, so
> lets add a HCR_HOST_NVHE_FLAGS defintion, and consistently use both
> HCR_HOST_VHE_FLAGS and HCR_HOST_NVHE_FLAGS in the kvm code and head.S.
> 
> We now use mov_q to generate the HCR_EL2 value, as we use when
> configuring other registers in head.S.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> ---
>  arch/arm64/include/asm/kvm_arm.h | 1 +
>  arch/arm64/kernel/head.S         | 5 ++---
>  arch/arm64/kvm/hyp/switch.c      | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
