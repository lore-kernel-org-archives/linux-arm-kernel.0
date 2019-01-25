Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D68C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:07:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A67AA218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BDNQnNO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67AA218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DzLYRqpt/84HyXlbmiuEf93zH7bRFUoTpcjoXAYpa7I=; b=BDNQnNO4RGuNof
	kRrCYwlBUiSFsubr9uSyQ9eayIrETYrYkPDi5lvUs50e8mWdSCfz6Mp6FkRx6e/U2U+0YMS0kisIo
	KFZ7MGfEE+4DKQkxnlvHTq8eDt9uUBWxIHID2Ep12Jiue6wNGLHaFapN9REhkCx8jJHs+7enj3Zpl
	BgAc1jn+PkpYqOv9gsYNcUOE44n2T2RubJTpAhAFHBjX/RHG7D9FBj+kR5XkU4q//wdsp5OhGyiJd
	Twho+kPRyh+yahHB3Ke9P7u/MRZKjgWhOzi+GLlv/QFpFgXrh8qmo36YshAlxm6Lwf/WS1tSaZmHx
	vFjv5BxENe7SorRWDeXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn1Ch-0003BB-Jw; Fri, 25 Jan 2019 13:07:27 +0000
Received: from smtp1.de.adit-jv.com ([93.241.18.167])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn1Ca-00031Q-F2
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 13:07:25 +0000
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
 by smtp1.de.adit-jv.com (Postfix) with ESMTP id E60343C013F;
 Fri, 25 Jan 2019 14:07:11 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
 by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bfnwS6jx0r29; Fri, 25 Jan 2019 14:07:05 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 91A6F3C013A;
 Fri, 25 Jan 2019 14:07:05 +0100 (CET)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.435.0;
 Fri, 25 Jan 2019 14:07:05 +0100
Date: Fri, 25 Jan 2019 14:07:01 +0100
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: How to remove warn msg "cache: parent cpui should not be
 sleeping" i=1, 2, 3...
Message-ID: <20190125130701.GA855@vmlxhi-102.adit-jv.com>
References: <a793d088-2faf-3ea8-41b6-f0b614a71e19@arm.com>
 <20181002170754.GA10240@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181002170754.GA10240@vmlxhi-102.adit-jv.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_050721_196778_F1BAE7C7 
X-CRM114-Status: GOOD (  10.90  )
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
Cc: Jisheng Zhang <jszhang@marvell.com>,
 Steve Longerbeam <steve_longerbeam@mentor.com>, linux-pm@vger.kernel.org,
 Eugeniu Rosca <roscaeugeniu@gmail.com>, "Rafael
 J. Wysocki" <rjw@rjwysocki.net>, Eugeniu Rosca <erosca@de.adit-jv.com>,
 linux-arm-kernel@lists.infradead.org,
 Joshua Frkuska <joshua_frkuska@mentor.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sudeep,

On Tue, Oct 02, 2018 at 07:07:54PM +0200, Eugeniu Rosca wrote:
> Hello Sudeep,
> 
> I too experience the "cache: parent cpuN should not be sleeping" and
> confirm these are healed with your patch. Would it be possible to have
> the patch submitted for review?

Doing some s2ram testing on R-Car H3 Salvator-X using
v5.0-rc3-130-gd73aba1115cf, I am still able to reproduce these warnings.

Is there any chance you push the patch to the mailing list? If not, can
it be taken with a different authorship by mentioning this discussion
thread as source of inspiration?

> Thank you very much,
> Eugeniu.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
