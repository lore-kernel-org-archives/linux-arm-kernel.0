Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FC3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:25:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6153620645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O8dllrHC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJcmN7HB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6153620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+XBFNs8lY2Ng3LzjfUakZ+eeeS1aEIx98VDc1HxFlts=; b=O8dllrHCJImkxE
	8jzQ0A+UTaVKlsPbBB8NCOTHncVY5SebpN4gFhBTteWXWU5xbhK6UKdnRPMPPA1TVSYJtEBhD+nXp
	Cnt/5+WYkxEKyWgv9J00VCyxHvw+rVPthvML7SinMvIcE7NlPDY52weFrZbbvz4SXSX/Z165akEhq
	cThD8heg2JhKflkZP0fMgiPgdC0gv7tpAA0YdZ5fcNitMf4V32JgQu1Q4m21MGu+yq6jhigU8cYOQ
	wvFAtuQoJRNRCXvPR2QmjHe7aFqUYorb/Tt7Ad/pm1HYO+g7kxPMI2ROCJi8Hi1U7uYIY/cEENbvc
	O6nxxzLAP9/z54er9ucQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gY2SA-0006Y2-Mg; Sat, 15 Dec 2018 05:25:30 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gY2S7-0006Wq-EE
 for linux-arm-kernel@lists.infradead.org; Sat, 15 Dec 2018 05:25:29 +0000
Received: by mail-wm1-x341.google.com with SMTP id y185so579141wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 21:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AFbplDPFVR8IjguHTaUgm10Ph2HuOvI6GzWtn3DhDHY=;
 b=UJcmN7HB8m+Lny2r580zxxMsj84JUEsOvWI2n5UbpgJ09yxAISUGb/FTSKhp5K93am
 4yDlzHHyXTsvpJ1MVyQ+ZeSsHTtbuWegITmxFuhJ2inU6lPF7RVvkvWCaehTq62l+fen
 3MgwsE6M0a+Tf+NK/wbvDyLffadGmlh2dJVssKj4nxoibazKMaL+j2dgZaWaCsoJK4hB
 FgmDXwynv6jG0H9gcwJ5AEalc57hVb84Z0G1Wv97MThh2L6KcfcxJtm62mhOt860yHST
 GE77RTs2sYGGsHc1Jn0XI+6qEoHvYubgHfUABnjStoCxDXPQRcueF/p4whqWdWJ2rWe7
 ++uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AFbplDPFVR8IjguHTaUgm10Ph2HuOvI6GzWtn3DhDHY=;
 b=WCWVBrsYbx+6W6wjUx7AC/zi1b7x5cbqYITOGkXGmLEQ2hBXspYVe3rpaLCqavIuU4
 Xe4yH9CrbFl92eBF7aDhSAhx1VTIRc2Agsocg9Jn2PsG9Kg6B1F7HiznGrz9URD91Pck
 dYRm3Xq3UUpQWDhzALXMVGjcRNoRUs9rW3YNbOFpnYt+AwIvbYvs2/xhRkDnsYY4r9Bw
 IBQULZ+r6kJaL8Xw6Ve8mQq1UsNUsRdSpZ7wTGYuS8pBicPIgLmiMgt3AMPw3dctozG0
 D8A59av7UuaXI8AlJ9xlgavQF15woiVKVoEV4FXz/aamLB4vWmeBE5K6QBBIH0MkaR+g
 7iCQ==
X-Gm-Message-State: AA+aEWaXewjP7K2Fu1kiE2jVNEYzyHuGOPlLX0/NO14jRPP6AiJ3WWRO
 Ex0+NtFYSQCN1RwMWmq9d3cwjo6cEtd/otLeNQc=
X-Google-Smtp-Source: AFSGD/VCwiyPHLqncxH9FtxhGLSi6Cu+BKOPjTeAP1+5DKDCWp+bSx3BeXvWjEbz+lGyk8kxTxowi2AwaPRyFHFOdK4=
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr4843718wmf.127.1544851515376; 
 Fri, 14 Dec 2018 21:25:15 -0800 (PST)
MIME-Version: 1.0
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
 <20181206121550.GA2725@e107981-ln.cambridge.arm.com>
 <20181214203828.GD20725@google.com>
In-Reply-To: <20181214203828.GD20725@google.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Fri, 14 Dec 2018 21:25:04 -0800
Message-ID: <CAHQ1cqG3s4J42V3oUPOGssUPw6dypZqYrtpkRphHPdiYFs9j1g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] PCIE support for i.MX8MQ
To: helgaas@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_212527_483302_A2ACAA70 
X-CRM114-Status: GOOD (  19.65  )
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
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 lorenzo.pieralisi@arm.com, Richard Zhu <hongxing.zhu@nxp.com>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>, Trent Piepho <tpiepho@impinj.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-imx@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 12:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Trent]
>
> On Thu, Dec 06, 2018 at 12:15:50PM +0000, Lorenzo Pieralisi wrote:
> > On Wed, Dec 05, 2018 at 11:35:42PM -0800, Andrey Smirnov wrote:
> > > Everyone:
> > >
> > > This series contains changes I made in order to enable support of PCIE
> > > IP block on i.MX8MQ SoCs (full tree can be found at [github-v2]).
> > >
> > > NOTE: The last patch have a Kconfig symbol depenency on [imx8mq-kconfig].
> > >
> > > Changes since [v1]:
> > >
> > >  - Driver changed to use single "fsl,controller-id" property to
> > >    distinguish between two intances of PCIE IP block
> > >
> > >  - All code pertaining to L1SS was dropped to simplify the patch
> > >
> > >  - Documented additions to DT bindings
> > >
> > > Feedback is welcome!
> > >
> > > Thanks,
> > > Andrey Smirnov
> >
> > Andrey,
> >
> > I have applied the patches, ...
>
> When I merged your pci/dwc branch, I noticed what looks like a merge
> conflict between these commits:
>
>   d123765b58ee ("PCI: dwc: Adjust Kconfig to allow IMX6 PCIe host on IMX7")
>   1a059d994189 ("PCI: imx: Add support for i.MX8MQ")
>
> d123765b58ee added SOC_IMX7D:
>
>   -       depends on SOC_IMX6Q || (ARM && COMPILE_TEST)
>   +       depends on SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
>
> and 1a059d994189 added SOC_IMX8MQ but dropped SOC_IMX7D again, which looks
> like a mistake:
>
>   -       depends on SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
>   +       depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)
>
> So my "next" branch[1] (current head 7053eeb009e0) is:
>
>   config PCI_IMX6
>         bool "Freescale i.MX6/7 PCIe controller"
>         depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)
>         depends on PCI_MSI_IRQ_DOMAIN
>         select PCIE_DW_HOST
>
> which I think is wrong.

Yeah, this is definitely wrong, should be SOC_IMX8MQ || SOC_IMX6Q ||
SOC_IMX7D || (ARM && COMPILE_TEST)

> Lorenzo, if you update your pci/dwc branch,  I'll rebuild my "next" branch.
>
> If you want to tweak the switch statements and/or IMX8 checks, you
> could do that at the same time.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=next

OK, I'll use the branch above for v3 of the patches.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
