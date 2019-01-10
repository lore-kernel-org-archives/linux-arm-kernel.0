Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67640C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:01:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B32208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ppd9vLxu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qv4UO6Fp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B32208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9cBVvm/aoN3gdbXbh7LjQlN1pES4G6bsUaHCaEFuKWk=; b=ppd9vLxub12L6M
	wb957GmKCHCtXYjb01lASurI3LyTQzwNrDoaol2Imx78xnsHRep8LBUhTokf8ypTQhxKzQzy9RY7O
	Gf7+LaWXd7uHMcmaJGU6hXoCniQ7I26msPMUmbylC9F+1EW66AL7CECuVanFIcfoMJrRqk08giiAh
	tcgL6AmfaUqe/us9iSteyuAS1YnDFP9Vt0RRxTyXJ6EYlJL9xSYhR0j0Jfen1roKp5RuFfUn0ShsH
	CpNPCgnekRe+ZuCKS1SYtYm9erCGYhGZ6eEiC0oH7D6KvSORMSH6JoNvQftIuoHnzCbgolXrRJX2q
	jbSISCSKluoNWNk7m49A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghhSS-0006cD-TS; Thu, 10 Jan 2019 21:01:44 +0000
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghhSP-0006bm-Dn
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 21:01:43 +0000
Received: by mail-vs1-xe43.google.com with SMTP id n13so7914735vsk.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 13:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BwQUwoxWE9xddt/5B/7ivk+f8UFrG0jsvJWk4vuuwFQ=;
 b=qv4UO6FpqbcXjESpEyv6dMMa0ZVDKl3AXXY3Z6ghoqkOyRPJSb2wxDdd9jY9/MQqDz
 ZNxeGNGg13e5BuSafswztXuyY+nVAD+KTFUyapwOv6M4lK2tX6RZ2GVZPk4tFBp4X9Kp
 GhFvUnmyfOcEd+ZzfLzkXNw8lZepJZ3YANpPesKc9HztZhEUJvva5RQvpZmygFBctHlb
 iY2vT1hiRBdDIxQ53VEInE9XoL77Yd6Kcx+UTYCnO0vXHkopySwwJqzoxNTmUnWlOr5U
 qNyCfYclsQZLlURpkiOT1QeuJ1/thy9dmNNnV9/15lfHi786u+TmLJGuITP05OsWOKJ5
 nkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BwQUwoxWE9xddt/5B/7ivk+f8UFrG0jsvJWk4vuuwFQ=;
 b=dJIzJJiG7/nDg+FXQ6QudZTpEgLj13DDf4x9YEGA8fu1ttygI9v21+Z9rjin/dU38k
 jrM2MuQbaBGyRueojuROBGMKvXLYBuF0SFiDwUMjkrYYU/Nk5r265e7+FrYiDUvZPglf
 vqlLlsRYmphuA+QLShvCrCc44n1Kig5PJCwqdwN8VxmSgqOSwjpP3ZPN7xmAn2qj4t2m
 RFXXSGufQ0XbFVBfMv2J1moxj/KdmzOzoT2yJfxQQgHhp9wmmGisYd97AagcNW+4fl7I
 dr5Oi+NT1w/xsVwrCsVBLmuxXuyfct/I/vG5EZEtHIV50pWsHEztKTZcpVOwyIDGAWzw
 Cg2w==
X-Gm-Message-State: AJcUukcYjxRdjE7lkAJlMoP+8liwSE2eo56n9A3VdjUE/Wj3Zt7e0UzN
 6oVasUc8YqKgtb2uODGXBKmnEzskgd9Rw6d8L3Y=
X-Google-Smtp-Source: ALg8bN7/euEd7hrNjX8CZxbHBxPuqP9dEQzhslf1LrRY1c4u3M0PvYOPaAqoVJxODXBanGQcn9ihKfe8zsRMn3xd7qk=
X-Received: by 2002:a67:6b07:: with SMTP id g7mr4545930vsc.150.1547154099333; 
 Thu, 10 Jan 2019 13:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-11-james.morse@arm.com>
 <20181211183634.GO27375@zn.tnic>
 <56cfa16b-ece4-76e0-3799-58201f8a4ff1@arm.com>
In-Reply-To: <56cfa16b-ece4-76e0-3799-58201f8a4ff1@arm.com>
From: Tyler Baicar <baicar.tyler@gmail.com>
Date: Thu, 10 Jan 2019 16:01:27 -0500
Message-ID: <CABo9ajArdbYMOBGPRa185yo9MnKRb0pgS-pHqUNdNS9m+kKO-Q@mail.gmail.com>
Subject: Re: [PATCH v7 10/25] ACPI / APEI: Tell firmware the estatus queue
 consumed the records
To: James Morse <james.morse@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_130141_495386_4B85B1DF 
X-CRM114-Status: GOOD (  19.96  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, linux-mm@kvack.org,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Xie XiuQi <xiexiuqi@huawei.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 kvmarm@lists.cs.columbia.edu,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 1:23 PM James Morse <james.morse@arm.com> wrote:
> >>
> >> +    if (is_hest_type_generic_v2(ghes) && ghes_ack_error(ghes->generic_v2))
> >
> > Since ghes_ack_error() is always prepended with this check, you could
> > push it down into the function:
> >
> > ghes_ack_error(ghes)
> > ...
> >
> >       if (!is_hest_type_generic_v2(ghes))
> >               return 0;
> >
> > and simplify the two callsites :)
>
> Great idea! ...
>
> .. huh. Turns out for ghes_proc() we discard any errors other than ENOENT from
> ghes_read_estatus() if is_hest_type_generic_v2(). This masks EIO.
>
> Most of the error sources discard the result, the worst thing I can find is
> ghes_irq_func() will return IRQ_HANDLED, instead of IRQ_NONE when we didn't
> really handle the IRQ. They're registered as SHARED, but I don't have an example
> of what goes wrong next.
>
> I think this will also stop the spurious handling code kicking in to shut it up
> if its broken and screaming. Unlikely, but not impossible.
>
> Fixed in a prior patch, with Boris' suggestion, ghes_proc()s tail ends up look
> like this:
> ----------------------%<----------------------
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0321d9420b1e..8d1f9930b159 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -700,18 +708,11 @@ static int ghes_proc(struct ghes *ghes)
>
>  out:
>         ghes_clear_estatus(ghes, buf_paddr);
> +       if (rc != -ENOENT)
> +               rc_ack = ghes_ack_error(ghes);
>
> -       if (rc == -ENOENT)
> -               return rc;
> -
> -       /*
> -        * GHESv2 type HEST entries introduce support for error acknowledgment,
> -        * so only acknowledge the error if this support is present.
> -        */
> -       if (is_hest_type_generic_v2(ghes))
> -               return ghes_ack_error(ghes->generic_v2);
> -
> -       return rc;
> +       /* If rc and rc_ack failed, return the first one */
> +       return rc ? rc : rc_ack;
>  }
> ----------------------%<----------------------
>

Looks good to me, I guess there's no harm in acking invalid error status blocks.

T

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
