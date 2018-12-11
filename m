Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0780C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:17:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC622084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e7Zm/ioy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC622084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2KNLoeWOUdolC3Qo8KYLSUuJCYKhBuKxWn2k0B5aIuo=; b=e7Zm/ioy/AFMBU
	XRDQtpZ5m1+0Lb6+h8Tcm2i/0nkco4f3FEUTi9CQMnFWb4uDjZh50M8aqsLLEDvkQdJFp+WcfYRGs
	66kpVuVIKTrhm8XPiC8mEjuDIp4Kko+E4/lEWcdljBqOQXLCuHwWv7PCT+CCk+317Fdai2PQf18xA
	KVemcG4SLzMzz0fl15ncmRy0ExL76cUuUjX5XkBDFkYKxVHXpfR7RXNG0b7dNtaGKz7jsWVZAQ9QY
	mbJtUMdF+Hw1ZZKMIUnD+/9BN0DryouKeMA4G69AP/W3jhd3oh4zVbkawyDXFAKv9M8Mj5G6JYYtW
	8Lfhp+krzwm62+UIyj2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWqKz-0004Qz-Rv; Tue, 11 Dec 2018 22:17:09 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWqKw-0004QC-76
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 22:17:07 +0000
Received: by mail-oi1-f193.google.com with SMTP id a77so13390962oii.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 14:16:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DDttSym8loLOGw8lNReQ/iWWKOGuBQeN1EAbZF02m+U=;
 b=H7GOLcFER85B47E++JSwPjaCl/8UNxH6wbWXU4hI8MrvoIA48CJT82QUWiAdgOcqgc
 tLcZhuL1OYh2/h9m3eCNzWse7rWu6lexSjaR3bo2j3bQi6WrDTaupFy88Ov//PWuKyjm
 +qU9AMLFArmVUKTC8qlF57XndAGrYEsnVWXc0aodYJNQIAqpcemSlsS688UDLmzfDhLJ
 TfWQGZRkGHocmpXMZHHrMLCjyYK+aUvvEYwNwM9c2Mn9hbdzYQQxShot95qPpYg1Gx9C
 cYT6T3wI6nTU6f4YT1wuLcTE4tAVDniNIA3X6OUj9/57qxMAFTjniSs7ymSbnFy8tYWb
 yTjg==
X-Gm-Message-State: AA+aEWbe0m0WlTtIXmG4QqPIRwuM/HVp2KuFWBdPf4TgHLlFzM18DIjM
 GUH9c7//ULWTQQo3Ld6qQQ==
X-Google-Smtp-Source: AFSGD/U6zGuj+m/t65FF+N9DvKvscHpsRM1XOENrEZuY3fXqtr5i9OFUw1bBbiVEKxIHz7NxCy7dEw==
X-Received: by 2002:aca:1a0b:: with SMTP id a11mr2407850oia.154.1544566614312; 
 Tue, 11 Dec 2018 14:16:54 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id i5sm8494610oia.46.2018.12.11.14.16.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 14:16:53 -0800 (PST)
Date: Tue, 11 Dec 2018 16:16:53 -0600
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH 1/3] dt-bindings: mfd: syscon: Add optional clock support
Message-ID: <20181211221653.GA18104@bogus>
References: <1543337297-21873-1-git-send-email-fabrice.gasnier@st.com>
 <1543337297-21873-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543337297-21873-2-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_141706_256500_5429BCC5 
X-CRM114-Status: GOOD (  16.54  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 arnd@arndb.de, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 lee.jones@linaro.org, gabriel.fernandez@st.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 27, 2018 at 05:48:15PM +0100, Fabrice Gasnier wrote:
> Some system control registers need to be clocked, so the registers can
> be accessed. Add an optional clock.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Documentation/devicetree/bindings/mfd/syscon.txt
> index 25d9e9c..a9aaa51 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.txt
> +++ b/Documentation/devicetree/bindings/mfd/syscon.txt
> @@ -17,6 +17,7 @@ Optional property:
>  - reg-io-width: the size (in bytes) of the IO accesses that should be
>    performed on the device.
>  - hwlocks: reference to a phandle of a hardware spinlock provider node.
> +- clocks: phandle to the syscon clock

No. Add clocks to specific bindings using syscon. If you have a node 
with only 'syscon', then that should be fixed.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
