Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AECDC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:59:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC7E2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dH3EuwAw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgZnM72Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC7E2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/cnWS9p650+fRHVYHLlk49GsEcqbr3fSwlJSlwvSYII=; b=dH3EuwAw52M/Bq
	dzYawe2QRHXbeutGGzOgL3P40qj44a+CdmUP9w7EPbp6/hEb5CzpmfWX1xW3wEBal0UNmu4SBztpz
	EL72q3xcb4DsxS83MXNgcQoYeZEovKOOjv8r+n2GnsdpqNG7zFdBSAawnxh3PhGY8iSN823u0BTFc
	YAKWdCGEXiPrTxkB1uiwYvKfK6ZkTWftWxl1FOZiPidYNp++gnP5U5OVqfG7gEztKSiH2vFTgPNI/
	HFAtfY3R5vN48dzj3KsooOHHPY5cUXhMSK5N4oqjv3l6wZ8J5aEKWsNHWcDvYaKNgmvCK8YrPVbSi
	PLx/yu6cbuE+R0pr0Eag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomeH-0008AS-9m; Wed, 30 Jan 2019 09:59:13 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomeE-0008A4-8M
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:59:11 +0000
Received: by mail-lj1-x244.google.com with SMTP id q2-v6so20158812lji.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 01:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fO9lml+l22jOIyAkjdHX9mgdNk63cVEuzFUCTmyVOGY=;
 b=FgZnM72ZgZjEW0ORM0btMd9MaPOSZrwy4G9BeQws0rUHuJHemFIVbE0ZCoZpaoosFw
 N3PdCNT6kXYw8DLArD26ROZeZzX8+8jjnLe36XfsiwPdVYaU43zXcTbDoeiwCN+mqekZ
 zsoH+T/bie3kWtmE8bXeQ2qFizuDognaAGSBbIlF5jIr4yvCiyJNi5O0iEa6OXD864pj
 BpkiZ0YjlrSKJQbkgDtZBfRpE+Ti0E2FKogNXGRbdJ+XauSFmM8wamMDzXg6IiWxAQg2
 S+Sq6rxtBEO6tnO7W5lo0N1bX0uEQxNNNyjyTB1Ey2rgMaID4CY2GUA+/xaXoy8YJvrH
 vAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fO9lml+l22jOIyAkjdHX9mgdNk63cVEuzFUCTmyVOGY=;
 b=Q/HAI2rzkoCEX+bKnex1kw2BRInsqDt4nt0Dqw5ubF+ZtZlw4xRUJajVWAfA14OUmc
 mwjZ3HJXOO4jDJbKdUMNqbxUSbAJkEm1e8ZGDAMuI6Mdr0LakYC5ly7Q1Bh3Qou1f0/Y
 S5vFazfQtBWp02i5/tyynGYt8Zo24IMjq3z1aiDJ2ooecy35hwKQUHvDpUpOJ1/V74cF
 hUVfIPgdcrjZa85u9tEFv+C3Z+e5LMMbLX7JbQfuAvk+MgvQoJiUcppKESyr3BqT9/Pa
 E4Gl9cEyQT4NPa4zn8OVc3Lavx8lAep+gvGYvAezZ8S8TNbvCQH2DHZIPJHV9Bciqo1q
 AFVw==
X-Gm-Message-State: AJcUukejyYLxln5znLLRaiVPqmZX/yQydf4ZyW/oOQHaxQGWwE9Mj/Eg
 kiYbPdEkCS6jmwpVvOyWEmU4K8+3wiRCIggAg9k=
X-Google-Smtp-Source: ALg8bN7/li39XaGpJQ6EMr2lSSqiHUCbw+mdn4YxxMLFOWbC7mmMJ4AR7eu7vhwFRP/Adj9lqWbSZT1zXyytNWz3m6c=
X-Received: by 2002:a2e:5854:: with SMTP id
 x20-v6mr23772381ljd.31.1548842347483; 
 Wed, 30 Jan 2019 01:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20190111150834.GA2744@jordon-HP-15-Notebook-PC>
 <CAFqt6zYLDrC7CtLawWUAQPyB_M+5H8BikDR6LOm+v0qaq1GvZw@mail.gmail.com>
In-Reply-To: <CAFqt6zYLDrC7CtLawWUAQPyB_M+5H8BikDR6LOm+v0qaq1GvZw@mail.gmail.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Wed, 30 Jan 2019 15:28:55 +0530
Message-ID: <CAFqt6zY4YgsCUPFqR2yYegjqtHJ_aeE1Ao6p=fE92s2__3XTsA@mail.gmail.com>
Subject: Re: [PATCH 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range_buggy
To: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, 
 Michal Hocko <mhocko@suse.com>, stefanr@s5r6.in-berlin.de, 
 Russell King - ARM Linux <linux@armlinux.org.uk>, robin.murphy@arm.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_015910_323008_E06FC296 
X-CRM114-Status: GOOD (  18.92  )
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
Cc: Linux-MM <linux-mm@kvack.org>, linux1394-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 11:55 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Fri, Jan 11, 2019 at 8:34 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > Convert to use vm_insert_range_buggy to map range of kernel memory
> > to user vma.
> >
> > This driver has ignored vm_pgoff and mapped the entire pages. We
> > could later "fix" these drivers to behave according to the normal
> > vm_pgoff offsetting simply by removing the _buggy suffix on the
> > function name and if that causes regressions, it gives us an easy
> > way to revert.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> Any comment on this patch ?

Any comment on this patch ?

>
> > ---
> >  drivers/firewire/core-iso.c | 15 ++-------------
> >  1 file changed, 2 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
> > index 35e784c..99a6582 100644
> > --- a/drivers/firewire/core-iso.c
> > +++ b/drivers/firewire/core-iso.c
> > @@ -107,19 +107,8 @@ int fw_iso_buffer_init(struct fw_iso_buffer *buffer, struct fw_card *card,
> >  int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
> >                           struct vm_area_struct *vma)
> >  {
> > -       unsigned long uaddr;
> > -       int i, err;
> > -
> > -       uaddr = vma->vm_start;
> > -       for (i = 0; i < buffer->page_count; i++) {
> > -               err = vm_insert_page(vma, uaddr, buffer->pages[i]);
> > -               if (err)
> > -                       return err;
> > -
> > -               uaddr += PAGE_SIZE;
> > -       }
> > -
> > -       return 0;
> > +       return vm_insert_range_buggy(vma, buffer->pages,
> > +                                       buffer->page_count);
> >  }
> >
> >  void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer,
> > --
> > 1.9.1
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
