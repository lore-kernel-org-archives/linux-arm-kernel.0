Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EBCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 00:09:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0B221019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 00:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K52TOJfR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GuJbCb3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0B221019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2glYx1k2Qhap2zt6S7WxDlfh1P2TpatDsVdFyj50soM=; b=K52TOJfRDuDe6s
	dbt2WVCUG+ISYCl1B2JSUUF3ykJfggmTmwTUFEY4OAAbV1Fm7PmYeLnQto6bkEVg84/5c8Lu4HbjO
	uQVMoFQ/Lc/Zc3EVRRh0cgkheW6UTu/3wWhdsIm2rwwZVhUOvOGlgpNcrPx5urHPOW94skOSKwfj+
	UBqCNfFnRwKvOfdHuKtCorIWjNep63pKrg0yVNjBAM5/Hh2aeDSB6HF6+Pc3uSsyYXT4qJtogriJY
	HxCfeHunvde206Ay316yDwqZN967MBJRC5u01CLk7eCSQDGnitajQrePEjX3SMczjosu6/YkPi7bD
	U/s1077bKIyuDrH7jQMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy3q1-0000BO-61; Mon, 25 Feb 2019 00:09:41 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy3px-0000B4-QO
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 00:09:39 +0000
Received: by mail-pl1-x644.google.com with SMTP id d15so3622387plr.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 24 Feb 2019 16:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mRL6UsEO/rvJ55w2sZtRGCTBil9aZeQ8KAlWhXZVy+I=;
 b=GuJbCb3eMvzjkg4qro6YPQvpox8bPAZ7vm1/gcP6GrfdT/+6jcWknXGKqZAUoGiISZ
 rdhahPnwLLfsbGZJMXtwgphzvo54SmuIzrM6x0O32mfA6g68+bGw6L04fvxeLDkXaV7a
 xFfi8+zZg4EPuPfI4S8H91mfjyVir1zCf2nnURJUWb43onTN7mDfU4XIPM0tsKG/ZHzL
 tbAHqVPgFplWf5fh/L/7g4WbXk7oYzokWEi3UN2WkgsXeBlsAzbROAfoqj31hGVSXF2G
 WtU59aM+CgoIqfY47NocAYFQZKOEK2tLeQdJ5h6NTwReWpnEBdSV8E6/asXaqjS0nu2E
 IdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mRL6UsEO/rvJ55w2sZtRGCTBil9aZeQ8KAlWhXZVy+I=;
 b=OAsHHoN7fOsftOoVMAkqeAKrMPLbm1rkOheuKt60dlZvljFtAwZmNd9W30RZQsimTS
 9bbRnKRogQTXL9tZo6TCwiXttTW/1AYCM1GFzOwFiAZIl8J0zGuQLASU4T4EedUuWRxc
 vU+9f2wyO+PTL9kwFX1LRoeFlrMqiji7tgOZ9V0VlG0k6RQY1Rkcfjn2fGcWFbtUBO0X
 IBfKZPFbtNpd2pMRBmuDkAiEm8PDtmFopq/b1aHQlg9MmBKfb5JSnNWDQgeNhaSq8GBT
 K3bWKBTNmeiWi5uGAo03SvHpTmQv5S1fjceaSFmFBIS5GwFkChgHqC0E1JvzoXJA67TL
 NZNA==
X-Gm-Message-State: AHQUAubD82hVEavNJxw8SOgrbZDLAUVmGQUlLKRlDqYhHdXAcxPnS104
 vEioi//EtDtofRR7A9DVtt2OFA==
X-Google-Smtp-Source: AHgI3Ibxx/zmd2DOPmb4iIjFvR93y7aeEA6esy8u2ty56xR6wqUEXRwrPBNnlC0R1/+HxDWVxw8AUA==
X-Received: by 2002:a17:902:145:: with SMTP id
 63mr16881078plb.256.1551053376828; 
 Sun, 24 Feb 2019 16:09:36 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([240e:e0:f891:19f7:b1b0:fed6:e3b3:4ba1])
 by smtp.gmail.com with ESMTPSA id 70sm24500168pfr.43.2019.02.24.16.09.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 24 Feb 2019 16:09:35 -0800 (PST)
Date: Mon, 25 Feb 2019 08:09:17 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v1 2/4] KVM: arm/arm64: vgic: Improve comment on
 kvm_vgic_inject_irq
Message-ID: <20190225000917.GA4001@leoy-ThinkPad-X240s>
References: <20190222082327.3312-1-leo.yan@linaro.org>
 <20190222082327.3312-3-leo.yan@linaro.org>
 <20190222083756.359523ca@why.wild-wind.fr.eu.org>
 <20190222085439.GA845@leoy-ThinkPad-X240s>
 <20190222093923.09e36583@why.wild-wind.fr.eu.org>
 <20190222124906.GB845@leoy-ThinkPad-X240s>
 <86r2bzrful.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86r2bzrful.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_160937_978044_18A24EB7 
X-CRM114-Status: GOOD (  18.63  )
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 Jun Yao <yaojun8558363@gmail.com>, James Morse <james.morse@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 03:40:50PM +0000, Marc Zyngier wrote:

[...]

> > > The interrupt affinity is either defined by the distributor
> > > configuration (SPIs) or the ITS configuration (LPIs).
> > 
> > Given to the up example, I am struggling to understand how you can set
> > the interrupt affinity for virtio device.
> > 
> > Do you set the physical interrupt affinity to CPU0/1 in host OS and
> > forward it to guest OS?  Or set interrupt affinity in guest OS (I
> > tried on Juno board to set irq affinity in guest OS from
> > '/proc/irq/xxx/smp_affinity' but failed)?   Or this is accomplished by
> > user space tool (lkvm or qemu)?
> 
> virtio interrupts are purely virtual, and the host plays no part in
> their routing (nor does userspace). As for their affinity, that
> depends on the virtio driver. Some virtio devices allow their affinity
> to be changed, some don't. Here, this is a virtio-net device, which is
> perfectly happy to see its queue interrupts moved to a different vcpu.
> 
> I tend to run irqbalance in my guests so that it actually exercises
> the affinity setting in the background.
> 
> > Sorry if I am asking a stupid question :)
> 
> It's not stupid. You're simply confusing multiple independent layers.

Thanks a lot for explaination, Marc.

Thanks,
Leo Yan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
