Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D83CC10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:09:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA05222DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eZCjAnYT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3SI0Y5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA05222DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8wzD+nh2rjcWwT5vrW00G+U88/L+YjlblUvBDNmetEM=; b=eZCjAnYTI/RV3H
	Q//0FDSdcWsz6k5VbvOC+v4BVnzjSP0MDBCTB73legZZYfNAIktQXrZWOMxnl1k1VS9pqRktpOkl9
	bBjauuiDWFju/Z6vlYHY93GV2ZlRqW+uckvSlB/PUhRGynSOF4le6DF4F92mlZTqegFhOcsWm/gGk
	pYEANh663HFwyfTk6Bejd230zz/sYJMfYv+7oqPx+/2aGN3jz9XCnivv1dbjeDWiQHkPNzHBL/j4T
	4ARCYYGy4Uui55MxK3jSpVZO0NxhxVMKSD5sRYonTKlAG6CjsIuciAExRaDRfLjkE5+Quk6dIJRPR
	2240ERfHi/NDmaRjE9yw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gurHp-0003Yf-Lw; Sat, 16 Feb 2019 04:09:09 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gurHm-0003YA-Bd
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 04:09:07 +0000
Received: by mail-pf1-x442.google.com with SMTP id u6so5794763pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 20:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AdHjxWAIvBJGzx3w8YbtISELcPMTa1Y2ur/yRLG++Lg=;
 b=m3SI0Y5RxClBEOs40cKVJ9vNIUEyGn6zDG+2uEwabFpluInTGBq6Sl4pjqY8w/rczC
 oE8lICQwwl2E1svJBbD67+Uin1f1Ba0ZbRXuqA9fzVNAN5zdx12MpMo1h8OJZYPHvP1g
 tgPA6BaQHAPrKdSdk48n6C1fKNi6ljyIZRzYjuhfzqjc3quxDetqXYr4FPTHvs3+QKsU
 okZIvDvNh/XLxxrpTGP/6taTiP66tpkmtEIEfyzx47sqqwrTT28St5M3791TwvBXtcGF
 48kV3NoNbCxwtpDMm6/7OjUIfBrmfo3H7JFnCe5wy2INlXsn7hwt6d8dr6KVJEA+bJUo
 h+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AdHjxWAIvBJGzx3w8YbtISELcPMTa1Y2ur/yRLG++Lg=;
 b=eKAOSBpucgqSfnGNPNZ+LoCseXsEyQMigGB8WZnmuV8cFSOW24goXkF5G0lP2UqMz+
 GBHbo1NQG8LlaO3AZIQBhI1l6VwLmevwd66qO3rikU/A0UKNZ1+0NuDIkvKghdegcz/r
 PRTwFXdc8qNwr39/BIdeh0UPzEOPEgD5xMyxJHI12y4wXg9fydkWq3OSnh0zLgnagBkc
 4uw2JfSUBp6vmGh4vf+sIWSWZOUI40sQVOMhzytY4WP4Fmq/dcNCZOG6vm0Wxv3qXl2y
 O6ndrEVyhmw7/AxPH4icGqOQkClJikoSvU4nOzTba1vxsjIwvuMSVx6xKx8h8Lyzl1xm
 1l4A==
X-Gm-Message-State: AHQUAuaUL6ZEsFtII8rWoiAAsgqQvwjNo8PhjQSETzbALnDt9+XuOB3C
 3HViP1d0WxFrXwRXmCmTpDJ2
X-Google-Smtp-Source: AHgI3IY6j7fafeVMU+oG5c0qnthUPoAc22s9CwZ8/bl6+ix07fyh2LvwJTrbxsxZxP3u3/HoEp09ng==
X-Received: by 2002:a62:5789:: with SMTP id i9mr12865539pfj.75.1550290145492; 
 Fri, 15 Feb 2019 20:09:05 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6190:e85b:d8eb:c013:fd6d:7b1d])
 by smtp.gmail.com with ESMTPSA id e9sm27441763pfh.42.2019.02.15.20.08.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Feb 2019 20:09:04 -0800 (PST)
Date: Sat, 16 Feb 2019 09:38:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: martin.petersen@oracle.com
Subject: Re: [PATCH v2 1/3] dt-bindings: ufs: Add HI3670 UFS controller binding
Message-ID: <20190216040855.GA3054@Mani-XPS-13-9360>
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
 <20190105072859.9134-2-manivannan.sadhasivam@linaro.org>
 <20190111213502.GA24538@bogus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190111213502.GA24538@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_200906_426989_C877EF9C 
X-CRM114-Status: GOOD (  13.02  )
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
Cc: Rob Herring <robh@kernel.org>, jejb@linux.vnet.ibm.com,
 linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
 devicetree@vger.kernel.org, guodong.xu@linaro.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, robh+dt@kernel.org,
 john.stultz@linaro.org, liwei213@huawei.com, vinholikatti@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 03:35:02PM -0600, Rob Herring wrote:
> On Sat,  5 Jan 2019 12:58:57 +0530, Manivannan Sadhasivam wrote:
> > Add devicetree binding for HI3670 UFS controller. HI3760 SoC is very
> > similar to HI3660 SoC with almost same IPs. Only major difference in terms
> > of UFS is the PHY. HI3670 has 10nm PHY. But since the original driver
> > (HI3660 UFS) cannot make HI3670 UFS functional, a separate compatible
> > is added for HI3670 without any fallback.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Martin,

Can you please take the bindings patch also? DT patch will go through
HiSi tree.

Thanks,
Mani

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
