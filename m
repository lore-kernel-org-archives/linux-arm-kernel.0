Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE85C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 03:32:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D1F20818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 03:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d4oy2Vbj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xTtZ+wYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D1F20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h3HAuBtSpkpW2pi9/5RuowSbvP5nu3t6CPYXZYTZUtg=; b=d4oy2VbjwLodTX
	oJ7oOlbdTV1a7ZdVGUd0P4zVbbHpazO4MupHzBU/Bm8OS7r+aeb4Gro/6ILcIUUHEKZFs0Dn2q0KU
	2e9Xf0TnTAJrrvuC93JTZPNNaS0CDB1ov3fxOa0yhinKNfIQG1SPWh8L9yPlKq9UIzqUkGxZWsK5/
	gnuzpFb8bAOXDnHN2/kzPX8mCG4HEOon0xZX3PDzJP0x+NUHzOuFiTvXrYOYKxZkSB7utuZMaoKgN
	vc65V6hF6kZ/Or1kwTv79iDtPPWBRhICc2PiM7ZbQRE7hOtAeNbP1T6AcPEEFmYZGjLoqpD8h+vBw
	a0LBSorlKMJDnUXiwMrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx1ZK-0007Rx-4g; Fri, 22 Feb 2019 03:32:10 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx1ZG-0007RV-R2
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 03:32:08 +0000
Received: by mail-pf1-x444.google.com with SMTP id i19so455251pfd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 19:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=B9uwIRcVz5urEkzMYKYdg53H6TOvhjRNvVjnwubr70I=;
 b=xTtZ+wYDg4Mqi+CHWF9sXGvv8+guT2o5aI0RA88OW0xeFQGe1KHGWfPZlO4Fjb0rOL
 KmaVHZe7cMYDib76K+hErqmri24jpKxXRlL1BtIiu0rtC6wn2SFHekCT85yhDTPz6XhA
 wK91Xpx6SIg1RikAG4/YDzPIT2Q4ItrUBy0E0C+6ifDeoGZs1nsAWvDPS8LgDSndMPxU
 4UFSEOceNdnm/bidZiC+BUOGuvtqz+0quOum68O6Ol8wt/Wr5vVFu7Y34kaDjN4//y3u
 fezroLgK7+MgwcYBaiG+Ft8873+uDWLqHw3NPBA58fT2d+3Yl0atYtpxAU278d3Y2z9l
 i7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=B9uwIRcVz5urEkzMYKYdg53H6TOvhjRNvVjnwubr70I=;
 b=mxXjKCVn6k0mwewjlXeo4YqUHRqR6/bom6AiN0uH++/ShjWSbHomDBu0W9XU1Jb17+
 ShcOqLWXrKbXcpyCX/gd2gFcS2d5Dk1L3DJEpRW140CqC1QYX4vpAR/yQoEY1cMMrMJT
 K4UvajvO9x38ZBFuo6UZfez0qNC7++eYPFAEb0nRY7o/hVfTeSXn4CRj76SER7mtCO+e
 OnMT8fVjX7C3WJCuYwv5i5cuSQb2DQgy0eWYNDseoPBXCPO3yxAobfRIckqD0plk5HnA
 sqUahfwJiqjbsZtV4k+wC08B7YrbTseSv24hHJRHb90SEYQy7435nQy5bSqv70DqPL8h
 FDXA==
X-Gm-Message-State: AHQUAubz+vBdBFXIxdCSVJfTH/XLWo+SZeG5vtc9oO8jPW2Se8TeSmiJ
 aL2VYkyn4l8pHlWMxGWWMm5wSOYnL44=
X-Google-Smtp-Source: AHgI3Ia2oYUPq+Cb/eaxZPWX2/zLhp1KRMB2nE4KJwOoCpd2Z71LNKfVfyJ9y+nIi75oaKfFw7I5vw==
X-Received: by 2002:a63:f253:: with SMTP id d19mr1910347pgk.14.1550806325556; 
 Thu, 21 Feb 2019 19:32:05 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id z67sm325535pfi.152.2019.02.21.19.32.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 19:32:03 -0800 (PST)
Date: Fri, 22 Feb 2019 09:02:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [BUG] cpufreq/armada-37xx: Parent clock issues after boot
Message-ID: <20190222033201.qdod733xtnwptxev@vireshk-i7>
References: <20190124103052.dvkg43uwieejoupo@vireshk-i7>
 <87imychbci.fsf@FE-laptop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87imychbci.fsf@FE-laptop>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_193206_906916_9E6E75D4 
X-CRM114-Status: GOOD (  13.83  )
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
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, rjw@rjwysocki.net,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 25-01-19, 18:54, Gregory CLEMENT wrote:
> Well the idea was to modify the DVFS register before we enable
> DVFS. Indeed modifying the parent clock of a CPU while we use it could
> be a little tricky.
> 
> I have some ideas to fix this issue: I won't use anymore
> get_parent/set_parent in the cpufreq driver and I will set the DVFS
> parent clock during the initialization at the clock driver level. I need
> to do some tests to be sure of the implementation and once it was done I
> will CC you with the patch for the fix.

Hi Gregory,

I was wondering if you had any updates on this as it has been almost a
month since you shared an update.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
