Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD987C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:23:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA252083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kRLZpW+n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EEH9Hdsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA252083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xrWUIaFFq4tAKC+XOgy2sTX9Hk2Ats9kAnuLSAPTpJ8=; b=kRLZpW+nmhIAaj
	aQVagstG/pbjmTXNlG8h8SWU581cQCz3/wMFObe/1GKMMt4C2OZyTolCrm/Cx6tkGWN8OW5jEtkQi
	SR9ahZ/5Sa8VcRlEL3+A80SRQ9eMmdRbYrBmArOFU+FuqEs950zIGy58ZBfFAiCMRqi1FLE50ZvFd
	awBortsnvikk3yau11ZGa9VGdyAQlyraI1TIGD+zOSWQrvzRzVm/To8zIiUiAYrEijYIcyY4xZgep
	pJnroxx0gGKKwqbPhbX9gJy7ra3cF7ZD1QVXyw5K+1SMZwnKvqfSdJJi8rrmGTV4ipRJe5OQXTzuK
	vnb7N82rwv+T399DGZrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKmr-0000Vh-Kn; Fri, 07 Dec 2018 18:23:41 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKmo-0000Su-Tt
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:23:40 +0000
Received: by mail-oi1-x243.google.com with SMTP id x202so4088090oif.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 10:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=C3iYoehPwImYu/9kH0TYkgSKPGg2mJZNHj5lLOW3DvI=;
 b=EEH9HdsmgA8uZ46E9wMZYwuIwg/w943XXJkgHh2yGxwSMQMJVTeYdU8XcRjG04mHbP
 dNjcRU7ZezrWGFT6hyHM7l/48B35XACiBNHtOLrmCxybpcejZiLtBZ5Cn6MzvrTRPnoh
 36zc4l5U6eIaz++eTLprr462QV4GMmAprNK8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=C3iYoehPwImYu/9kH0TYkgSKPGg2mJZNHj5lLOW3DvI=;
 b=AWYsmZY7x5R4O+pOsNzH+oG69IA/ODt8hXRIO2QFUxFP0sJ/FpzZjIg0bhUWxNJd9/
 4GamG+qYLkNbackMpdisjH0so2Yxq9tl+D+TvlnKo2i7a4pUPrcEkKKXngrj//paG2i5
 ShnsZga5YT0lraMMylAPnkEw8jSPD3gUhuM36iYF8lPWDDybEWFbybv4hn7L01iqRGsS
 A3dqXodMssAZdA9yQUtw7TdEkbhjaKYTqOvqpgPfVW4IqIpLd83x4XO+Zf296FaFRRlO
 tAGE/jTCoPi37zhZNr+5tiDqEWwFNEsdNv9j2Bs6ePDDRkpm9f48Ym42Ms1bao309Ltv
 cloQ==
X-Gm-Message-State: AA+aEWbfPkAbfmREmFtLHVVY6CTxzEB1RgEo4zKgZqPTVboB8Z44aOpd
 WcuP/T39de+V5Mk0VFgqQIRZ0Q==
X-Google-Smtp-Source: AFSGD/WaRvsiZ1XalDXVaBeEIDRSzgQCgC7j3TurvrOP3FwoQJOx6M3iiMPJChaYLwHbrkuDHC3uXA==
X-Received: by 2002:aca:b5c2:: with SMTP id e185mr1766920oif.125.1544207007229; 
 Fri, 07 Dec 2018 10:23:27 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:1524:ebd:d530:a61b])
 by smtp.gmail.com with ESMTPSA id a52sm2097032otc.51.2018.12.07.10.23.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 10:23:26 -0800 (PST)
Date: Fri, 7 Dec 2018 12:23:24 -0600
From: Andy Gross <andy.gross@linaro.org>
To: Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: msm8998: correct xo clock name
Message-ID: <20181207182324.GD5497@hector.attlocal.net>
References: <0ba54ffd-1d47-5ae9-ae9c-4a03d57e6ff3@codeaurora.org>
 <20181205164843.GB1492@tuxbook-pro>
 <05b9ee40-d51e-3f80-8ca4-217fa6fbd51c@codeaurora.org>
 <154404384283.88331.2522037578224950651@swboyd.mtv.corp.google.com>
 <14cad8f0-7388-16a0-b1ba-4cd5a469a17e@codeaurora.org>
 <154404615332.88331.10043835293734703587@swboyd.mtv.corp.google.com>
 <cdeb3962-81a2-48dc-9b75-d97a817a0da9@codeaurora.org>
 <154412124335.88331.16092762627424651997@swboyd.mtv.corp.google.com>
 <00756abc-6e60-41cb-66bf-a7c9770dc2c9@free.fr>
 <8a1ec3da-0c07-7c05-cf5b-f1fef001c972@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8a1ec3da-0c07-7c05-cf5b-f1fef001c972@codeaurora.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_102338_965330_187FF7F9 
X-CRM114-Status: GOOD (  22.49  )
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
Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>, Stephen Boyd <sboyd@kernel.org>,
 MSM <linux-arm-msm@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 07:58:52AM -0700, Jeffrey Hugo wrote:
> On 12/7/2018 2:03 AM, Marc Gonzalez wrote:
> >On 06/12/2018 19:34, Stephen Boyd wrote:
> >>Quoting Jeffrey Hugo (2018-12-05 15:04:01)
> >>>On 12/5/2018 2:42 PM, Stephen Boyd wrote:
> >>>>Quoting Jeffrey Hugo (2018-12-05 13:20:07)
> >>>>>On 12/5/2018 2:04 PM, Stephen Boyd wrote:
> >>>>>>Quoting Jeffrey Hugo (2018-12-05 09:03:54)
> >>>>>>
> >>>>>>I don't quite understand the patch in general. The xo_board clk should
> >>>>>>always exist in DT and the fixed factor clk in GCC is there until the
> >>>>>>rpm clk driver can control the XO clk state vote for the kernel.
> >>>>>
> >>>>>Sorry, this wasn't apparent.  It doesn't seem like this "requirement" is
> >>>>>captured anywhere.
> >>>>
> >>>>Agreed!
> >>>>
> >>>>>
> >>>>>As far as the SD clocks are concerned, they are defined in GCC, and
> >>>>>eventually have a root parent called "xo".  "xo" isn't defined anywhere,
> >>>>>so the SD clocks can't really be used, and the hardware doesn't come up.
> >>>>>    This patch "fixed" that, but I missed the link to the rpm driver that
> >>>>>Marc pointed out.
> >>>>
> >>>>Hmm ok. The SD DT node should just point to the xo_board clk for now and
> >>>>later on it can be changed to use the rpm clk when the rpm node is
> >>>>created.
> >>>>
> >>>>>
> >>>>>
> >>>>>>
> >>>>>>If anything, change the DT node to be named xo-board instead of xo_board
> >>>>>>because that matches DT naming schemes and then add a clock-output-names
> >>>>>>= "xo_board" property to it so that we keep the underscore.
> >>>>>
> >>>>>I see this now, and I agree with it, but then SD goes back to a broken
> >>>>>state because there is "xo" clock for GCC.  Its not quite clear to me
> >>>>>how to make GCC (and thus SD) happy again with this change reverted/fixed.
> >>>>>
> >>>>>Bjorn mentioned offline he is going to take a look, but he has a few
> >>>>>other things on his plate first.
> >>>>>
> >>>>
> >>>>There is an XO clk created in drivers/clk/qcom/gcc-msm8996.c, we should
> >>>>do the same here until rpm can handle this. I'll pack this patch up and
> >>>>merge it to clk-next soon.
> >>>
> >>>Thanks.  I pulled in the below change into my tree, and fixed up the DT
> >>>based on the discussion we had.  SD works, and things look sane to me
> >>>per clk_summary in debugfs.
> >>>
> >>>Feel free to throw my tested-by on if you want.
> >>
> >>Thanks. I did so and merged it up to clk-next.
> >
> >@Andy, don't you still need to revert 634da3307b083ee83eb9b377081fdfd6416a148a
> >("arm64: dts: qcom: msm8998: correct xo clock name") in for-next?

I'll send a fix for this.  I think we want to keep the xo label, and just change
it to xo: xo_board.  So instead of a revert, it'll be that + a Fixes line.

That ok?


Andy

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
