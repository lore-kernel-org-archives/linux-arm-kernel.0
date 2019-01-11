Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B202C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:54:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D2720874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kKqWPoOP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIcnHl8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D2720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MKft5or1E6Zharl8NOl6jaeiRSj2hb+XC38u3DjLbb0=; b=kKqWPoOPswnnua
	6xMXkKBd+MphBEBaoMkWs3NCQhyrm6QO+I2PiPbpuqMQcVlfg0+/B6JWHFarzHFiovIEZvTZ0QInb
	1sCsMO1FbF9kayhVXOak51DR3Q/skGd3vLF/yShQJsW0mPHgGdC0CYS4i7I9P81V+1qq2h2yi1KQl
	koMRr56c+PRA4TtsiZt3+f4JkM7QFm7n3e3dgEcG6JkZpOaGY254MiHcAohA+8+WZxsQR1qMwyvsj
	fXi89LVOrZNo6AGY3bI7ihTj41DP1/phOg8rEOg7pwOiW6BNa9H3CdCtEmxb3OcX9JM9D6xeF4iZX
	fvzypiMXmFBzf3fmDWeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtWP-0001Du-MC; Fri, 11 Jan 2019 09:54:37 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtW7-0000wo-Se
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 09:54:34 +0000
Received: by mail-wr1-x442.google.com with SMTP id q18so14446087wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 01:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=nkf9/5iA3E6KP4iOorpGJNEgxsrAnhqFpwiLvHdb7lg=;
 b=EIcnHl8JnL0fqQn6uGpdUkzn36mc3hQ2zifOp4JPzxmLwiO179GzbCLnpmHFcuHQ93
 Om/0KyMNA3UA4rccGU96pgfJwY3lP8g4BK4p53L2e5+5zmNtLR1Rn34ZCdxEjcRW085h
 Di0rxMiUcUAbPXz5yYHlNdQWZSC7TWATRptao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nkf9/5iA3E6KP4iOorpGJNEgxsrAnhqFpwiLvHdb7lg=;
 b=uIzy6YYR2aiTQH4cAXDOW5A9CAi6XNw+5W79eAv0+bcX8mMdtGze1DcCumEwE9zCc9
 9u/bClfkRje+z7iAFCU7Lg5jd/nvhm2hBHkJafTZe2wzOxPphxZL2fhCfzTV29YDkxrs
 ycyd794+o7fu4OtbnhSO7KFnI8/WT1X0QAt1bgV6KsS5cVJSR7MqVvEVWeelrCNWoRKf
 OLVUYwEQC8KLT0REHsiwY73iKmetFQ0dAMxW3bbzGSucJnEbxiXmtOKHeW56MhBxNgB6
 /zD/0ptpT5uxtvfHboXlqrTSVAqe/eu/hE9wYduqdYx1MMDUDOMA3cU8Fxm2cGYYo0Ki
 odeA==
X-Gm-Message-State: AJcUukdoVGluEvo4IfkdVMGpM7td7Rq0KA3dmTSjpW8P7W4WK3r1EAbq
 QV+rYqTZYyxmUOcJAjJfhazurA==
X-Google-Smtp-Source: ALg8bN56GVH2/sjleOq169ZKaNQdMURQeexzxkatzs56pWJTpsTbQdDVeUtfDiZH6iITIsZSaqx5vw==
X-Received: by 2002:adf:b307:: with SMTP id j7mr13532668wrd.46.1547200457315; 
 Fri, 11 Jan 2019 01:54:17 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id f137sm18810289wmg.29.2019.01.11.01.54.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 01:54:16 -0800 (PST)
Date: Fri, 11 Jan 2019 09:54:14 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2 3/4] tee: add supp_nowait flag in tee_context struct
Message-ID: <20190111095414.nbnzbocdn32zypdc@holly.lan>
References: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
 <1547123097-16431-4-git-send-email-sumit.garg@linaro.org>
 <20190110142355.bcgw62w2qk2mlzj6@holly.lan>
 <CAFA6WYPzA+rKMq58xVPghSe-mLa6fDi4t=1DYxakEaeG+ayQug@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFA6WYPzA+rKMq58xVPghSe-mLa6fDi4t=1DYxakEaeG+ayQug@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_015420_945692_BF81D37A 
X-CRM114-Status: GOOD (  14.82  )
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
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bhupesh Sharma <bhsharma@redhat.com>, linux-kernel@vger.kernel.org,
 tee-dev@lists.linaro.org, Rob Herring <robh+dt@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, mpm@selenic.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 01:00:49PM +0530, Sumit Garg wrote:
> On Thu, 10 Jan 2019 at 19:53, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > > index 9ddb89e..5d6c317 100644
> > > --- a/drivers/tee/tee_core.c
> > > +++ b/drivers/tee/tee_core.c
> > > @@ -105,6 +105,7 @@ static int tee_open(struct inode *inode, struct file *filp)
> > >       if (IS_ERR(ctx))
> > >               return PTR_ERR(ctx);
> > >
> > > +     ctx->supp_nowait = false;
> > >       filp->private_data = ctx;
> > >       return 0;
> > >  }
> > > @@ -981,6 +982,7 @@ tee_client_open_context(struct tee_context *start,
> > >       } while (IS_ERR(ctx) && PTR_ERR(ctx) != -ENOMEM);
> > >
> > >       put_device(put_dev);
> > > +     ctx->supp_nowait = true;
> >
> > Why automatically set supp_nowait inside open_context() ?
> >
> 
> I think this is the default behaviour (non-blocking request) that any
> in kernel client would expect. Also this flag could be configured
> again before call to open_session() if any in kernel client requires
> different behaviour.

Makes sense. I think this is a deep enough behaviour to warrant proper
commenting though.


Daniel.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
