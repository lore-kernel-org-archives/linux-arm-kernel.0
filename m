Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7564EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:42:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458242089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dPDMogMW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOhdmRkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458242089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rGXQLhDumKi21RA4VLEisBw7v7TerKZ8Wx/3Nh002LY=; b=dPDMogMWuF6qqK
	kcNcEfVxMsWdb2quxvsthNvQ8un80gQYzEjBxseUK1dofpHKVfmw6+ledox9YgJ1ky0gKtoLZ63iX
	YwzuIRr3NrgyAhPweQRfuCRbngpTtqqhZLBx5BLVmQ4Nn7nSFKek6VYI3LBw+9Bt8SbjyQGrdJdzV
	SXQtFQoig7iwDd+9qGR2hBcVOl9FmCc1AjSxmcZ+RN0Qnnr5p8+U9Gpyuu/k8HAMPYJxMb0bm7FL4
	5DhFzHFQoGZkMpFps5K7MhsRwjV/XOdY1PYEuVfP5YY7gayyXm+RrSr+yoXTacN23NNefiWRKKKDH
	zpo4r+dmTsZ05FSKM1Kw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggm26-0004c0-Ej; Tue, 08 Jan 2019 07:42:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggm22-0004bO-SW
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 07:42:40 +0000
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6314F2089F
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  8 Jan 2019 07:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546933357;
 bh=U8LTxlLkvrlvXtFk9537u+7EhPu/K5r0M0XVwpMvKT4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=XOhdmRkja7MF7K0aVcRp+AXSyViDqYmhsEiYYLqSi1/DbuJ+C6OLgrAjc4SHlgBem
 RnlIEPSfrrPrdMluukpWQZGfSeJmixYNf0/USVmEAGkN/qTnur4QoeB0Ufmjvpxu9U
 6j6D9XfWLysYybFAsNSwivCLZktXH7WZX1mMQdY4=
Received: by mail-lj1-f169.google.com with SMTP id v15-v6so2523918ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 23:42:37 -0800 (PST)
X-Gm-Message-State: AJcUukfcBLdvn509khJPkDbvKU+r/vWTDlkQREaLycCW3zKCIFMASd4o
 UnROipjpT8IrBdWNwx3SEd/YxS77qslQH5aNbII=
X-Google-Smtp-Source: ALg8bN7OBqxzlKH0KZu5F41cdSrGrbch8RvAS82mdlGAKtoAdE5QvwGvZFMbbmylzd0260PvadqwnrWCkHPHu7dqXXk=
X-Received: by 2002:a2e:5d12:: with SMTP id r18-v6mr463850ljb.89.1546933355582; 
 Mon, 07 Jan 2019 23:42:35 -0800 (PST)
MIME-Version: 1.0
References: <20190103201408.GA27754@embeddedor>
 <20190107194324.GC3313@kozik-lap>
 <1abcd26c-aa10-9481-ed53-3c3654842757@embeddedor.com>
In-Reply-To: <1abcd26c-aa10-9481-ed53-3c3654842757@embeddedor.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 8 Jan 2019 08:42:24 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcKgFpRbFufxw5LVv-boWwdvSq-zG9gw1u7P9-f+5BJMQ@mail.gmail.com>
Message-ID: <CAJKOXPcKgFpRbFufxw5LVv-boWwdvSq-zG9gw1u7P9-f+5BJMQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: mach-s3c24xx: Fix boolean expressions in
 osiris_dvs_notify
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_234238_940848_70B370F4 
X-CRM114-Status: GOOD (  16.24  )
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
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Ben Dooks <ben@simtec.co.uk>, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 7 Jan 2019 at 21:33, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
>
> Hi Krzysztof,
>
> On 1/7/19 1:43 PM, Krzysztof Kozlowski wrote:
> > On Thu, Jan 03, 2019 at 02:14:08PM -0600, Gustavo A. R. Silva wrote:
> >> Fix boolean expressions by using logical AND operator '&&'
> >> instead of bitwise operator '&'.
> >>
> >> This issue was detected with the help of Coccinelle.
> >>
> >> Fixes: 4fa084af28ca ("ARM: OSIRIS: DVS (Dynamic Voltage Scaling) supoort.")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >> ---
> >>   arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 8 ++++----
> >
> > Thanks, applied with fixing up -Wparentheses warning. I think you should
> > update your GCC.
> >
>
> Thanks for that.
>
> I wonder if you could take these too:
>
> https://lore.kernel.org/lkml/418252fcd77472413ce15ac3df167e448a4defe9.1546667177.git.gustavo@embeddedor.com/
> https://lore.kernel.org/lkml/2795c5ba939fe23dda6c86135d56e68433f7d68a.1546667177.git.gustavo@embeddedor.com/

Can't do. I am maintainer only for ARM/Samsung platform and these are
for Integrator.

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
