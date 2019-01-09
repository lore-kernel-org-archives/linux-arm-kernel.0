Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A18AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:27:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC1B214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qPiXhm8U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdbOH8Aj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC1B214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AIjuzIKHvFUeraNtciHKV5txsiUluPBEb965g8pVDSg=; b=qPiXhm8U6mKsh7
	I7sU5V/sp9Wv5dNLL2/qck6K6M7Y07f/KimsOcenvV1/XTPCtyZcszfouyqioMjy5CzvUOIEyX+1B
	4HuS0GWz5UlrFMSO9mFnDibrJcO33gVP8YDK4ZP2Z2fEiE4jLU0QRYU0MN0X7+y8//7TKhu/jjQnt
	qYHtS0dQh6FkU076MmVddf7emTZd6NTamTB73fgYfFUJ5WHzDIbX33ZOwS0O510Dox5alt0M5WFko
	lf8ZpYrXgcffJsMhXVVlQTbOY+wFSHJg4v+kXFPnEIUS6bDzcw4o+13PjFUGctoW5pDcpkz9XiHb8
	Btf4CBt6wRX27MYosqIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghA8Y-0004A3-1Z; Wed, 09 Jan 2019 09:26:58 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghA8V-00049i-0C
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 09:26:56 +0000
Received: by mail-wr1-x433.google.com with SMTP id 96so6902432wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 01:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=RaWwYbH1ZLMeeSx0rEqTI7NKzqRRlUJsZIQ0piLorak=;
 b=PdbOH8Aj0H1Vby/mf22jB4J5FB9EWvWXUWJ0tB5cGhTHRXBhMzi08nNGOCettLAWd0
 1WSA2N2wmlXUkO++Y03Pa68svptXRPMiGyfhLlHFPSg1NMCjx/z6QEgcHwaMO7zT7tW9
 +HHE8eI3asJ1XoW+KlSQwaxjmdawk54BMQEpclZLsrhOjRUyOjUwTS1UT0n0lSyrzdja
 Rc4cI13CjU4MenEZNbLlwX7JUdylAYEOEL/koDASKOOXHrZfMxSAHHBfmquh7Rhe4lgA
 arp5CGVqEIBH+l3PNsIMJHCX4bB0lEDlmZvKAfMsugR1Au8JjG2GF0/WzHIFc3ectaw4
 rwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RaWwYbH1ZLMeeSx0rEqTI7NKzqRRlUJsZIQ0piLorak=;
 b=ub79A94MiIgRDAwbjSTNlHte7SHEyaSBpKlEkbKiz7q9EGoU9Y+3BypxyKNu7pHWHY
 +A9aINLb3Nr4AotszlSBNOH8E+y00A0vXV8BiYBjxMMVAsuBZAFqnXGwx09fieWVA2wp
 ZlG2RHA13aAb9wT2+rH1NnRoVzjbz2G5mG3GqaJczOGWVFi/glPybvs2xiD+KlPwhnug
 DKWcxDXq7U8E1qeM6NV0tXFvcjBz77KfqCPuv+YvCYty0yrP+p0n3TSjDEhkG4GWy3C2
 GN0MQIw870wLssTTtHTaFGOp0wT5nCqiWBfdObuEM1O85KJMUHWruzkOsgD7kHv+q/0c
 QoZw==
X-Gm-Message-State: AJcUukcu/g6vy5LX7llDBznuE4NHSl/48z2u8p3OSlDOiPUszb+yAWoP
 gssU4Q3Y3AHhndXX1SpcQuU=
X-Google-Smtp-Source: ALg8bN6e/CJYZmAx/0H7MYAX69Ir/ChIYNoFpmT4eJ9nIxW5IJN0eCOq2X/otunx/iFjFbZXDvDXmw==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr4174268wrr.271.1547026012539; 
 Wed, 09 Jan 2019 01:26:52 -0800 (PST)
Received: from localhost (rytm-gw1.ter1.ncp1.par.cust.as8218.eu.
 [83.167.32.99])
 by smtp.gmail.com with ESMTPSA id f66sm12751155wmd.28.2019.01.09.01.26.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 01:26:52 -0800 (PST)
Date: Wed, 9 Jan 2019 10:26:51 +0100
From: Arthur LAMBERT <lambertarthur22@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: Handle pwm with sysfs with recent kernel
Message-ID: <20190109092651.GA27151@arthur-bzh>
References: <20190108100739.GA9046@arthur-bzh>
 <20190108222102.hwv5oekspifhj7bh@pengutronix.de>
 <20190109092531.71cf52c8@karo-electronics.de>
 <20190109092006.35364dwcfiindd7c@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190109092006.35364dwcfiindd7c@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_012655_066181_A7E0C515 
X-CRM114-Status: UNSURE (   9.43  )
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
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It is an error due to new check from this commit :

[arthur * dreem-linux-4.19] git show ef2bf4997f7da6efa8540d9cf726c44bf2b863af
commit ef2bf4997f7da6efa8540d9cf726c44bf2b863af
Author: Brian Norris <briannorris@chromium.org>
Date:   Fri May 27 09:45:49 2016 -0700

    pwm: Improve args checking in pwm_apply_state()

    It seems like in the process of refactoring pwm_config() to utilize the
    newly-introduced pwm_apply_state() API, some args/bounds checking was
    dropped.
(...)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index dba3843..ed337a8c 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -457,7 +457,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 {
        int err;

-       if (!pwm)
+       if (!pwm || !state || !state->period ||
+           state->duty_cycle > state->period)
                return -EINVAL;

(...)

I guess that I have to configure the period and the duty cycle before
enabling the pwm to be compatible with this kernek. I will update my
userspace code.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
