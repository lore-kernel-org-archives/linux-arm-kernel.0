Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8308C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:59:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F5920863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hcrjrT88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F5920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wagor+k5UhlGFdRRTOJWjEiAezvPTEuMmgLn5lB5cy0=; b=hcrjrT88SH6q6o
	m13qM5fyLxzyk6elsqdL5Bk6+U884XkTUHeVBnbWjcQ6Mmp3U3WzftadfmzpZKRg+qZRvDgT5M2vv
	kzlho5eY2Ag7p/wIf+dEtSZAr+UWgubrPRg7aW8ZrH7IrqCYc8eYIZ9369LEkKA3F/cF8Pu8IjjhK
	6mW864qJhWvV87UEdFaUZrTGIgc6QfxiRHR7Rp6UbcCWGJKR5GkxsSTgb75TXSEuGutQs002gUvm4
	ifB9nuVSo71zvWyCeaQVY8XJaZ6C3gUQGuVbse2xy/J4v2VxNKO16rsYjg1R0OhH0coJAlriHGPXr
	T9tPf5ElCaTkdF8pulxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSiOC-0007uS-OG; Fri, 30 Nov 2018 12:59:24 +0000
Received: from mail-lf1-f68.google.com ([209.85.167.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSiO9-0007iW-9T
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 12:59:23 +0000
Received: by mail-lf1-f68.google.com with SMTP id n18so4036121lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 04:59:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3PBES0o25j0R3KuNWiCqbV0Pcf3QS+yZgteXEsuSXZ8=;
 b=oRJ2zpt5lAErhNyBlcfgwo8Gx05LaldSg4DXEsyA4fGhnNayklWgXJUdFrT5yKpsLf
 UVcjmPYqYoHvUuCNzh5ca+r85SCmJUxgZPajm65MQk/ssEgPGYfDyZlXhE+rTm+b1ZF7
 2fjOYL5MBnsQLq76Cvdr59q3tXkPHc7SI5Bx1tolJbKZUa1Qerp8SsbbORjrkGH8uVzo
 QN4yekQ5Cu7+e4E6muwbRBOs41aiWbBlDjXzLMkKK2NBZ1CJjqoIik7UQq4HNMV+FQRJ
 48lDtf6rXmBtBGXVHPytMLTqe47apyhz7DkPtXsBUTEaDdBWV+oSWN343gV1wjVD+NwZ
 2SEg==
X-Gm-Message-State: AA+aEWYrTZkoHl1RWLO6BTJTtm+ZUvt/MI1l8VzFHRHbFDPsX7KcwGNv
 Z8Mj9UlTH8o3vrV1TNnL5Ds=
X-Google-Smtp-Source: AFSGD/XUiaAMpzZfguwDPiwPS9jtMBxEXbXIneh2pJooWUG0IcYe98IX/NgzNHlX+gA7em5dYlAcRA==
X-Received: by 2002:a19:518d:: with SMTP id g13mr3492997lfl.143.1543582748224; 
 Fri, 30 Nov 2018 04:59:08 -0800 (PST)
Received: from localhost.localdomain (84-253-205-125.bb.dnainternet.fi.
 [84.253.205.125])
 by smtp.gmail.com with ESMTPSA id m77sm805038lfg.3.2018.11.30.04.59.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 04:59:07 -0800 (PST)
Date: Fri, 30 Nov 2018 14:59:04 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 1/8] clk: clkdev/of_clk - add managed lookup and
 provider registrations
Message-ID: <20181130125904.GB15388@localhost.localdomain>
References: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <ec0d6ee7ea79f0e05041ed3e564b0aadb297ef5f.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <154356805035.88331.16867826308376667832@swboyd.mtv.corp.google.com>
 <20181130105022.GA15388@localhost.localdomain>
 <20181130110653.GF30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130110653.GF30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_045921_327840_401B7984 
X-CRM114-Status: GOOD (  20.37  )
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
Cc: linux-doc@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Daniel Kurtz <djkurtz@chromium.org>, Sebastian Reichel <sre@kernel.org>,
 David Brown <david.brown@linaro.org>, Lee Jones <lee.jones@linaro.org>,
 linux-clk@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Andy Gross <andy.gross@linaro.org>, Huang Shijie <sjhuang@iluvatar.ai>,
 Guenter Roeck <linux@roeck-us.net>, mazziesaccount@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
 linux-kernel@vger.kernel.org, Akshu Agrawal <akshu.agrawal@amd.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 11:06:53AM +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 30, 2018 at 12:50:22PM +0200, Matti Vaittinen wrote:
> > Hello Stephen,
> > 
> > Thanks a bunch for taking the time and reviewing this!
> > 
> > On Fri, Nov 30, 2018 at 12:54:10AM -0800, Stephen Boyd wrote:
> > > Quoting Matti Vaittinen (2018-11-13 03:55:58)
> > > > With MFD devices the clk properties may be contained in MFD (parent) DT
> > > > node. Current devm_of_clk_add_hw_provider assumes the clk is bound to MFD
> > > > subdevice not to MFD device (parent). Add
> > > > devm_of_clk_add_hw_provider_parent to tackle this issue.
> > > > 
> > > > Also clkdev registration lacks of managed registration functions and it
> > > > seems few drivers do not drop clkdev lookups at exit. Add
> > > > devm_clk_hw_register_clkdev and devm_clk_release_clkdev to ease lookup
> > > > releasing at exit.
> > > 
> > > Please split this into clkdev and non-clkdev devm functionality.
> > Allright. I'll split this to two patches.
> 
> Definitely, please note that clkdev is separate from the common
> clk stuff, and is actually maintained by a different person (me)
> although I currently defer much of the review to the common clk
> guys.

Right. This clarifies how clkdev is maintained. Thanks for letting me
know. Is it still Ok to do these changes through linux-clk tree or is
there some other tree where the devm portion should be submitted? If so,
how should the dependencies be handled?

Br,
	Matti Vaittinen

> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
