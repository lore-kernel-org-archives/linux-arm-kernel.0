Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C299EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:54:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 920ED214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jKtz3nEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920ED214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vR1/WKypjoPSXwCW04YLIAastIDeJQmStlRHpKn7Y8Y=; b=jKtz3nEN3rgV12
	K4r489UsAJ982707D8a2sH/lKctUzizbhxpU2kPxvkskwpifbK0EpqfQ8ZKes/897mg1WuWso7eQm
	SB9fi8wyxjDt+stBYBORLZgPTOik+E/897+ZR2MHRFygG9MTPYu2tQc9r3BFXaIUuzc5p+YokvlJy
	n387QXOTd6AyikRFthAdWp8o/1ETqFu5uG1BEoMdN2FxkJiAdEgVotB0LWbinpb+M/BW3jqsYsBkd
	6pIc0uzADMiSHsqwIpIU/SshxQGxncmMidvJKlvxSqBiJBP5TivXrxEY23NTGehmu9JE8puLPOLd/
	kn33wxczZyU8iZXcSfWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUvyl-000086-8w; Thu, 06 Dec 2018 15:54:19 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUvyg-000061-Fn; Thu, 06 Dec 2018 15:54:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E356480D;
 Thu,  6 Dec 2018 07:54:03 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B18F43F59C;
 Thu,  6 Dec 2018 07:54:03 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id C9A9C1AE0BD1; Thu,  6 Dec 2018 15:54:24 +0000 (GMT)
Date: Thu, 6 Dec 2018 15:54:24 +0000
From: Will Deacon <will.deacon@arm.com>
To: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v16 06/16] lib: fdt: add a helper function for handling
 memory range property
Message-ID: <20181206155424.GA4422@arm.com>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
 <20181115055254.2812-7-takahiro.akashi@linaro.org>
 <CAL_JsqL4_Z5pVfoB3opjL7eTzZvhBJW7_aQS443quAAR0gGH1w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqL4_Z5pVfoB3opjL7eTzZvhBJW7_aQS443quAAR0gGH1w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_075414_531143_40577BC7 
X-CRM114-Status: GOOD (  17.45  )
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
 Frank Rowand <frowand.list@gmail.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>, "AKASHI,
 Takahiro" <takahiro.akashi@linaro.org>, devicetree@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, kexec@lists.infradead.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, James Morse <james.morse@arm.com>,
 dyoung@redhat.com, David Miller <davem@davemloft.net>,
 Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,

Thanks for reviewing this.

On Thu, Dec 06, 2018 at 08:47:04AM -0600, Rob Herring wrote:
> On Wed, Nov 14, 2018 at 11:52 PM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Added function, fdt_setprop_reg(), will be used later to handle
> > kexec-specific property in arm64's kexec_file implementation.
> > It will possibly be merged into libfdt in the future.
> 
> You generally can't modify libfdt files. Any changes will be blown
> away with the next dtc sync (there's one in -next now). Though here
> you are creating a new location with fdt code. lib/ is just a shim to
> the actual libfdt code. Don't put any implementation there. You can
> add this to drivers/of/fdt_address.c for the short term, but it still
> needs to go upstream.
> 
> Otherwise, the implementation looks fine to me.

I agree, but I don't think there's a real need for us to hack
drivers/of/fdt_address.c in the meantime -- let's just target upstream
and not carry this in the kernel.

Akashi -- for now, I'll drop the kdump parts of this series which rely
on this helper. The majority of the series is actually independent and
can go in as-is.

I've pushed out a kexec branch to the arm64 tree for you to take a look
at:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kexec

Thanks,

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
