Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D810C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:11:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8022083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g2nGPFFl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJsGlez9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8022083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QYeliTwuQNQg9MD4gVG/KetUCLPV+dU1QzkNBc8IPWM=; b=g2nGPFFlU4pshw
	HWxWmeVhVgJ3Qn/b9PZjvUoFf+G4r8t9aZk/be1YE3OweUhw2vHYTUf7a1DW8sen7riveX5nkt394
	zbVrDwH/JWJmEusWbJKorTTMMHGjNzEbQfcGVV7XIdBCIREPhfFMWlpTznY69esbLFDMz9D9nvJVg
	6HHAtgnB1W9/DOM+xO8aXDj9OUvgtvn74gvmz8cco0PEIYfsLS9mbut3y9oZ22CMx9o4begV+qVOR
	Sp9DmOvQEMOa42J+XC9acozvZmL0ftt7m3QR+cppYFz8sKLW4GjgJwR8Ws6v4jCk+sQBj+7IQUCMn
	16mWqMySuiHTRfO2MIpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqGc7-0000uD-7l; Sun, 03 Feb 2019 12:11:07 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqGc3-0000tr-QO
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 12:11:05 +0000
Received: by mail-lj1-x242.google.com with SMTP id k19-v6so9371104lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 04:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8SrF1ldydTiBZNiCjzZif0i3Yfeug4ftFhfixRtZHpw=;
 b=pJsGlez92rrWhCVjLzcirAg32UfgdzZmz3h7IHlwSMeHDraTB7Az+ntFTMkWHQT8N2
 vhuMi+jS1XIhIbR3VzbVgsxBQJI1didJosDf31B6hngRyB8PS53CxxYR/Rc5tc/g+EYC
 zJW8XqZe9g+X3OJiIUGV76zTpSaLQ3B+WeQIaHaQcNJHwOIq5HAbUnaog2y1NXfRrOlb
 btsjOSK1MNVgF/sYbuPDBRUk7whc5WI3p+6ho8cI6vTN0WddJ0eogXaxBMwINDFHl6pM
 pkS10Z9mC82aOkfkX6hczwBIxYVrdI8c+OqCSfWf1Gfh4lE8hHKYtOqfYbtQNFaJkPbA
 jflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8SrF1ldydTiBZNiCjzZif0i3Yfeug4ftFhfixRtZHpw=;
 b=aK8zIBQXXkKFMG7DTNun8Px0tUKTW7R1n05CzLUeWx3jrGFCDHiBI6DONRg7sGu5ox
 uM4ciiOQqTd2Gu4JDxUso4zOafg+7nL2MfkqpocRqD8xMfJuydFtRn8jkGEel6pALRMi
 EvR+yZbVjUulVlc8zuqkwGYDSexVPZRfIpzhqbKjwc212fA74YaDMtqLa2mlHWtCr//a
 lvbV0lWJQJeX4GTUfCZ6K3FfDRROs4BYUUyqjtNCUSbj3u1otyvnpwgRSKOgU1SWcnIg
 z7ke6Eh+Ic3Lx18zSEPQrtHjiGvGLmzCQQ7IR8/vzbnBLaFmwA5KGgZhSY6QGfD/LuOH
 WWAA==
X-Gm-Message-State: AJcUukdMqAhVmcM9+li/rl+yHJrqVMI9y+8PPu/bqkDfv4cGui/BuR0w
 hiTcYN4U/n6onBKD7IZz0lSb+3MVinHSwlVysmw=
X-Google-Smtp-Source: AHgI3IbCzFQD/+Uqz0DfjLSsX4iVK4fMId5Z87LLJDmoXHAA42wXu6RBQ0/v6b3cLh38pZaQBHcIfOlK/fsOvmLRX+E=
X-Received: by 2002:a2e:5703:: with SMTP id
 l3-v6mr24761848ljb.106.1549195860175; 
 Sun, 03 Feb 2019 04:11:00 -0800 (PST)
MIME-Version: 1.0
References: <20190131030940.GA2305@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190131030940.GA2305@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sun, 3 Feb 2019 17:40:51 +0530
Message-ID: <CAFqt6zaN-AJuhVf8_=z3KDCjcuu+zTN_GorxDzcpAUqcM04m2w@mail.gmail.com>
Subject: Re: [PATCHv2 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range_buggy
To: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, 
 Michal Hocko <mhocko@suse.com>, stefanr@s5r6.in-berlin.de, 
 Russell King - ARM Linux <linux@armlinux.org.uk>, robin.murphy@arm.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_041103_881298_8B16F062 
X-CRM114-Status: GOOD (  17.41  )
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

Hi Stefanr,

On Thu, Jan 31, 2019 at 8:35 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use vm_insert_range_buggy to map range of kernel memory
> to user vma.
>
> This driver has ignored vm_pgoff and mapped the entire pages. We
> could later "fix" these drivers to behave according to the normal
> vm_pgoff offsetting simply by removing the _buggy suffix on the
> function name and if that causes regressions, it gives us an easy
> way to revert.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Can you please help to review this patch ?

> ---
>  drivers/firewire/core-iso.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
> index 35e784c..99a6582 100644
> --- a/drivers/firewire/core-iso.c
> +++ b/drivers/firewire/core-iso.c
> @@ -107,19 +107,8 @@ int fw_iso_buffer_init(struct fw_iso_buffer *buffer, struct fw_card *card,
>  int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
>                           struct vm_area_struct *vma)
>  {
> -       unsigned long uaddr;
> -       int i, err;
> -
> -       uaddr = vma->vm_start;
> -       for (i = 0; i < buffer->page_count; i++) {
> -               err = vm_insert_page(vma, uaddr, buffer->pages[i]);
> -               if (err)
> -                       return err;
> -
> -               uaddr += PAGE_SIZE;
> -       }
> -
> -       return 0;
> +       return vm_insert_range_buggy(vma, buffer->pages,
> +                                       buffer->page_count);
>  }
>
>  void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer,
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
