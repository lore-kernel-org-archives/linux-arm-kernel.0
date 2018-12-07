Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1C1C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:55:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C927A2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="niGufGvu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRMyYvXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C927A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nv6UDO+Eq7VbyAVQFRbeCnX1G87mHkDYHK2qMRA/T+c=; b=niGufGvuFRG/Yb
	jCJpNMNKH/IuGlLHDopkZMm586A4HKy8WbH+V3NrWwle+xmdAhB8pcv9RQDkWgHF+nhDo0CnNMEIo
	+xunE9vrHkmzbuNDyf2Uck+NxlnkSWQ9HZvKUrbKLHvdW0D/HpLydki2gLpIFKEQKKMGBHlXl2Pyb
	XU2UxgFB1DvEp6KqhluTWLTzuXzEQgPmjilLkW+1Qhkdim/7vfQkJ6AuIxnmxo6loS1tgqpCvLVny
	l6g2CQ8lixGXsFbkoR23wD/IripfrEqNFGK13G92Nabjc0GMw1VGJjUpEnxfLrskJ4EOEdSsvw5Ki
	W8dA1LKtfC33wq7ac+Xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV8Ax-00060g-FS; Fri, 07 Dec 2018 04:55:43 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV8Ar-0005zy-8V
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 04:55:41 +0000
Received: by mail-wm1-x342.google.com with SMTP id c126so3188652wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 20:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FI059+PUySrZpDCKnJZdfS9mUaz4H0QkSomxsjPgG5U=;
 b=jRMyYvXIn6Oo8/NyHT6lKnQ/fYpPc5iq1bfKOvGZ8J4AiFCsE0qM8W8JLnbkq9lr2v
 a+l6ViDkWrw5dSJ2lokitm2wpniqllwYVoPNDyJXCLFbbq+1LP7P6JsepqaulNisRBiR
 vD2cBHvNzC5ZCpuhzzfFpkD0/wFQ7H3tEHzObV+/wGOEuIiB7JLJdv1rk6oCl1BBfri4
 y9Gwl7aBAqiFeUA0/67Z53B/LP2AXgdJQkNVbm7izI7QYJB25AnIOM+EjnJ0g9UNEY5e
 ZQaANRRV+fp6e5S6HRMDkO77ZAzwpbfjIaLq5LlX6FAFsPEgvN29J5BE+/mxQRaNHaJa
 nLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FI059+PUySrZpDCKnJZdfS9mUaz4H0QkSomxsjPgG5U=;
 b=oTZRaQ6OZ4ZwDEH4ECrJUhZtrIuz/vnKlSZvic9mGyr4Lmpwk5iZ+WNxhrGk7BlXWd
 4n6YAPcNLUKDls2LWXXOU0Z8/HQZ6gemGSgtkvny/eC2bhdudzSg9aRy5Lf86emQxb3E
 TN4dB4OIe8X78x8GOFPhZMdH776ogPhk4C1Md0FB1JyO+Vx1CVEMVXnfP/vvcEnwPROk
 U7QV2vqP5W7BRg68fuAD0o2gTDjySnTKtq/3rwFdewOjHZG9AKFyRg5zasm3ef8wX1Rr
 sEer9gSn+W28WtauQCV28wmOoOAd4K9hdWYYaPWILk4RcMzQ+Ye3w4oAEeJSz4WXpa9y
 4slw==
X-Gm-Message-State: AA+aEWbhCeWlWi43HxlH9s/mZVRquDLDC1TJvGd9VKpEy61pBQaEz7Kw
 SYM4DBeQJimQefk6aWxEIh/YxYjtnNqnCgsVmfU=
X-Google-Smtp-Source: AFSGD/X1UJ4ujP4WZtgCTKzMuE45UOnd6c+UV6ew0wwcdhBostzHDDOdXy27O5Pk6YDMNCbU2L9BohQk4HEt8AXhzls=
X-Received: by 2002:a1c:5585:: with SMTP id
 j127-v6mr769633wmb.127.1544158525164; 
 Thu, 06 Dec 2018 20:55:25 -0800 (PST)
MIME-Version: 1.0
References: <20181206074555.19579-1-andrew.smirnov@gmail.com>
 <1544092136.3709.57.camel@pengutronix.de>
In-Reply-To: <1544092136.3709.57.camel@pengutronix.de>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 6 Dec 2018 20:55:13 -0800
Message-ID: <CAHQ1cqFeJtxnpfzqWVQ3T9Sv=gfw+cvZZw-uKnZV7pxJg_S+EA@mail.gmail.com>
Subject: Re: [PATCH] PCI: controller: dwc: Make PCI_IMX6 depend on PCIEPORTBUS
To: Lucas Stach <l.stach@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_205537_328694_33B107A7 
X-CRM114-Status: GOOD (  11.28  )
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
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-pci@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 linux-imx@nxp.com, Bjorn Helgaas <bhelgaas@google.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 2:28 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Mittwoch, den 05.12.2018, 23:45 -0800 schrieb Andrey Smirnov:
> > Building a kernel with CONFIG_PCI_IMX6=y, but CONFIG_PCIEPORTBUS=n
> > produces a system where built-in PCIE bridge (16c3:abcd) isn't bound
> > to pcieport driver. This, in turn, results in a PCIE bus that is
> > capable of enumerating attached PCIE device, but lacks functional
> > interrupt support.
>
> This is odd. AFAIK PCI port services are a totally optional thing and
> them being absent should not lead to a non-functional PCI bus. So I
> would really like to see some deeper analysis what is going on here.
>

AFAICT, this is due to pcieport driver enabling MSI of the bridge
device (16c3:abcd) via pcie_port_device_register() ->
pcie_init_service_irqs() -> pcie_port_enable_irq_vec() -> etc.

I did an experiment on a i.MX8MQ/PCIE -> i210 setup I have: I disabled
CONFIG_PCIEPORTBUS and hacked igb_main.c enough to make the i210
driver believe it should fall back onto legacy interrupts. Even
without pcieport present in the system, i210 worked as expected via
legacy interrupts, which seems to collaborate my conjecture above.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
