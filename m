Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1530CC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:43:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8EDA2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jl2pKXAV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LKiQ71fa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EDA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kINhZOn9lX0FVtOzEDc2x/Rwn/Ah45oN4VSZP+8ogTg=; b=Jl2pKXAVVAL7y2
	ST4U7enVTW/qf2GpgDpbBIVeZPy4re36MGZ3VK0kckg5AqfAj4tQ7y4AjK8XipBRPdujZ28733TQh
	EhaQx8kdWEjuJd4yI5UuijooBIC0i5OErYnzKChEPT9TOtw7xZkuUXEpULculWzP+aQrsm5t73K32
	JVB7Lj2fgNQ8vo2/FovK1VZ9b8y2ohUfP9m0E/qE3w82jm+BR6wmMw+3w4Aeq8dm2gVCtSaSF8kjJ
	NHzkaImv50AEKBoboNakuKrGGQ2VgPPt3zw3QYEcrw6YO2itwwPDfQjrowCHZqBpAF8qILMYhwV8d
	a5mTQTAdKQmd9G6FSJtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqeXV-0000Kz-13; Mon, 04 Feb 2019 13:43:57 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqeXR-0000KY-VB
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 13:43:55 +0000
Received: by mail-it1-x142.google.com with SMTP id c9so21051633itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 05:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2qRXtdzfk3K1AL17TPQYLnWwn9x5g9yhTRC4UUzz6Hw=;
 b=LKiQ71fa+zCG+DyzUs+ZElixKEJiNQMb5YX9Q+YkpoGryrsd3gOZDxlNtPEZCKvskm
 QwsCVHv5lWYiW8W8hQ7Es6NYKe3RbYmi/FltA6qNlWZni3lgrs/V9w+xy/8yJsD5H41U
 l7u2nx+0pmB1mRYTac/Q72PauSOvuhT1D2BLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2qRXtdzfk3K1AL17TPQYLnWwn9x5g9yhTRC4UUzz6Hw=;
 b=kM2dh7K0bNVtxvaRHhm7rxemyt9KmWtRq6rnr1E3brHn6fZtHcZb5I9KRdPnGXcvFN
 lgPGYNWaMzY46SSSaKpK6vMqOi0fUFxIkxdnDEgsaKtRC3i0IP3WsLjNP32vDI1d4v5y
 YeJkTf4zHgrXi1HAAGq0/bsYNp/zLK8R1CLspIaLHlK7kBh5rVphwIBXgd00XdmoZQvn
 VnsuT5wfaoR0Pl1yxENJHNLh2Mz6y+LcJ99y23QK5hDHiJD3XbsK4TTR3PDrzxAHfC1A
 BSRqkPn95C1yFzq8T49X4n/D2aSy01whXAS8DcA+PB58H0OmR5XgKcbSF28TcVetrxi3
 7EAA==
X-Gm-Message-State: AHQUAuY0iATGC0P8gwBzw2hKEMwMo4o0ZRAy0Tq99DwzFaOMA7I0X6yj
 vPfceDw51KSBP6EWcocUpSL1G3I1YOZripfG4zI1og==
X-Google-Smtp-Source: AHgI3IbfDrjeq4B5BvM8BcgO7TOdeqbsXdtl130yjhLsFYrA+OaBZsUnNXQ0kmiKEQm5M/4oZ5q/G8eM9a6Yy82qDO0=
X-Received: by 2002:a24:710:: with SMTP id f16mr7559281itf.121.1549287832781; 
 Mon, 04 Feb 2019 05:43:52 -0800 (PST)
MIME-Version: 1.0
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163908.E338E68D93@newverein.lst.de>
 <bdcbdda9-d9e8-20e5-429e-35473ade56cc@arm.com> <20190122132832.GB16778@lst.de>
 <CAKv+Gu_sk-jbT3BfTVt1jdx5tR3KCGYzU63T8bv+TYy0Oizy+g@mail.gmail.com>
 <20190204120308.GA7660@lst.de>
In-Reply-To: <20190204120308.GA7660@lst.de>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 4 Feb 2019 14:43:42 +0100
Message-ID: <CAKv+Gu-3vzo4YJxN=qQ5yRDJnWjCt7L96HkoG3y2AUJk_zX3ag@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
To: Torsten Duwe <duwe@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_054354_004723_BB1B2557 
X-CRM114-Status: GOOD (  16.23  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, "Singh,
 Balbir" <bsingharora@gmail.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, live-patching@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 4 Feb 2019 at 13:03, Torsten Duwe <duwe@lst.de> wrote:
>
> On Tue, Jan 22, 2019 at 02:55:12PM +0100, Ard Biesheuvel wrote:
> > On Tue, 22 Jan 2019 at 14:28, Torsten Duwe <duwe@lst.de> wrote:
> > >
> > > On Tue, Jan 22, 2019 at 10:18:17AM +0000, Julien Thierry wrote:
> > > > Hi Torsten,
> > > >
> > > > A few suggestions below.
> > > >
> > > > > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > > > > +#define ARCH_SUPPORTS_FTRACE_OPS 1
> > > > > +#define REC_IP_BRANCH_OFFSET AARCH64_INSN_SIZE
> > > > > +/* All we need is some magic value. Simply use "_mCount:" */
> > > >
> > > > Nit: Should the casing be "_mcount" ?
> > >
> > > No! The string makes it clear what it's supposed to be and the peculiar
> > > casing makes it unique and leaves no doubt were it came from. So whenever
> > > you see this register value in a crash dump you don't have to wonder about
> > > weird linkage errors, as it surely did not originate from a symtab.
> > >
> >
> > In that case, do you need to deal with endianness here?
> >
> > > > > +#define MCOUNT_ADDR                (0x5f6d436f756e743a)
>
> Strictly speaking, yes. OTOH "wrong-andian" machines always show a difference
> when memory is dumped in bigger units than bytes, so when you see the register
> value in hex...
>
> Since all that's needed is a somewhat unique constant, let's not over-engineer
> this ok?
>

Ah ok, if it is only for visual recognition, then I guess it doesn't matter.

> If there are no other comments I'll send out v8 with the discussed changes.
>
>         Torsten
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
