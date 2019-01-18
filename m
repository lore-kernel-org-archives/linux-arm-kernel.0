Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A347C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:39:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDCE920873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T9j5yvBd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWdHUbx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCE920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gXCvwgJxXOGIlWI9w6VH3OVsLDdjVT1sF3VSMrsTO4k=; b=T9j5yvBd758/8c
	HPEH7oaghzGpePcStr4XDJk7Vw9q4gy4kVo4K+Q9SX7E7L1qt2VsFfQ01o4V/B3eu8kVnc254aZCB
	KhBHPd8Bqp99SMMB+ngV3nycerb88lFYaXdwM1JoZiS0cAvvMjIglHkBNvgWrWHeDu9uEjoR+gkBu
	fQXs8tiekhlNQ1VScZiMiwFeByaElP087L0LeJ0lTxeFpnN9ABCrUGioaiTdwtozC12EqVAED0+gz
	q3F/T5SfJb6yF3Fvf8jkf0PFgEpXIHP+dYxSZb4dOWfKoxm7/TxQ+ax7LfimltibbX9JHIoqRKHZq
	/dnPsCxcMerv7lutKmVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkJ7z-0001kM-Le; Fri, 18 Jan 2019 01:39:23 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkJ7w-0001jw-0A
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 01:39:21 +0000
Received: by mail-wr1-x443.google.com with SMTP id s12so13167033wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 17:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=RoDpLGt/KuvAAxZR5Vdi0q3IDW6U8xokDmpvZoP+z1s=;
 b=rWdHUbx8o/0qiZUncbladUXZaakO80ruHQVBkz290AwmQqvoFIvd3LddxqAPUM5RZq
 FjJ4P1sHU3Qm35hvyuWNaHBdZwBhuoVmL09dm39gZVUS5Ah6CsaXuepExP6bZXJt0hag
 JAYg1kerBAlfMvLkLL/shlQlDUihf/qCI33Xt9wgY91Of3HGGtMpKg0jY7PA1tpo+Wao
 uHuLL4stYdEA6jWhJ2Of6UpsYYm9KQWlrjx98ZCvQBYUH7LpJV6529qYz6p8tgqWTm+C
 DvKXap+e6Hywhz2lokksOAhoQDmT+bJvfhVz3yakh03vzJTyfCjpG6jh68alwDW/lcRR
 JJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RoDpLGt/KuvAAxZR5Vdi0q3IDW6U8xokDmpvZoP+z1s=;
 b=kmX4dAKXsRl+fynfYyj4aYMEbZeNzlbypCQp3Ec+yMEltGiI7L56PW+lt93HIzpcUv
 I/+Dz3H5vUrV7SrkpUlbMYKx4Rm+fvUFsdX/lYQe2CqqanHCJhRczXNuBN12iT7Hac6A
 +8PdAN8vdZVca/C0/66GsDXaJf9WJUVw2oYjZLBcY+sYyqKKYbvS35jzOEw1lkPT2lxk
 fy9f2c+OsgAMWp79tG+0zdSo+w15oZtPiIUpTHSQC8C1HKPO2rv+xfMx3lz2ZTU8wgVE
 HPWxuwOfMdrbW2GI2HB6okFSy9BZqPsU+LGCubHPWXDiSSA6CB57kakV9saK+p+VYUUc
 4s5w==
X-Gm-Message-State: AJcUukdM4Uz6526MWPxJYPg5k3LYSarI+dXMpHUlrB8+NuzDEmRtFz+4
 YMNvdt/bwhTAW405DL1su5A=
X-Google-Smtp-Source: ALg8bN6BASzwTX2eZ0xxbSp9KHhD1o2Ok1Ci1bGtYhlnXMkuLzqW7MuHknY1Oq4qFbspQwlljY2KbA==
X-Received: by 2002:adf:e284:: with SMTP id v4mr13706573wri.26.1547775555919; 
 Thu, 17 Jan 2019 17:39:15 -0800 (PST)
Received: from localhost (83-215-98-136.stmi.dyn.salzburg-online.at.
 [83.215.98.136])
 by smtp.gmail.com with ESMTPSA id k19sm125430966wre.5.2019.01.17.17.39.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Jan 2019 17:39:15 -0800 (PST)
Date: Thu, 17 Jan 2019 17:39:12 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [v2, 3/5] dt-binding: ptp_qoriq: document "fsl,extts-fifo"
 property
Message-ID: <20190118013912.skj4x5wmkbouekfx@localhost>
References: <20190117014936.48117-1-yangbo.lu@nxp.com>
 <20190117014936.48117-4-yangbo.lu@nxp.com>
 <20190118013434.qwuiqi5iwo5gw2nk@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118013434.qwuiqi5iwo5gw2nk@localhost>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_173920_040327_DC83C9A3 
X-CRM114-Status: GOOD (  10.33  )
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
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 05:34:34PM -0800, Richard Cochran wrote:
> > @@ -17,6 +17,7 @@ Clock Properties:
> >    - fsl,tmr-fiper1   Fixed interval period pulse generator.
> >    - fsl,tmr-fiper2   Fixed interval period pulse generator.
> >    - fsl,max-adj      Maximum frequency adjustment in parts per billion.
> > +  - fsl,extts-fifo   Required if hardware uses external trigger stamp FIFO.
> 
> Does this take a Boolean value?  Please explain the semantics.

How about this instead?

	The presence of this property indicates hardware support for
	the external trigger stamp FIFO.


Thanks,
Richard

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
