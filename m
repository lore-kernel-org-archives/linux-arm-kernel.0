Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECF1C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:07:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0734F20700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A/+KMgWL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrvdDpAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0734F20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IeujGU9qkGfq8fprL8GXjitxLx0ZgnbouT01pODjWqc=; b=A/+KMgWLLVdHOx
	r/uldQpWgL3k0vG/T6Hvh071HtMHwmuoPevYKjvEFtBshZAnN7nk0SAvcRFIDnjzbmUUyzIuQ94ik
	bKYgK4B+Wk+01H1FvKfSgRMEOKz7hueKFbBso8yOFJef14fJDZ63Hp8rHZhj5LakZZv8IOpYWZuVj
	21DnhiUBg7lMIDFs7YGGuoJLv2niyNGANKHXqWxwVZ9Ll2UA8VeYVRdplbL8p1NpYm2MoUytdVJqY
	WiW41QiZaj3Y0Q5m8Hb3mDQ3ff9DKqS0LNpZU9s3LEFkt4k5oOdGACvQQmMyiJ7Cybrf6Cmlhwxzx
	WnGM7Eb2bZpGK1sx1aQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtbX6-0005hx-Rg; Tue, 12 Feb 2019 17:07:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtbX3-0005hZ-PC
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:07:43 +0000
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 839DE217D9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 17:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549991259;
 bh=MeHHuPu0Pdq3s5h/Max33zQatHui0w5NnFPlRdmJvjg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=CrvdDpAxKtvjcZ8SOHhIFk/vPkNSnQfJ6UX4p3e/U7lbr6MfDWwqF3mNgZZkRPHKu
 mu3lZhgwybhPPTjmeEiay+kEpjEL/NJheamn/S8XH52/66hJjyiB0m+YMrt82KT/BF
 MrI/K9vzM81soqoUHEZqss8X3zclg+1aLdObkhAo=
Received: by mail-ed1-f43.google.com with SMTP id h58so2838031edb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 09:07:39 -0800 (PST)
X-Gm-Message-State: AHQUAuZ+4t+8q3bRIThTko9ViLG2Rkj1+OqlepQLrU12Dt1YifBdduq9
 5EkF0qBpjE3I0mvo+WkANX6qQY2/tc5z6syXrag=
X-Google-Smtp-Source: AHgI3IYqn69oQbKy3U6QIxj4nGb7YIBe/HEIXeOgvT9NZ/n7BRrrSAv19XXFH4OzqVWX+meaVfNi0ZFjDqiteW2+8AA=
X-Received: by 2002:a17:906:49a:: with SMTP id
 f26mr3514106eja.15.1549991257931; 
 Tue, 12 Feb 2019 09:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20190211161754.23902-1-nava.manne@xilinx.com>
 <CAAtXAHfXaerVYzfdnA_09rK5AgLVJAiRcE2KEqosfrMZBuO3xQ@mail.gmail.com>
In-Reply-To: <CAAtXAHfXaerVYzfdnA_09rK5AgLVJAiRcE2KEqosfrMZBuO3xQ@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 12 Feb 2019 11:07:01 -0600
X-Gmail-Original-Message-ID: <CANk1AXTSE+JXn1rinhdxeuOHgFZKga6SvGvTcNwN1knSNxwjjQ@mail.gmail.com>
Message-ID: <CANk1AXTSE+JXn1rinhdxeuOHgFZKga6SvGvTcNwN1knSNxwjjQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
To: Moritz Fischer <moritz.fischer@ettus.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_090741_837328_0256E8BF 
X-CRM114-Status: GOOD (  13.24  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Devicetree List <devicetree@vger.kernel.org>,
 Nava kishore Manne <nava.manne@xilinx.com>, linux-fpga@vger.kernel.org,
 Michal Simek <michal.simek@xilinx.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jolly Shah <jollys@xilinx.com>, Rajan Vaja <rajanv@xilinx.com>,
 Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 kishore m <chinnikishore369@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 5:06 AM Moritz Fischer <moritz.fischer@ettus.com> wrote:

Hi Nava,

> > +       mgr = fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
> > +                             &zynqmp_fpga_ops, priv);

Please use the new devm_fpga_mgr_create()

> > +       if (!mgr)
> > +               return -ENOMEM;
> > +
> > +       platform_set_drvdata(pdev, mgr);
> > +
> > +       err = fpga_mgr_register(mgr);
> vs here.
> > +       if (err) {
> > +               dev_err(dev, "unable to register FPGA manager");
> > +               fpga_mgr_free(mgr);

With devm_fpga_mgr_create(), this fpga_mgr_free() can go away.

> > +               return err;
> > +       }
> > +
> > +       return 0;

Thanks,
Alan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
