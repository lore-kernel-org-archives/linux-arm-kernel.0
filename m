Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81B3C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:37:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF5E218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l+dz35gN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHpYfEo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF5E218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FhmDLZy3eICLKz+zplE6wld3YUCkc03w1eVkM7qnlzo=; b=l+dz35gNasHiO3
	8edpyjTy3UUV1H38fvNUK6KkkbotZgXOULYOUzyMUgF3b40MEqV15+lxY9HKSBrOwLbXMc2OMVXaL
	1lEVUxLSnKHADlTAEFdWHmijzLU4W7sV6HxDwirRMjBIFYkI5NHmeSDYmzRR2gvKnpDKlnaSPNAC+
	YTPZYsdq3Ec9ygwXnroYRgzq5jz4oQBvXtRIJgULSXHUujNMl6lW90VreUg0Q9JgnkhtF0l7/zARx
	q9PmnBMCBbmDhFOPwLlc2usvrX9U5Aw8jNUi2vyCVeoXDZkGEFBW3c+epyI7YSB72By9u7/j1AbnQ
	4AgT1MToOyed9h05WTig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp8mW-0004m4-BD; Thu, 31 Jan 2019 09:37:12 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp8mS-0004li-FU
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 09:37:10 +0000
Received: by mail-pg1-x542.google.com with SMTP id n2so1132195pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 01:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tes1xOM6xvBzoz8vsWFdl1gZjnjCSAWcQcV+Fxh9rh0=;
 b=KHpYfEo+JXhEzb5TasA5pOp9S+aIFFPYLGJHwRpBUswT0iYZkgrcdkoscHx5pg5gMr
 mcKXhsiShR1L2+X4aEDQO27j8kystnfPz2s8XUw8ENWPU/cIuUOenALlkSXCgS0oGtID
 RWYFSq4fh7dqffmWHl3ORJzflARyxUqVXjgrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tes1xOM6xvBzoz8vsWFdl1gZjnjCSAWcQcV+Fxh9rh0=;
 b=JUgmsNTvidYw0cL6kPPaT+s2IhEzjmKT/usqxICeHqPrkmao0pNVV9zg+cUdzfqX/N
 bHGdTWKzKWX8AbywUmdh8FEJm/c/SYeZ1V1U5/ngLqdg+/nyev1yk4N9Vk8tfpv0pWOU
 iGIbO/jyr5NDW1XglOTyciaF7N6EjBKS454LwF8hwwq2KrxATPg1d8V8IKofK8BVgKTS
 1MO76OD9EucvcvkgwrEAFLWrD7+EztbQV7WN79o/yyMZddYhcgj86g38F5hrqoCWVc7l
 ehnpexgl6EJqeAHKwE7avdA6+oS3UlGZnWIYYIHcP0A96CGKHU1eel+W5TidFwnnDwRs
 KHjA==
X-Gm-Message-State: AJcUukcv+HlYgPaiwC4SVQt/Yi044HZuW7ayoEQiBjB44YP8QG8cu7vV
 sBE2Zz4Bb9bZzFzimmgHwEfP21F90M4=
X-Google-Smtp-Source: ALg8bN4Vd5QYGg/Bxhw0luhjSWJkPM/Xaw3w69itzt67uTY5Cq3rzivScoP4tcIwt7y0RPQwrasJhA==
X-Received: by 2002:a63:e302:: with SMTP id f2mr31139128pgh.320.1548927427539; 
 Thu, 31 Jan 2019 01:37:07 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id x3sm9769773pgt.45.2019.01.31.01.37.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 01:37:06 -0800 (PST)
Date: Thu, 31 Jan 2019 15:07:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v2 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190131093704.43wzrwshscvdtoj2@vireshk-i7>
References: <20190130170506.20450-1-quentin.perret@arm.com>
 <20190130170506.20450-2-quentin.perret@arm.com>
 <20190130190703.GM81583@google.com>
 <20190131072209.nhbgid3cystvr2p5@vireshk-i7>
 <20190131093418.umsbh4eevgod42sh@queper01-lin>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190131093418.umsbh4eevgod42sh@queper01-lin>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_013708_528096_AE65B458 
X-CRM114-Status: GOOD (  13.66  )
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
Cc: nm@ti.com, linux-pm@vger.kernel.org, sboyd@kernel.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
 sudeep.holla@arm.com, dietmar.eggemann@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 31-01-19, 09:34, Quentin Perret wrote:
> On Thursday 31 Jan 2019 at 12:52:09 (+0530), Viresh Kumar wrote:
> > On 30-01-19, 11:07, Matthias Kaehlcke wrote:
> > > On Wed, Jan 30, 2019 at 05:05:02PM +0000, Quentin Perret wrote:
> > > > +static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
> > > > +					 int cpu)
> > > 
> > > why __maybe_unused?
> > 
> > Yeah, it isn't required I think. He probably added it for the case
> > where CONFIG_ENERGY_MODEL=n, but even then an inline routine is
> > defined which will accept it as argument and wouldn't do anything with
> > it. Had it been a macro, we would have required __maybe_unused but not
> > now.
> 
> The thing is, the EM_DATA_CB() macro _is_ stubbed for
> CONFIG_ENERGY_MODEL=n:
> 
> https://elixir.bootlin.com/linux/v5.0-rc4/source/include/linux/energy_model.h#L165
> 
> So, without __maybe_unused you get do get a compiler warning.

Yeah, I almost got to it and still missed it :)

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
