Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE944C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:34:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02BB20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d0DMJs+6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY4F9gyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02BB20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LMTZRoBzWInp3Ih0rGgvAzPtTqKOy/VmIuuQg25Iyis=; b=d0DMJs+6nQX7I6
	GLX6VlHQwckdill0mLI2EeDp19k2l7D0ZR6LfyQVUzXY950igVYpTUJTObQunJ9BiVCAirlE2RotG
	bULIsHZP2nWfgzaTeJUj1GnVnTwW3zwSEJcPfIj/Ctg+GqyvkcOYpJDts4hW5CnO1oQlQGca3ntjj
	9gFC7MJ84dinNSFZ6HnxQXroS+D6q9AdyBAQXR0aagW0hsBvpYfSLjvaz9TVhc0dAQQHKKWPGULoH
	Xo2xpGKO9O5dzfi/FINdbL6ol13jq/MDtfS9D6xr1Zbq1PWx2/srGmgXRrDXhvgvjg5TE8rYARkUN
	gVL5dB74Gy3310PwW3Og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go0VG-0002TL-G4; Mon, 28 Jan 2019 06:34:42 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go0VD-0002Sw-Ge
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 06:34:40 +0000
Received: by mail-lj1-x242.google.com with SMTP id c19-v6so13182064lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 22:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QHgLGG8mEEUNiU9mEp4wmCyZjP0X29GG9+uZhXvM/LQ=;
 b=DY4F9gyOoziHc/0zvo2HvQqk7zi0Fl+eUe0M4zqI6oHJNScV1za79IW7dDuVbr1eFr
 1JyzSNjKtiaBVN2cv349SxrOuxTKpwabzvXigxZ3W8BJvTHRoHErnzcqOBZ8QQc/EKz9
 RaX3smqYDyHchDD7AOjgY8lakicp314+zFYGVjHONwr4eq1OtKBr3y7WQ4DDqGl3dUYc
 dv4KmZaMLyhY1HapcSuzUX+WopbjvxPP0owas6VmMAKHVKyOki2RQPqhXxtdg/jdt8Z2
 9fzR1vxGXwXoaDtNfT985wMzpsSZsQr0YLI7Yx54JotwqlRzOvmzXqsjMpJeOeapdS6T
 fakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QHgLGG8mEEUNiU9mEp4wmCyZjP0X29GG9+uZhXvM/LQ=;
 b=s987hEKx5zWr8KLm8c0JAk41EWDzmQ0rreE6DV/XGPoddnHmi5kVEhiDH1ENFBMD1w
 ApZ6Y8xO09Y7lzTze83yCo8HrHnnw/Rfc/2lIlFauo0R8cMgaYxoKPuk/169XHPFFTN0
 9guupKhj4s7ijgg6VMQLBe3OM12nInzn2IsSLB9cdGKiuE+yc0e88EmGdcT0nVxDdXRf
 Wd8ygPcNulRk5hREbNDJubt5IAQIuJEdB6KqkdTZH+AUF53h56Flccj+e+Z0ncWHhhqg
 eGCh+BYbLZFRQY35LZ1TryBjTY7brhZ8dTQWvb0vqmYi29fOWzyr4bd5yOOAb7i612N4
 2Z6A==
X-Gm-Message-State: AJcUukc4OMFnoZhK/l2p7WQzheKUJRPHmXI95AP1hv3FF06Ihy3/hUH/
 aOiFXcuIguWUHgEhobIiyt5W5yzE4Qpr6HUTMzc=
X-Google-Smtp-Source: ALg8bN4ASS6RJ6hXYxOAQPKuxhUc9rkHC3J3n8gXstmaeNandY6V+2Nh5M8XdAMpLXp53RUYIN/6yl2XQycoSn/m/H0=
X-Received: by 2002:a2e:8643:: with SMTP id
 i3-v6mr17361424ljj.43.1548657277194; 
 Sun, 27 Jan 2019 22:34:37 -0800 (PST)
MIME-Version: 1.0
References: <20190107173719.GA30197@jordon-HP-15-Notebook-PC>
 <eab5c59d-cfb4-bd2a-de07-7db827830472@gmail.com>
In-Reply-To: <eab5c59d-cfb4-bd2a-de07-7db827830472@gmail.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Mon, 28 Jan 2019 12:04:25 +0530
Message-ID: <CAFqt6zb0cU3TjAs0LO-DL3Ut98-7=b7cP9+hZ+bUxDLD2EN2vA@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH] arch/arm/xen: Remove duplicate header
To: Oleksandr Andrushchenko <andr2000@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_223439_550229_34D6F043 
X-CRM114-Status: GOOD (  12.69  )
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
Cc: sstabellini@kernel.org, Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Brajeswar Ghosh <brajeswar.linux@gmail.com>, xen-devel@lists.xenproject.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 4:08 PM Oleksandr Andrushchenko
<andr2000@gmail.com> wrote:
>
> On 1/7/19 7:37 PM, Souptick Joarder wrote:
> > Remove duplicate header which is included twice.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Can we get this patch in queue for 5.1 ?
> > ---
> >   arch/arm/xen/mm.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> > index cb44aa2..e1d44b9 100644
> > --- a/arch/arm/xen/mm.c
> > +++ b/arch/arm/xen/mm.c
> > @@ -7,7 +7,6 @@
> >   #include <linux/of_address.h>
> >   #include <linux/slab.h>
> >   #include <linux/types.h>
> > -#include <linux/dma-mapping.h>
> >   #include <linux/vmalloc.h>
> >   #include <linux/swiotlb.h>
> >
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
