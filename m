Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B19DC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:14:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D2BA2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ht6ZbhMa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9oPWpRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2BA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XWOprehNMq8XfRPMmu7cXVmdJhCdxnXeMsK9Mdb4WmQ=; b=Ht6ZbhMaxJ07ey
	hbq8kwWkiBzvWIqAK1iAF74UWlDjVQCCwWwfBlPuDQ6wB8dOafGt7jaqjc9gJKvqX6JOkThkcYXSm
	mzGFCVfioJaeuSzc9hojY0VcPeuRqbCGWkXpfnYXWLz03hR+a+pBTcIk5oQ6+8gVdMaY4pkRdDos8
	KSiNGa41NEUtkLVfgzGZECG/dNyNHae7f+BTECx3TBpZiF62VEwN8h5yMNQ3lWjoyqowqiXzAYRfc
	eeO8BVMmX+hUKnRbry1vycPzvIhW7KTRA10qC3JabVRcoaD4Yxt5ksZSLgbew9MmlB7Ts8ISdWEFy
	EGJJgbkcTyFla4tUKPlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWbJI-0003Fh-Ud; Tue, 11 Dec 2018 06:14:24 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWbJE-0003EL-QW
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 06:14:22 +0000
Received: by mail-it1-x142.google.com with SMTP id i145so1854436ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 22:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ygsu3tUgZUUY5/uDHXTU/n86CTw4PpyergSMBneeTmM=;
 b=W9oPWpRkSetpvqu2JArL5IJBL+9XepYEAjTCTvmqSm4ceHKoC5yRRsJfOT+a7pl7CZ
 E8n2NRXFGHCRap+GCN3HgBr1xCy2gvFFGlIN9tn+k80yJUvwdO2oPhVZaxrYpnJfZb+3
 OJJ1OHehxBR9+TE1JoZ0Op5/u0P2z2xNW1f2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to:user-agent;
 bh=Ygsu3tUgZUUY5/uDHXTU/n86CTw4PpyergSMBneeTmM=;
 b=DYW4qWNNzMDLWhtLsGDdDIVX0jkbUO1Tu8NlSLA7QcmBumfoVWTPxzif2Ec3nzO6Xk
 ZHtdTWWImPnMDff0w4axpFX0jg0HWlQd/NlBERA4cxD5QUlWEW273z3GueYX10+CBMe4
 o4CaQO2ICKYsBvKn+/ZRU91/PaV/uRFv8/SzSWuu6XcAvF+fJrwfDybrvWX97TDTWpua
 VJ0Ch6+d3bPBvXj5fSIDhn3S20ypfDVec1vTbH9rZLYU7OAYMBxdVkD8SeSWL8fnMuNx
 8Djt4lkZh6BEUSMX4mKUAJdUmRC0CVuWsl8AxKxYZ3L+8//Ibg6g+oa5xpGMNQqUgySG
 ifTw==
X-Gm-Message-State: AA+aEWZTpU9JE+WFdM7gVjzpvmHAKdD4rknxt4XN/eYkIuv67+G3b1CD
 nk9xWslZlQQZy5e7Vkw1YJk4ig==
X-Google-Smtp-Source: AFSGD/XviidQxZ72Bu8O2KqYzD/0/GfY53D1AeAq4CNCkSTRBH6qPQ5PX8nDRwdAjRno9x6tTQ9PCA==
X-Received: by 2002:a24:9fc1:: with SMTP id c184mr1162993ite.8.1544508846272; 
 Mon, 10 Dec 2018 22:14:06 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
 by smtp.googlemail.com with ESMTPSA id 196sm669244itu.37.2018.12.10.22.14.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 22:14:05 -0800 (PST)
Date: Tue, 11 Dec 2018 15:17:16 +0900
From: "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v16 06/16] lib: fdt: add a helper function for handling
 memory range property
Message-ID: <20181211061715.GF21466@linaro.org>
Mail-Followup-To: "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>,
 Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 David Howells <dhowells@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.net>, dyoung@redhat.com,
 Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, prudo@linux.ibm.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, bhsharma@redhat.com,
 kexec@lists.infradead.org,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
 <20181115055254.2812-7-takahiro.akashi@linaro.org>
 <CAL_JsqL4_Z5pVfoB3opjL7eTzZvhBJW7_aQS443quAAR0gGH1w@mail.gmail.com>
 <20181206155424.GA4422@arm.com>
 <681e1265-2f0c-2a62-3778-09911b2be7fc@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <681e1265-2f0c-2a62-3778-09911b2be7fc@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_221420_867440_7697F67D 
X-CRM114-Status: GOOD (  23.37  )
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
Cc: prudo@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
 Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, bhsharma@redhat.com,
 Frank Rowand <frowand.list@gmail.com>, Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 David Howells <dhowells@redhat.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, kexec@lists.infradead.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, dyoung@redhat.com,
 David Miller <davem@davemloft.net>, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

James,

On Fri, Dec 07, 2018 at 10:12:47AM +0000, James Morse wrote:
> Hi Akashi, Will,
> 
> On 06/12/2018 15:54, Will Deacon wrote:
> > On Thu, Dec 06, 2018 at 08:47:04AM -0600, Rob Herring wrote:
> >> On Wed, Nov 14, 2018 at 11:52 PM AKASHI Takahiro
> >> <takahiro.akashi@linaro.org> wrote:
> >>>
> >>> Added function, fdt_setprop_reg(), will be used later to handle
> >>> kexec-specific property in arm64's kexec_file implementation.
> >>> It will possibly be merged into libfdt in the future.
> >>
> >> You generally can't modify libfdt files. Any changes will be blown
> >> away with the next dtc sync (there's one in -next now). Though here
> >> you are creating a new location with fdt code. lib/ is just a shim to
> >> the actual libfdt code. Don't put any implementation there. You can
> >> add this to drivers/of/fdt_address.c for the short term, but it still
> >> needs to go upstream.
> >>
> >> Otherwise, the implementation looks fine to me.
> > 
> > I agree, but I don't think there's a real need for us to hack
> > drivers/of/fdt_address.c in the meantime -- let's just target upstream
> > and not carry this in the kernel.
> > 
> > Akashi -- for now, I'll drop the kdump parts of this series which rely
> > on this helper. The majority of the series is actually independent and
> > can go in as-is.
> > 
> > I've pushed out a kexec branch to the arm64 tree for you to take a look
> > at:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kexec
> 
> I gave this a quick spin. Without the elfcorehdr/usable-memory-range arm64 needs
> to explicitly forbid kdump via kexec_file_load. (like powerpc does already).

Thank you for pointing this out.

> Without this kdump works, but the second kernel overwrites the first as those DT
> properties are missing.
> 
> I'll post a patch momentarily,

Fine, but anyhow I'm going to submit a new version (*without* kdump),
I will fix the issue along with others.

-Takahiro Akashi


> 
> Thanks,
> 
> James
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
