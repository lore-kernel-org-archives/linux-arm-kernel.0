Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8780C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:46:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A34B20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DiBrg6dp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGF3eeJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A34B20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sjto2wtb+Q2qJXEwH78PF9ehD2ygroU3IPPT+DUGYAs=; b=DiBrg6dpelWnys
	SdTswlIg6SuzVquCGS7va9k3I/9Zs+yQIXQoW+pmmr8Y9Mjy9SpIS+9T3xrncvuPcMbEsKdTegbsH
	I0/sfVw8CGb9Bpxm9hGy8M4NUOzdOKD1MUU4/gbH1U0jjJoRhiX+xas5YBYcQtMSv7mGsKc2gHpuh
	jBX7ycfAZ2skVVrUMr3dZ26FDKipTOVcZicobIuqqgrYwaOIbw7WjHPyTtqzGYaTMpbLNa4fMynph
	nqnhvQzG5nzKWrKFCVcWbH+RWCPFE3GeCH3gZyK6QbrVtlk2Zhe+uko0etyj0UnOsZiH3i9/xBznv
	Z4SyiHatoLKzhKRqTmUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glX6X-0000kM-G7; Mon, 21 Jan 2019 10:46:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glX6U-0000k2-5p
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:46:55 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 628A420663;
 Mon, 21 Jan 2019 10:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548067613;
 bh=xqpY8AMg/HXFeMSt+0tUMAS0bbracdhBU8y41l9I78c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VGF3eeJxNxTpY9MpljMERB4r4zvGF0LkCaC+bDs2GPOtAz0tynrGs5QckrRIALfgy
 3Ca6yFtBuxSYVhkjzBMAgzNgq1uiRImEu71BPHEYWBx+27UHEGY4aZ+2EG57KIqXqk
 yWa+SqHW1puGQjKr3R7Csb7k9JuZantde9blxl7U=
Date: Mon, 21 Jan 2019 11:46:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v4 4/4] hwrng: add OP-TEE based rng driver
Message-ID: <20190121104651.GA27442@kroah.com>
References: <1548062959-31860-1-git-send-email-sumit.garg@linaro.org>
 <1548062959-31860-5-git-send-email-sumit.garg@linaro.org>
 <20190121103026.GB15590@kroah.com>
 <CAKv+Gu9xT87twvnfvnxZqZ-Yj-Xmw5+2wkw6yCRhF7iuz+y-TA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9xT87twvnfvnxZqZ-Yj-Xmw5+2wkw6yCRhF7iuz+y-TA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_024654_236740_0E427EA4 
X-CRM114-Status: GOOD (  12.48  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Sumit Garg <sumit.garg@linaro.org>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Bhupesh Sharma <bhsharma@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 tee-dev@lists.linaro.org, Rob Herring <robh+dt@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, mpm@selenic.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 11:43:14AM +0100, Ard Biesheuvel wrote:
> On Mon, 21 Jan 2019 at 11:30, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jan 21, 2019 at 02:59:19PM +0530, Sumit Garg wrote:
> > > --- /dev/null
> > > +++ b/drivers/char/hw_random/optee-rng.c
> > > @@ -0,0 +1,272 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> >
> > Nice, but:
> >
> > <snip>
> >
> > > +MODULE_LICENSE("GPL");
> >
> > This string means "GPL2+", you need "GPLv2" here instead.
> >
> 
> I think you need a space there: "GPL v2" or it doesn't get picked up
> correctly (or at least, it didn't use to)

Sorry, yes, see I even got it wrong :)

The correct strings are in include/linux/module.h


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
