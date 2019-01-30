Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C36C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:30:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 724C420881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BQOQojt9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="O+psazMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724C420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vGzR73T6uF+L88AQXqHETz8qRmK9k5IXGR5J0jyrX/w=; b=BQOQojt9znhPwc
	h5iOpM7uYLTpchBemqmRGmRPfF7wiqDQ8knLjcljeBz2w7poTwwjHglH8mUm0zpRyRxg6UgD9/7Cm
	Kwd/Xn0qNMWztiqQjhZ7A/+mwkD07o5msdZvTaxr6em1UYPRmpFyPyEuFdQycKW5uno54Q3DatkRG
	o+5s5Vx7/7U1TCfqYr+PNmxcJ8ZiZ4Uy6ng1TiY4wtarv+cFsr1MphtxFpU/AZm3NkKCJBiSTNgY5
	q7jtIEZH/cGakfzpVQeZcT9a1iK3o3gY8cRQ+4Bi27QDNLgqUPtMFnRoeWrPgAuICrxiWtarFeAsD
	MII0d21JVvf6TpaXWTnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gogaP-0005tq-3X; Wed, 30 Jan 2019 03:30:49 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gogaM-0005tV-07
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 03:30:47 +0000
Received: by mail-qt1-x841.google.com with SMTP id i7so24778901qtj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 19:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EOazp/NWSDbCI8C+71UDBedskrp4jlovZVpb655hqvc=;
 b=O+psazMWvQoU6qhDFavivE6P9jLDHQZ3zpfhSE/LPFAGiKfXe7TrmCEsw4aNUdKK4K
 lpJ0kIdBwycUE7Kzr87i4aTSw1FnGlWGQmYfTMzdinb/1XmuW7PbG+rvT+umTqFBzID/
 ntKSqRUK2r2MzeLpRRXXA55Y33nfT3nVs66f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EOazp/NWSDbCI8C+71UDBedskrp4jlovZVpb655hqvc=;
 b=G1xdy+QLfjOr3tkZT9v7JOt+U4WZaRyaKrEajVvgUYHS4/iyj5ElSW9g0uPgQ+ZEFj
 VmWHBjwQGIRaY1JbjTMO+fgphjKeZQB2Ze9oKMz8e87tsjY5gH32o1SGIpjn+n8RsQ9/
 C4k5qJF2+e2ae9Nmb5AbbyAT8sed9voBhkcKaNoJegUMdyW7uGExnBS/e3tkeBTo5jnP
 Xx4XnChofb+oZmm+la0Ub/xlQzc13RDt7jOy6PoTxIKMrxpdE5sOirfoYY5AeD4Mp+/n
 LhWymZOie16lrg60jzNoAckYomDfGM7yeishHt4/3W/kDhKmqzD1zQAIsJ76tlD01KGq
 Qhig==
X-Gm-Message-State: AJcUukeFYmxPSvuXpD8NAKt/ieUyVE33HKay6m8ONxb4tU8hlG85qOjv
 KFx3ZJkpbhBFKkQIyrZqThnlysH1jBfgst+m3LA=
X-Google-Smtp-Source: ALg8bN7LW70WzD86d3+LFpR4kdydSKb/yb44aVGHjpkQPeLKmhko7YcKakMv2eFQDtrtBDy9bist227w4b+PVjN7JKU=
X-Received: by 2002:a0c:e789:: with SMTP id x9mr27109614qvn.245.1548819044408; 
 Tue, 29 Jan 2019 19:30:44 -0800 (PST)
MIME-Version: 1.0
References: <20190129230538.1044378-1-vijaykhemka@fb.com>
In-Reply-To: <20190129230538.1044378-1-vijaykhemka@fb.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 30 Jan 2019 14:30:29 +1100
Message-ID: <CACPK8Xdg+mjqL-qnNGUnRPw03sqBJGf_ckcsFnw6_F7HA96o6Q@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: aspeed-lpc: Make parameter optional
To: Vijay Khemka <vijaykhemka@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_193046_049473_BB0DE3D9 
X-CRM114-Status: UNSURE (   8.76  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, linux-aspeed@lists.ozlabs.org,
 Andrew Jeffery <andrew@aj.id.au>,
 "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 30 Jan 2019 at 10:05, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Memory-region and flash phandle is not a required parameter, it is
> optional to describe in device tree and needed only use basis.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Acked-by: Joel Stanley <joel@jms.id.au>

Thanks for following this up Vijay.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
