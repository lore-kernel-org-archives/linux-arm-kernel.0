Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41CFC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:57:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7127320868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LTVRXT3O";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZhDAXKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7127320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GIm/nC137FDNaLA7L2HtkNym1ORDLqH4F4UzJR1IPCY=; b=LTVRXT3OYdNWQf
	9p/FVRVNnjC/V/vFYwMtAVo7TTWYScVsPJjf/TXhorD9ufKGUCNwYd4QDg5saPBYawy3Xlormtswc
	MQ1dHrhq/DNWJZ8W3Ksebh0t7Yw1b9E104i1sLZavznc3D/J2y5edBlzQigb/F83n5daaXd9iLrir
	vF8K+vD+0P7xz3yfS5QAXgFbdSZAKe73HFiylUjXto9zJ8kJxgUmz1WJO8gejTR4Uv79wbWDN60Ej
	4KXyQoxCk3xovvT9KpKvceTS6Kw1pWP1uNOeFNlEYAHO3afpNH9IzZTVnGqwvFehFv3uUSryFDBO1
	410AwZNhPtguNyxWMfLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVQ0C-0002cj-OO; Fri, 07 Dec 2018 23:57:48 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVQ09-0002b7-1O
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 23:57:46 +0000
Received: by mail-wr1-x444.google.com with SMTP id x10so5287171wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 15:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zuI5BM8BJUUW4hwIYwyotIWwbWzJMAnMpCLQgttFJfg=;
 b=pZhDAXKEaTKTh78xyN+jQ5G0IzwQT1+ANOi6LzfODi9q9VGsK5AZ/lZYn7HYggHQp/
 cG1j2s5kgkt4803H22UidaqyFuhmjil/IkiJGG30U+8x+R2dKOx7YQRnp2xyMFDwyeP8
 UgemmGRBirxJBxcifXXBLJx+anmRPSEqpj/S1l7CY7yOs1voNLRUhJA4UN3hL4pAr0XY
 U4hDZJ6I6NNTL8/nePzE6gva7u0zo6xwfQQeTqj8xiDacceQ5Z7xpv9rViq9OhPqNBVn
 RLReTM5Qk1VMbvleaN4r4irsruA3tHw4jl0owFQXQy4EMc2MVNBDSHkImkDULrFyypLo
 YtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zuI5BM8BJUUW4hwIYwyotIWwbWzJMAnMpCLQgttFJfg=;
 b=L0v4t8dNsEwpVSgv4fcnBetIMmif3f0oJdm9CR0EbT2Tcongni7ljj1wlfiWnpM1xc
 EmpNP5f5yQ2FNcnBo99rmJfkOM88k8k2Wy8zmyCoy84Fmk19ff+ns4k2AGMKu6pwywCL
 dgCQn+Hzs9avuEjvZdzHMYD8qxMgMoil9ymPXDxvlnn1q6oThahX7NmtDewcFl0MPERn
 sJdQ5lwN9LKYh7QdabIpxy1UbpxXDzCZPd6LiAFSa+vsGPZLqiCc2w7WraL9Tfxvk6TD
 MTcuLlKnlR26QCo6Ic+FNm9SI2wcRgcvjEpneSp7ARsDohiyQq2ya/RBIl6pyHsa1g7p
 7ucA==
X-Gm-Message-State: AA+aEWZZyLpYkZUx6Sv0XBsSte+uRvRu6fx4+VJVWQGvrZbJnp7FaXj+
 6sYFDDqBgFKi3DLKwSrCHj/n1sIEajLeswFhyeI=
X-Google-Smtp-Source: AFSGD/WL1oHGjZyMqbJ2Cj2+h9N8Zpnbse6pWA7TZs4OfiVuEGXVoOtbCXdDi8mAqAWcz/S1c6CMhs4Pe19V6NUvk9k=
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr3202946wrq.5.1544227053060;
 Fri, 07 Dec 2018 15:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20181206074555.19579-1-andrew.smirnov@gmail.com>
 <1544092136.3709.57.camel@pengutronix.de>
 <CAHQ1cqFeJtxnpfzqWVQ3T9Sv=gfw+cvZZw-uKnZV7pxJg_S+EA@mail.gmail.com>
 <20181207131113.GA427@centauri.lan>
In-Reply-To: <20181207131113.GA427@centauri.lan>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Fri, 7 Dec 2018 15:57:21 -0800
Message-ID: <CAHQ1cqFtnSrP=kNzZrFb7kf4i0-zn90k9JFpektFhh-5_HenBA@mail.gmail.com>
Subject: Re: [PATCH] PCI: controller: dwc: Make PCI_IMX6 depend on PCIEPORTBUS
To: niklas.cassel@linaro.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_155745_079990_63B1E93F 
X-CRM114-Status: GOOD (  20.48  )
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

On Fri, Dec 7, 2018 at 5:11 AM Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> On Thu, Dec 06, 2018 at 08:55:13PM -0800, Andrey Smirnov wrote:
> > On Thu, Dec 6, 2018 at 2:28 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > >
> > > Am Mittwoch, den 05.12.2018, 23:45 -0800 schrieb Andrey Smirnov:
> > > > Building a kernel with CONFIG_PCI_IMX6=y, but CONFIG_PCIEPORTBUS=n
> > > > produces a system where built-in PCIE bridge (16c3:abcd) isn't bound
> > > > to pcieport driver. This, in turn, results in a PCIE bus that is
> > > > capable of enumerating attached PCIE device, but lacks functional
> > > > interrupt support.
> > >
> > > This is odd. AFAIK PCI port services are a totally optional thing and
> > > them being absent should not lead to a non-functional PCI bus. So I
> > > would really like to see some deeper analysis what is going on here.
> > >
> >
> > AFAICT, this is due to pcieport driver enabling MSI of the bridge
> > device (16c3:abcd) via pcie_port_device_register() ->
> > pcie_init_service_irqs() -> pcie_port_enable_irq_vec() -> etc.
> >
> > I did an experiment on a i.MX8MQ/PCIE -> i210 setup I have: I disabled
> > CONFIG_PCIEPORTBUS and hacked igb_main.c enough to make the i210
> > driver believe it should fall back onto legacy interrupts. Even
> > without pcieport present in the system, i210 worked as expected via
> > legacy interrupts, which seems to collaborate my conjecture above.
> >
> > Thanks,
> > Andrey Smirnov
>
> IIUC PCIEPORTBUS should not be needed for MSIs to work,
> it is only needed if you want e.g. PME or AER.
>
> The difference is that if PCIEPORTBUS is enabled, a MSI irq vector will be
> allocated for the Root Complex itself, so that it can send an irq when
> e.g. AER has detected an error.
>
>
> If we disregard that MSI handling is currently broken on DWC PCIe:
> https://marc.info/?l=linux-pci&m=154214986924244&w=2
> It is very possible to have MSIs on dragonboard 820c, which also
> uses the DWC PCIe controller, without having PCIEPORTBUS selected:
>
> # zcat /proc/config.gz | grep -E "PCIE_QCOM|PCIEPORTBUS"
> # CONFIG_PCIEPORTBUS is not set
> CONFIG_PCIE_QCOM=y
>
>
> # lspci -v -s 0000:00:00.0
> 0000:00:00.0 PCI bridge: Qualcomm Device 0104 (prog-if 00 [Normal decode])
>         ...
>         Capabilities: [50] MSI: Enable- Count=1/32 Maskable+ 64bit+
>
> # lspci -v -s 0000:01:00.0
> 0000:01:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter (rev 32)
>         ...
>         Capabilities: [50] MSI: Enable+ Count=1/8 Maskable+ 64bit-
>
>
> # cat /proc/interrupts | grep MSI
>  70:       5620          0          0          0   PCI-MSI 524288 Edge      ath10k_pci
>
> So perhaps this is a bug specific to imx6?
>

Yeah, that seems entirely plausible. I reached out to NXP via one of
the support channels to clarify. I'll report if I hear back from them.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
