Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BCAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:24:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B3421841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OHOfObET";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLQQ/NGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B3421841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jgULtNbFR8OZUVKZTd1rKIpus46ZxZZUWW6UQ4EVg+w=; b=OHOfObETf0dcEu
	3RAuu8fntT+6ORtHzHqICo8mjl69+4il4fU81k6FwVJZYQQnf/ZU/UHCmSKqbuuKG7v+RfTO4yhPR
	11hw0KQI+O7wQYyNv5hnhYGqQI9Eh3nw4avbW8XqWoTImGybDd8f2Az7BV4KHJ55wYy1FJWW+YnZV
	gHCM6sZWWy1F46VS702axD2bLWq/mGUA/fitDrETj73Rw9HE4k7zzf3oSiwtIv+i1CQWeHg5Zki0T
	i6U8iHzrgAG5wvVsf5HQGnN1v3WyxCWcMBB8hkYhRzOuPioXmpurITD9hjS8DwejwZToN7S2L5512
	1lkfEYabc9vdT8lFCGLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZWDm-0007EP-4n; Wed, 19 Dec 2018 07:24:46 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZWDi-0007Cq-O3
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 07:24:44 +0000
Received: by mail-lf1-x142.google.com with SMTP id c16so14230711lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 23:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g2FohPlTqqDlG6f3TAHjmUUruPHrATpRScTaxik8168=;
 b=hLQQ/NGJlN4QaGIb/X4rfRak9S/j9y4cOfuocHiF3yDseBs7k7IwKPMqQ2F/0Dat4S
 gR7kjWBZo1R+ArrsCBkZ+BWMrjjvmSST/Ir9rrZ8WtmeMU00b7vPxCJTL59nfwcdfT4g
 tZiqxsI6xlVMcphwSDnbAIFDVSXf/wbDCwJaP4jbdHwvvvN+ScILFMeDUw0WbeSBQBDy
 DFP+Vx5BXoN9yEry4KhRDeibYmj95L3oVJHluDxMaEQRVm6d12qTMNwirw80hxaQhM9g
 0cBXWvGVDSprU2jJWEHiwzukgSb+076Yiqx2vjruDMxBXWXbGanXE7KAsy/PbikAXdOL
 H1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g2FohPlTqqDlG6f3TAHjmUUruPHrATpRScTaxik8168=;
 b=m1WxtdI3CBSEMuxM79gZEhmt57F/cgrlmFu3Kht8Kfn+zPPRWnG5llCLqXaOyb3cyV
 tuJDuWgRMNMedo1EhqxDVDrMh9IUT7b7CEL90KTiibEIsd8MyqsRd8foEYv5Xlr9ZG6E
 h4pbAeU5QT+/5J4R+T06xdrlkuG/9m+vQIuA3CBEwuGAzXnd3OR8Ok02Kx3jXpIQBvmI
 Ya9MNYY3saHgj7caKDG2ZPf5HPzZcteT0EEgFKZ2vYgBzjk1M8V1fQPypipUXAiFw6AA
 u1HvzQz1XzsqZ2b/+DA2uajdUU+Srz+fF4gQ8VpRyuRSqtsDeuNlfLwHNlYAfftM49DF
 8mOQ==
X-Gm-Message-State: AA+aEWahgbsuv4u2JetIXOTwUGprjasyI4FKVc1HvkKQLwPvJ/ZBr2jJ
 BYfW9lfkUFbhOaYMKU7+5kcwGglTFO0I8nFmb3s=
X-Google-Smtp-Source: AFSGD/W75bu3aSShy6XJY9/NU4LyAPVHx94cqD93BE7YR86z/wz7sm02PIiivtNAzC78gVvPzTCUh1acMisM2ppThB4=
X-Received: by 2002:a19:2906:: with SMTP id p6mr3587675lfp.17.1545204270516;
 Tue, 18 Dec 2018 23:24:30 -0800 (PST)
MIME-Version: 1.0
References: <20181217202246.GA10500@jordon-HP-15-Notebook-PC>
 <20181218104513.GM26090@n2100.armlinux.org.uk>
In-Reply-To: <20181218104513.GM26090@n2100.armlinux.org.uk>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Wed, 19 Dec 2018 12:54:18 +0530
Message-ID: <CAFqt6zZw2jO5qGjG3CdAZR2ZXt19+ykhyw+hhVDP7xTaemusiA@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range
To: Russell King - ARM Linux <linux@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_232442_791762_E1DE28D1 
X-CRM114-Status: GOOD (  21.50  )
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
Cc: Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Linux-MM <linux-mm@kvack.org>,
 stefanr@s5r6.in-berlin.de, Andrew Morton <akpm@linux-foundation.org>,
 linux1394-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 4:15 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Tue, Dec 18, 2018 at 01:52:46AM +0530, Souptick Joarder wrote:
> > Convert to use vm_insert_range to map range of kernel memory
> > to user vma.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Reviewed-by: Matthew Wilcox <willy@infradead.org>
> > ---
> >  drivers/firewire/core-iso.c | 15 ++-------------
> >  1 file changed, 2 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
> > index 35e784c..7bf28bb 100644
> > --- a/drivers/firewire/core-iso.c
> > +++ b/drivers/firewire/core-iso.c
> > @@ -107,19 +107,8 @@ int fw_iso_buffer_init(struct fw_iso_buffer *buffer, struct fw_card *card,
> >  int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
> >                         struct vm_area_struct *vma)
> >  {
> > -     unsigned long uaddr;
> > -     int i, err;
> > -
> > -     uaddr = vma->vm_start;
> > -     for (i = 0; i < buffer->page_count; i++) {
> > -             err = vm_insert_page(vma, uaddr, buffer->pages[i]);
> > -             if (err)
> > -                     return err;
> > -
> > -             uaddr += PAGE_SIZE;
> > -     }
> > -
> > -     return 0;
> > +     return vm_insert_range(vma, vma->vm_start, buffer->pages,
> > +                             buffer->page_count);
>
> This looks functionally equivalent.  Note that if we go with my
> proposal to your patch 4, that would cause an issue for this
> implementation.
>
> Maybe we need two functions, but that then causes problems with
> which function should be used (which makes it easy to get wrong.)

I think, apart from patch [4/9] and [6/9], all others places can be
directly replaced
with vm_insert_range(). [4/9] and [6/9] are the places where
*vma->vm_pgoff* need to be
considered and need to adjust *count* accordingly. In my opinion, bugs
around these
[4/9] & [6/9] can be fixed (raised during review) to accommodate it to
use vm_insert_range().
>
> I'm beginning to wonder if the risks of causing regressions and
> introducing bugs is actually worth the effort of trying to clean
> this up.
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
