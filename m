Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768B1C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:11:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D965208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nUB0Nwoq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LmCipauO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D965208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9Z4ERmrREh6GamLCrTYor0h92KCQdBSdhxe4gHFPjQ4=; b=nUB0Nwoqo2UqPw
	uapxp/ERZfvGesNhOjZIumJ5fmLTjuOuqzj0Aicx80FVqxslZlF7b/boC7A3YsnqS/9oI8sHQiaGl
	7LnEbJ/LAy6biyBhGUdhVHApyF8OTJYgd3NsYZA5rYe7I5Iw8NHaK8QCs5y8fTGX0Y5+gNlCXB3Sx
	N+cFDMIqWtYDXiKGjpAIFm1SRkrHbsvwy8nxVNMOA2Z/kuAgUyv6/O+tryylvvSCfwdvJaaXQdeY8
	M5PvYu+iP6VKnFapaeJIwi1EL7cn4hmVzPQkbBH6lDL8FwVzPces9U4wHI+XPVlPsepxADnb7YI+e
	3lwjZL1TfQ+ikwXYX6vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVFum-0004XF-Sy; Fri, 07 Dec 2018 13:11:32 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVFuj-0004WE-6m
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 13:11:30 +0000
Received: by mail-lf1-x142.google.com with SMTP id e26so2998611lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 05:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=EFj9X/innvkpACYNCTtZcY37pslKCk2J0+kVrFHIYOI=;
 b=LmCipauOb1yLA1CNjfxYn4Q7iy7tl70uGlFvAgMt74FNEpfLA2CjVMLuKDLmyxf9P9
 vaVmbpOIrI+S6dfKTq9sX/snFic79x2CqMlbxsMCJI1hHSf+subIIkVQuOXv2+B+LXjn
 xa+GDgGu0JMtiGoaSGSsjQTHibBTehXtos3U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EFj9X/innvkpACYNCTtZcY37pslKCk2J0+kVrFHIYOI=;
 b=OIZ8TwqY6sUfGcp4FSo99s/Xl4eD0VpoLRpxARntBNkHTaiFPZDrmqhDsKNvGAyDag
 NTdYlvK82d/eHrq4Xm2YwJVNOSvs3z1pJevBh5H6lZYVoVY6fmz9+xU1SCH4EY5kV2cN
 IW9yB2tjVFzFA8OJfDLkoOV6kdohee+bjOrizvKOW8s/SC3FaWwA+zJWVqzdBAsLATdW
 oQYY4zWQng2dqjhhsKItxAec0RKcH4AGn3Rlz10GcPzUEALo31LTdXBPkrALIKnxhvmO
 mHMGV2mUrCkWl5ZmylX9OqxFrmnOyiCfHeGeMcRlc9GtyXlbaEfj31vfHQCDaziPrt4H
 u2rQ==
X-Gm-Message-State: AA+aEWbCb4RKEMlesEFbpKE/FA5SviUg8bwa6T+Sr8Ik1/g9SDOGn/l1
 98/f8R7uxP9XpwB8PPVcqCxvr2xfexo=
X-Google-Smtp-Source: AFSGD/WYjfEugWJ/CiebXU8yXokboCL047BVIH5KUpU6vVPMwFkDZfarIwmrnaQbyupeZioH9F/HOg==
X-Received: by 2002:a19:8f45:: with SMTP id r66mr1413285lfd.9.1544188276612;
 Fri, 07 Dec 2018 05:11:16 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
 by smtp.gmail.com with ESMTPSA id
 i143sm604609lfg.74.2018.12.07.05.11.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 05:11:15 -0800 (PST)
Date: Fri, 7 Dec 2018 14:11:13 +0100
From: Niklas Cassel <niklas.cassel@linaro.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] PCI: controller: dwc: Make PCI_IMX6 depend on PCIEPORTBUS
Message-ID: <20181207131113.GA427@centauri.lan>
References: <20181206074555.19579-1-andrew.smirnov@gmail.com>
 <1544092136.3709.57.camel@pengutronix.de>
 <CAHQ1cqFeJtxnpfzqWVQ3T9Sv=gfw+cvZZw-uKnZV7pxJg_S+EA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHQ1cqFeJtxnpfzqWVQ3T9Sv=gfw+cvZZw-uKnZV7pxJg_S+EA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_051129_246238_B8D483D6 
X-CRM114-Status: GOOD (  19.75  )
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
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-pci@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 linux-imx@nxp.com, Bjorn Helgaas <bhelgaas@google.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 08:55:13PM -0800, Andrey Smirnov wrote:
> On Thu, Dec 6, 2018 at 2:28 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> >
> > Am Mittwoch, den 05.12.2018, 23:45 -0800 schrieb Andrey Smirnov:
> > > Building a kernel with CONFIG_PCI_IMX6=y, but CONFIG_PCIEPORTBUS=n
> > > produces a system where built-in PCIE bridge (16c3:abcd) isn't bound
> > > to pcieport driver. This, in turn, results in a PCIE bus that is
> > > capable of enumerating attached PCIE device, but lacks functional
> > > interrupt support.
> >
> > This is odd. AFAIK PCI port services are a totally optional thing and
> > them being absent should not lead to a non-functional PCI bus. So I
> > would really like to see some deeper analysis what is going on here.
> >
> 
> AFAICT, this is due to pcieport driver enabling MSI of the bridge
> device (16c3:abcd) via pcie_port_device_register() ->
> pcie_init_service_irqs() -> pcie_port_enable_irq_vec() -> etc.
> 
> I did an experiment on a i.MX8MQ/PCIE -> i210 setup I have: I disabled
> CONFIG_PCIEPORTBUS and hacked igb_main.c enough to make the i210
> driver believe it should fall back onto legacy interrupts. Even
> without pcieport present in the system, i210 worked as expected via
> legacy interrupts, which seems to collaborate my conjecture above.
> 
> Thanks,
> Andrey Smirnov

IIUC PCIEPORTBUS should not be needed for MSIs to work,
it is only needed if you want e.g. PME or AER.

The difference is that if PCIEPORTBUS is enabled, a MSI irq vector will be
allocated for the Root Complex itself, so that it can send an irq when
e.g. AER has detected an error.


If we disregard that MSI handling is currently broken on DWC PCIe:
https://marc.info/?l=linux-pci&m=154214986924244&w=2
It is very possible to have MSIs on dragonboard 820c, which also
uses the DWC PCIe controller, without having PCIEPORTBUS selected:

# zcat /proc/config.gz | grep -E "PCIE_QCOM|PCIEPORTBUS"
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIE_QCOM=y


# lspci -v -s 0000:00:00.0
0000:00:00.0 PCI bridge: Qualcomm Device 0104 (prog-if 00 [Normal decode])
	...
        Capabilities: [50] MSI: Enable- Count=1/32 Maskable+ 64bit+

# lspci -v -s 0000:01:00.0
0000:01:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter (rev 32)
	...
        Capabilities: [50] MSI: Enable+ Count=1/8 Maskable+ 64bit-


# cat /proc/interrupts | grep MSI
 70:       5620          0          0          0   PCI-MSI 524288 Edge      ath10k_pci

So perhaps this is a bug specific to imx6?


Kind regards,
Niklas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
