Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85ADC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:11:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9204021873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oNZI6whE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="daQMLvWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9204021873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+dg8aRNO54PuZw6YOSeWhyXYp2AbI2GCOHRvBNM0rmw=; b=oNZI6whEECHgzj
	vAwIwhFLm2r8xFKTVx/nMpAN0mwJeDP5JeaABcLlvB0e5CrmMXAaD+dn4diGcCe/h2GE1NuOL6xTF
	YpHS24WTPxcIs5FW8eEzG6UhmhF5K4mgaj6yJzaJm7hrGZUBksqFMxkZiG8NQdn48kq7VPUh0VBJE
	SpL/hf2rhtCiIuXhfhh4A6B2ND/uQZkJZEXgCXu/wDFi9BvyV03sgdfR4hfhH1/VUT+EZz0QGvq5d
	EMKBQmmPdST2Hq5PhXQyYM5uutK8ZNk/fbWzoh2Bl0oWcIQk8EFzyCHvQLjxcDRgxggwGoM1kJFmM
	Wt83uvPhm6hQepDJBTug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyk0b-0006RM-Pj; Tue, 26 Feb 2019 21:11:25 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyk0Y-0006QC-0f
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 21:11:23 +0000
Received: by mail-wr1-x444.google.com with SMTP id f14so15577860wrg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 13:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vqn5xeXHz4o/Av3EPiyID6FO61P3niCXIqush6ZbzRg=;
 b=daQMLvWjgQfTvZQWjCi8VCLIYQnxrOTOf2ZmjT+6z9o8iDF3aPTAOIc/VzJpeRiFVC
 ZQf08kCHnvw4zTZFrWLxEAh4K7hIz/1IXDQZWPiGEI9w0hgW1p6kTn0/Q/NyMwzfF2oW
 eJVjbiVZTY+B98yNec3rb4n7NGq8BalqkFQlpGyX1WNME5cLMMsow3nIbr8GEWXGceUA
 XPQiXQWy5R9UYpmOvDsBBNLQ1aeHUybfZak4tmZN/yC6C7XWtPbQZzqkJIM/RMGJfxAS
 eRrD9zI2zwAh3SqU210pnzfRvJjzQPbwmRvlhdtUTK+uGx5DSp/pkkPeTlf0DQlR75oR
 2trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vqn5xeXHz4o/Av3EPiyID6FO61P3niCXIqush6ZbzRg=;
 b=KqRp+CdglAx/s8OPiHinC80X2A0SktKlHUqxnEu17K04kypTD6M2FRwFq2WSyHM+PM
 nTcl4lZXD4z1gGCbl3qfn8nIujNPNjCJ/AldCsTVU0vwJ0X9fkxdmYsS40gMPcV1JTO5
 enITdEuFluhgK6/9+VNDvNh94LhOt2w/EuVXVZ0bWsRGv9jT7S8iPS2y+fUv/HicA/Yw
 wPlfvslhdwiUhRS3b/4naPp6ZeEUK/kvADehKbqTtVrgDBvjfM35kA1eVu8EMXOJGV3y
 knbKcHcA3YskgPun2ea/BLHpv92/+iYijWZN9kNfoc/mp+SPHZVmA6TWXYHsOq4WSTxX
 iFaA==
X-Gm-Message-State: AHQUAuaKozJ2C+fELLQof8XIQihgDytgAnz+QIm6pvz+XA+8Rr9Npq0O
 KzD7SQQkBa+00sEKWDnHGuECT3alZ8v6xIc883zw
X-Google-Smtp-Source: AHgI3IZvuu9p3VLciqyaCFJPQRlVRNK8U7H585OCHKcpRHntMLGc+3l/+g59CTqGzXyruBlLmFUbvviMEA17ynwmz8w=
X-Received: by 2002:adf:e5cc:: with SMTP id a12mr19229338wrn.130.1551215475293; 
 Tue, 26 Feb 2019 13:11:15 -0800 (PST)
MIME-Version: 1.0
References: <20190226194806.34fc23b5@xhacker.debian>
In-Reply-To: <20190226194806.34fc23b5@xhacker.debian>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 26 Feb 2019 15:11:03 -0600
Message-ID: <CAErSpo4uC6WMt-RNxn6_XG9Lcy+jA0X2bLF3cpVDWC9Sh6AbaA@mail.gmail.com>
Subject: Re: [PATCH 0/5] PCI: dwc: support remove
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_131122_057345_2A2C1FE8 
X-CRM114-Status: GOOD (  10.64  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jingoo Han <jingoohan1@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 5:55 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
> Currently, the PCI dwc host users don't support the remove, but nothing
> prevent us from supporting it. To achieve this goal, we need to ensure
> we can do necessary clean up work.
>
> Jisheng Zhang (5):
>   PCI: dwc: fix dw_pcie_free_msi() if msi_irq is invalid
>   PCI: dwc: free the page for MSI irq in dw_pcie_free_msi()
>   PCI: dwc: free msi in the error code path of dw_pcie_host_init()
>   PCI: dwc: use devm_pci_alloc_host_bridge() to simplify the code
>   PCI: dwc: save root bus for driver remove

If you post a v2 of this series, please:

Capitalize the first word of each subject, e.g., "PCI: dwc: Fix
dw_pcie_free_msi() if msi_irq is invalid"
s/irq/IRQ/
s/msi/MSI/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
