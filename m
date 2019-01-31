Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5009FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:23:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2115B20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CypoCM2z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsyLjm/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2115B20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nq/u+rThu/fE1INRmgavSkne7/kWQHU+Ws3mMyljG7s=; b=CypoCM2zifHSDr
	jp2z2i/f4NR3Fa5bPUC3dZbal5BE108U/YsgJt42dXdZxre3FTTzr67TtpYY8doazez/aJjcHQoaY
	Gby4xBEa5UysMM4MRJCVVEC38RupbF8ZO65P7prWnLFhVHoZUFZ3aStLOIjEW2Mrk1psWBxaPHuJl
	ncx9F6WdOXjoqFyVbuUc4zhiR2HmZyL/mnl4GYnt77UcEapcwQPPse5syxoQPlYPCGld7Wvn1yk1A
	j9ajyD/62MUiF51LJ1MOabezn/KkDRHxnnnw718s4kDjrrj9XQooWk2Cz3d+TD4p0Qc4pvtO5AmXB
	Xesad7OGtMja9Vtg7ojg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpEBT-00060w-Qp; Thu, 31 Jan 2019 15:23:19 +0000
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpEBQ-00060V-45; Thu, 31 Jan 2019 15:23:17 +0000
Received: by mail-yw1-xc42.google.com with SMTP id t13so1380122ywe.13;
 Thu, 31 Jan 2019 07:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FEGsjMX0dp8RIKABY7YbpDek7VAiBMQ5lvDJ9kXcOns=;
 b=ZsyLjm/2i8qflJj65Hki7ZjvX/p5TsVDbFLDy7tSrA+zq8/rmQhKZ5yU4Bl9kcqNBG
 CY9HOGBpR1srhF7u4H9mYJcYyDuPjhrBD47VmrCaaN1SX2ExDlH0GQYz6bDNKGIeER/N
 DF6b1r3SOqJa9XC74nY0HVQaA3twQDl0/0usSyHts9dncP4v3Vg8voOJ8+jyAG7v0bUA
 B6+B6kriQluxGxRJeHVpFuS3YlZmyHiGWyoenK6JbziwuNQ+Alt9qkijGVE2SEtb3tDq
 9pqtKFQFBYtBJG7fxZ1NDZFxq1qNSGZFFtsmGMF43OGLzTtwPolkWURu5aoBZtbx+lxK
 2bIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FEGsjMX0dp8RIKABY7YbpDek7VAiBMQ5lvDJ9kXcOns=;
 b=D80AAiI2mwe2iMcz90cVK1QdEyNLzD6Hpa8putnn24nCq4qWe4+MZPLs+psoYeyU6Q
 2jeyt5XwCmOJ1F9nU5OfQrocL+8rLTqvU0nf8bWLad9t41GKmTpU2EmeGMk8l4J6yZJq
 zabxI50JCYJM/cRLyvM7IezPS6CRW0zgIMld9guXDmjlYafTpcr3jZpPGk4QlQgx1jlu
 sjrRI9wbNF+t1SQULkDIarIh9pwB4ZxhCbMx0FGk6B2VYIcQ4sDK7p2YPXgbjebiXMLa
 uqsDyo/de/rQiEV1GlYtKop/oqge2tdYAyYEfVHTGFneQPD7fW9wbl684yyz80fkA9tb
 pQ3Q==
X-Gm-Message-State: AJcUukep6WdMhHV0FHQ1KClreK6ffvXctuQuiqCT/mugX35Qy1DhoxtS
 yLClBPJi2x0Ojsectft63Lx2fFnFyOoiUcuxdrQ=
X-Google-Smtp-Source: ALg8bN6VKPBr8Isk9xxBy7E56UDJe1SXYMfF3Ab4zY9Hf3yytlNnD8xLHhr8GacDmx2eMD/3OVRnEkNlKLgL+Q7RzmY=
X-Received: by 2002:a81:5b07:: with SMTP id p7mr34659637ywb.468.1548948194353; 
 Thu, 31 Jan 2019 07:23:14 -0800 (PST)
MIME-Version: 1.0
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 31 Jan 2019 07:23:02 -0800
Message-ID: <CAMo8BfKhjwimXrGCcPjmS0+w8o6yW=ohG-hZ7caWnGpPSF6qJA@mail.gmail.com>
Subject: Re: [PATCH v2 19/21] treewide: add checks for the return value of
 memblock_alloc*()
To: Mike Rapoport <rppt@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_072316_186472_E47515EE 
X-CRM114-Status: GOOD (  12.10  )
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
Cc: Rich Felker <dalias@libc.org>,
 "open list:IA64 \(Itanium\) PL..." <linux-ia64@vger.kernel.org>,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, Guo Ren <guoren@kernel.org>,
 "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-s390 <linux-s390@vger.kernel.org>,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>,
 Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>,
 linux-snps-arc@lists.infradead.org,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 Petr Mladek <pmladek@suse.com>, linux-xtensa@linux-xtensa.org,
 "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
 linux-um@lists.infradead.org,
 "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
 Rob Herring <robh+dt@kernel.org>, Greentime Hu <green.hu@gmail.com>,
 xen-devel@lists.xenproject.org, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>, Vineet Gupta <vgupta@synopsys.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, openrisc@lists.librecores.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 12:06 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Add check for the return value of memblock_alloc*() functions and call
> panic() in case of error.
> The panic message repeats the one used by panicing memblock allocators with
> adjustment of parameters to include only relevant ones.
>
> The replacement was mostly automated with semantic patches like the one
> below with manual massaging of format strings.
>
> @@
> expression ptr, size, align;
> @@
> ptr = memblock_alloc(size, align);
> + if (!ptr)
> +       panic("%s: Failed to allocate %lu bytes align=0x%lx\n", __func__,
> size, align);
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Reviewed-by: Guo Ren <ren_guo@c-sky.com>             # c-sky
> Acked-by: Paul Burton <paul.burton@mips.com>         # MIPS
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> # s390
> Reviewed-by: Juergen Gross <jgross@suse.com>         # Xen
> ---
>  arch/xtensa/mm/kasan_init.c               |  4 ++++
>  arch/xtensa/mm/mmu.c                      |  3 +++

For xtensa:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
