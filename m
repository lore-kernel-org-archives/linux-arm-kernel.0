Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCD7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:09:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFFEF2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BMB6H9sW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir3kaq5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFEF2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=277xSF4YfEG3ROMTjPBjKabvofANASf7ZrBiFVed2pw=; b=BMB6H9sWLV8zr4
	RKJH9vjHW9RA8+oVVGd5z1aFyBIaHWAOc0+507yovi4mdMOqrf6D7PDI9h2WnPWjiX+Scyx11rLwm
	q74XZgYkBjuq9iyyzoj3OMLl0+OQ2OazC6ACnb3c2bSRv1UNVisYAC8obeQne+UWWUgxObum4jyKw
	jFJg/CZfJmE0uHszXUBA9c4cY9RYWnbs4+516I4rta/2LCM1ayDE0F3VWPBlOc8UkEZe+yFygm324
	2EkqLfhhRYJ3+9PWgaIGxWPzE3eUx1zvb/FrwVEPnjV3ViPWuw6kAqfHiO9mcdYmq7GgFRvi0kdue
	EMzJEdrzL8LljzAX17ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwcrj-0004RL-3w; Thu, 21 Feb 2019 01:09:31 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwcrf-0004R1-L2
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 01:09:29 +0000
Received: by mail-pl1-x644.google.com with SMTP id s1so13195529plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 17:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XazLWlV0OGpxiqeWsTijGEnFhzyXIMqtdbgnm6gIsFM=;
 b=Ir3kaq5OJ38gwHc9MbQ93aEeS78o9Jb4ne68ygRM17PEd63kJOo+HfHEWvo2v6rFiJ
 KNYERTWt52IYRarCIpcC1mVk1oyBJSudCfe/mrer7nGIXxOQfMaIBZgPLS5E0qfkrTuR
 Ufcc+iHE+jP6nCO9LsKxSD5q7SBg9FiHsm2wuwXwH1rl5CqFTnOIsTsRYhJM99KY7ViM
 RDtd512mwClfGkHF+cFrWtS4roAOGZlMoAUDdXJCtPTQKqqgDUvg55Iz6UpGom9V5/tM
 rYjA6mpl3jFJNGylRInO0RX6Q8KhsMw2lnhEeJib7zATI8G10gN3XcdVfuDdZ2ooSgqO
 Krag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XazLWlV0OGpxiqeWsTijGEnFhzyXIMqtdbgnm6gIsFM=;
 b=b+HGSoxK+fKGoRGV7e/5dDo8L81k7gU+FYMReKNzIhSuJnjvc7MSL8fTmbvsIPHn5e
 v14OpLS3MXLL8P5Tv47KoMsopUIJWgMknJlwwZw2f+Hql74nuBdr5DThtpHHDCFJCgWV
 7JOVe6NH98STwkhoCW6vIjuDL/2g1plKlVbP0WV159m3VSOqkvC/bqS3VAmTr3RsoLJe
 gfmBgOJJAiteNoLOSIIjLX4Q88+3dWeJmC8mpfdR6HnyV9s/ne8VO7iZpBIlP52IKHIJ
 dpbsMp+iD324JyYrNNMlZ0HILtmlV1j4iaXaKmit3jVBC5EWcTOtbBG6W+4wTrTzTbHV
 w+XQ==
X-Gm-Message-State: AHQUAuZbZ8Kk47us7RuclSBux53ThCbQdyRG8XP8CwqGYrhpxktoRsN3
 aWmzTrR5PdNFR77ayZ4RW5c=
X-Google-Smtp-Source: AHgI3IZYhlTQw7CzP9sWgh7rfxqpLNlgl3p6nVnERXteNg31B4yHe6oKSgrg84EyP7emiFpwT7JXKQ==
X-Received: by 2002:a17:902:9a95:: with SMTP id
 w21mr39384222plp.118.1550711366749; 
 Wed, 20 Feb 2019 17:09:26 -0800 (PST)
Received: from icarus ([2001:268:c0a3:577d:c70:4af9:86e2:2])
 by smtp.gmail.com with ESMTPSA id d23sm26808746pfn.180.2019.02.20.17.09.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 20 Feb 2019 17:09:25 -0800 (PST)
Date: Thu, 21 Feb 2019 10:09:54 +0900
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 5/8] iio/counter: add FlexTimer Module Quadrature decoder
 counter driver
Message-ID: <20190221010931.GA3471@icarus>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
 <20190218140321.19166-5-patrick.havelange@essensium.com>
 <20190220164154.00547a77@archlinux>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190220164154.00547a77@archlinux>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_170927_710971_7E0437F0 
X-CRM114-Status: GOOD (  21.85  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, Patrick Havelange <patrick.havelange@essensium.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Esben Haabendal <esben@haabendal.dk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 20, 2019 at 04:41:54PM +0000, Jonathan Cameron wrote:
> On Mon, 18 Feb 2019 15:03:18 +0100
> Patrick Havelange <patrick.havelange@essensium.com> wrote:
> 
> > This driver exposes the counter for the quadrature decoder of the
> > FlexTimer Module, present in the LS1021A soc.
> > 
> > Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> > Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> Given you cc'd William, I'm guessing you know about the counter
> subsystem effort.  I would really rather not take any drivers
> into IIO if we have any hope of getting that upstreamed soon
> (which I personally think we do and should!).  The reason is
> we end up having to maintain old ABI just because someone might be using
> it and it makes the drivers very messy.
> 
> I'll review as is though as may be there are some elements that will
> cross over.
> 
> Comments inline.  William: Looks like a straight forward conversion if
> it makes sense to get this lined up as part of your initial submission?
> You have quite a few drivers so I wouldn't have said it needs to be there
> at the start, but good to have it soon after.
> 
> Jonathan

I agree, we should try to merge this as part of Counter subsystem
introduction rather than as another IIO Counter driver. As we determined
when adding support for the STM32 timers, the existing IIO Counter API
is fundamentally unsuitable for representing counter devices. So
regardless of how a new Counter API is merged, the existing IIO Counter
API must be deprecated.

Patrick, I apologize for the confusion this has caused. Would you be
able to convert this driver to use the proposed Counter subsystem API
from this patchset that I believe you encountered before:
https://marc.info/?l=linux-arm-kernel&m=153229982404051

Although it was last updated in October, I believe you should be able to
rebase that Counter subsystem introduction patchset cleanly on top of
the IIO tree (if there are any merge conflicts send me an email). Take a
look at the generic-counter.rst file under the Documentation/driver-api/
directory for an overview of the API; the counter drivers under the
drivers/counter/ directory also make good references.

If you have any difficulties understanding the API, or any other
troubles, don't hesitate to ask. Hopefully, I've made the documentation
clear enough to make the conversion of this driver quick and easy -- and
if not, then it's something I need to fix, so let me know. :-)

William Breathitt Gray

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
