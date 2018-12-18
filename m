Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F75C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:28:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B828C21873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aXG5Dfr5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGHJnHjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B828C21873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=clC56JcuIp8HwGJf9K5rs4beFh0aMlEiHD8xw0yZFvU=; b=aXG5Dfr5o5w/5o
	4j0KDfGrHBKN2nH9xjgNhS8XeJq0+ASKfd2lZ+fv9rrlW9Kl27omD833mhgdRgd+yqbnSx/aIB+hY
	5Ft7fNyi78yKuTsqVIDvXQMHH24ah+fd6K3+mm2lCHenrMGjJa83smOFNZ9ki0H+SqkOvZdQi2OIo
	i9McwHKTusIoGRvQ/2GJOIRyF1XYrDRTmnQrxlRgQBc6N/ReZnq/AztDs+JMcH1mZpU1kZWeVZR+2
	W365MCUre+QBymIQWCtNktl81rKZrcTANs5+JM1WmrbsC66Nus3/T2vW/itvofxy0xL/48cFM+L2c
	lBcDnyNQYfAvQ01aE7cQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZJAc-0005NX-AX; Tue, 18 Dec 2018 17:28:38 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZJAY-0005ET-70
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 17:28:35 +0000
Received: by mail-ot1-x344.google.com with SMTP id u16so16396877otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 09:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jPxa6cmxk0JfZ2/bP6d5fF6y05flOQRY758+8jg97D8=;
 b=MGHJnHjMJG4bvKIKlxOycxdove3hi7wYuX589IjZIJBBtM0AYwFqdqJYpK0VaOrL+u
 qOb5dtRtZJUEJCG1Kk8Vc6VanNKqR+IsQc4P0suimpyfOsWXQGqDyxCpDdc5N1HzIQ90
 DmJVo2CiGcBDO6c/+qp6q0JA68sMlawsxa2UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jPxa6cmxk0JfZ2/bP6d5fF6y05flOQRY758+8jg97D8=;
 b=ddkAgHJ4x10zzGUnmCfQZDXtIiYNWztU06sigu/kZh/Tn5ahBDvaSXOAw5R/E0pmay
 y9mX0hJyWsM4tzlSBNEITWGl9drllUg+gEUIeLEirYH+QaMbBZGyU6TcCEM2rMPgIUHZ
 3AtTyzWgKdgqCWw1BGVEjuuQM03wo7D2D9Gj8BgthDI0u/wEbCVJ2SGE8eEVL7mj9uBM
 4dwG5prlCxq/5e2U2xifT83gMm030WavifS+e/6lBBHPOnJUCOE1b0NgkVBeAQTFJ6oz
 iQO9i7DE9e3hFpKHOXBBH50et9YAqz4e79zkPVLdV/su+E6NVRp0HWC7+2lySRzZiB0U
 lo2w==
X-Gm-Message-State: AA+aEWbf1ArPZDFVC2TDBPYZhZNwmfIOfvCH2fTZ66ZJbb4SMYy2qIAn
 Vdh6+6YuXjP3rp1T61YbHusCG5b7pfPx6TW+AcK4vg==
X-Google-Smtp-Source: AFSGD/VcjxiYsEA5t/Da7MQXBmVYnNSborcalyA6jPgt0ZQU4dXUEJU+uEhgsKpEnAWUNCCJ3H+F9wbNv8xglOxrqbw=
X-Received: by 2002:a9d:3b77:: with SMTP id z110mr2516170otb.352.1545154103032; 
 Tue, 18 Dec 2018 09:28:23 -0800 (PST)
MIME-Version: 1.0
References: <1544645824-16461-1-git-send-email-Dave.Martin@arm.com>
 <1544645824-16461-2-git-send-email-Dave.Martin@arm.com>
 <822638a1-dbf0-ed4a-55a4-b908a4f13649@arm.com>
In-Reply-To: <822638a1-dbf0-ed4a-55a4-b908a4f13649@arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Dec 2018 17:28:10 +0000
Message-ID: <CAFEAcA_VnW4V9h+dkDxEjUk1dX1Tv_NrwzP14JyqV25+KyyFJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: arm64: Filter out invalid core register IDs
 in KVM_GET_REG_LIST
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_092834_253035_66890E63 
X-CRM114-Status: GOOD (  17.66  )
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
Cc: stable@vger.kernel.org, Christoffer Dall <christoffer.dall@arm.com>,
 Dave P Martin <Dave.Martin@arm.com>,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>,
 kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 18 Dec 2018 at 14:00, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> On 12/12/2018 20:17, Dave Martin wrote:
> > Since commit d26c25a9d19b ("arm64: KVM: Tighten guest core register
> > access from userspace"), KVM_{GET,SET}_ONE_REG rejects register IDs
> > that do not correspond to a single underlying architectural register.
> >
> > KVM_GET_REG_LIST was not changed to match however: instead, it
> > simply yields a list of 32-bit register IDs that together cover the
> > whole kvm_regs struct.  This means that if userspace tries to use
> > the resulting list of IDs directly to drive calls to KVM_*_ONE_REG,
> > some of those calls will now fail.
> >
> > This was not the intention.  Instead, iterating KVM_*_ONE_REG over
> > the list of IDs returned by KVM_GET_REG_LIST should be guaranteed
> > to work.
> >
> > This patch fixes the problem by splitting validate_core_reg_id()
> > into a backend core_reg_size_from_offset() which does all of the
> > work except for checking that the size field in the register ID
> > matches, and kvm_arm_copy_reg_indices() and num_core_regs() are
> > converted to use this to enumerate the valid offsets.
> >
> > kvm_arm_copy_reg_indices() now also sets the register ID size field
> > appropriately based on the value returned, so the register ID
> > supplied to userspace is fully qualified for use with the register
> > access ioctls.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: d26c25a9d19b ("arm64: KVM: Tighten guest core register access from userspace")
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---

> I'm quite keen on queuing this for 4.21, but I'd like Peter's seal of
> approval on it.
>
> Peter?

Sounds plausible, but I'm on holiday now til January, so if you
want a more detailed response than that (or even actual testing
with QEMU) it'll have to wait til next year. (Note that I never
tested d26c25a9d19b with QEMU either...)

thanks
-- PMM

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
