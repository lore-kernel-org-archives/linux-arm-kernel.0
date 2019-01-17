Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEDFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:46:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9989F205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="petZdfmm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ndMWNJb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9989F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W4IP3iEY/MmLFUcvVNWcASnXTwzcKq+OKgDstUQcsuY=; b=petZdfmmeWPsmT
	2LUHvkyoPwj4+u5L1VAJY+xYxeusOsdbP8VkGrtP3RPP5+f1nXETzSBEwmVEAXJaQYsnqCJ2tnY/n
	wvNI9Z8HTV3FBCj97gGvFz18NN+eNfp2wmCAJEpCyPdL+FR08YHA7Ad8Nof4CPZzcYAFnRHiClGTS
	zHutTwqp9O8UVUAI9LlDSVxRtVq2GshD7Q1NDxSg6jaey36zaPm2ueBlEV6KGIXfQtNsywCkwbe7o
	SK1fDp3c6P1JabelXtvGArSSZB7KibYyFhi64QlNAZxQMd8H3hZH+bChmbxyN9xmmqxjAL/d5hgcJ
	jetUrxiAIIJrJSGq492A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjxho-0008HJ-MS; Thu, 17 Jan 2019 02:46:56 +0000
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjxhm-0008Gi-27
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 02:46:55 +0000
Received: by mail-qk1-x743.google.com with SMTP id o8so5137338qkk.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 18:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B4j/WuweH0wMxL+RODpScBf2L4ITsa+/ZzunIai8Y/4=;
 b=ndMWNJb7QvWxiFN6aMSNgjChjftJHxNGb2N5am20Zt7XOu4JU3cOpXldQSBFcxRaft
 3kDybIQBtpZONmus/afJeaEQI9SzC8nZ92FcyabaKSlvn4mPt411lr9giwyRi+2ep/EF
 WnCM2PZqx/MobKE62RRhgqsT9EsPsNS9PQvG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B4j/WuweH0wMxL+RODpScBf2L4ITsa+/ZzunIai8Y/4=;
 b=eGgDpt2xoXoPC0En+kRJsWPWJnXgjUsK+To7dSnnLTW7wLY0SXFZFnsilttfAAaoe5
 JpL3GIjqmBWmPR//Z8P7XholCMaLDI/ex27cwvrzl/Kft677sVFMSwzlftory86FEV+T
 H5PQuQ5jvV5nB8dc98bIeJ51IuIuWM2fQbIOIaWz932QDjoP7akAXrP5RKivTuETOq3/
 SpTDd+cVb+2fpan/UjyCY2nrceS8NSWnhFZBWoUEKIHIVTWNOrPyqjmrHK/1jEurAU7Y
 ofxrYwDPmHEq+yb6WUvCzSgS1x+lo4xLRkY+vDQL0v6rBSdZXqXdKImzMw483f/GVt6k
 f+nA==
X-Gm-Message-State: AJcUukeVkqNK7xPMRiKAoqSDGkg5u+Gm16nhgbztA6dbrxaAbo+9C9aR
 CPT+OwSUxWy5bYCKH+9M3ube/ieYpldbp3mgvNo=
X-Google-Smtp-Source: ALg8bN4g6CHYobJ+o57LHwHQTioIoweDmYs1sEQbf7J1qINqKMWVyLA9iuNyxJeLx02SEqS/s3dBOJQ5a+0tigglcWI=
X-Received: by 2002:a37:781:: with SMTP id 123mr9208486qkh.231.1547693212458; 
 Wed, 16 Jan 2019 18:46:52 -0800 (PST)
MIME-Version: 1.0
References: <20181217200405.2904551-1-vijaykhemka@fb.com>
In-Reply-To: <20181217200405.2904551-1-vijaykhemka@fb.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 17 Jan 2019 13:46:39 +1100
Message-ID: <CACPK8XcbXso=13nRC3xM62RnWfEKnFcZpaBA4OAB7mad4mdGGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: aspeed: Add sensors devices for Facebook
To: Vijay Khemka <vijaykhemka@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_184654_104392_46F594AE 
X-CRM114-Status: UNSURE (   8.84  )
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
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 18 Dec 2018 at 07:04, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Added ADC and other sensor devices in Facebook Tiogapass device tree.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Applied to the aspeed tree for 5.1.

Cheers,

Joel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
