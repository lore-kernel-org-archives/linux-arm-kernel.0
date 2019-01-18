Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06D8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:24:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 822B9208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jh54UJHZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kYZfn6ld";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kYZfn6ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822B9208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/YFucM6FaowK2bNVQIh32ZFf4+Ld564GWcSi8Ip/56g=; b=jh54UJHZ6REI+O0FPJL28IjhE
	9MAJ3W5JFs/JKCgbD6SWv1FqbpJ8NS1cIbdBsPAJLHzDn++Iwf6de2i/xTiR7fCqL5Gn2cFvj1je3
	TBjN4SR2pzr+s/sPSURh71CnK1C6gCr2aTKl3yOJ5vrpQbvHnIhpSR/BA9k5BGxxI6K9yNnf+cxpp
	dW7RwMP4F0ICghIjMTyGUbPmGqCebuisfhhJgCvaQ46gtQRp5D5yyvPnGAZUv+gbnBeclpV0CPofu
	Q9BWc6g8rFKHTQs+ecr/32Td/irv+BKwZFM4ZYdKT+lJn3FvszBH2Z73gVzG0XUVjTsg7hlebPkz1
	ST+Lwrx5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkRKN-0004PQ-FE; Fri, 18 Jan 2019 10:24:43 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkRKK-0004Ou-8r
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 10:24:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id B52A760854; Fri, 18 Jan 2019 10:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547807078;
 bh=inbUf2rQzWW+lxUgtiTxzNvPxjd2jbLX8rRSJp03ZEI=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=kYZfn6ldrO9XZ96OOJ1sOK1P5ZIRzbRez2oylv0CPrDsuEoUjQxYMx9NWfZfhZpVs
 jF4NKbPhO0Pw7H+CAI64++mQUiAZOQcwJpDd2VkePsOTSr32QIWHxFIOZuh0qTYRay
 T8u8yySW3x0mu+H8vJMaWJXUNaEltjGrtuhksGIc=
Received: from [10.79.129.0]
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 011D26024C;
 Fri, 18 Jan 2019 10:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547807078;
 bh=inbUf2rQzWW+lxUgtiTxzNvPxjd2jbLX8rRSJp03ZEI=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=kYZfn6ldrO9XZ96OOJ1sOK1P5ZIRzbRez2oylv0CPrDsuEoUjQxYMx9NWfZfhZpVs
 jF4NKbPhO0Pw7H+CAI64++mQUiAZOQcwJpDd2VkePsOTSr32QIWHxFIOZuh0qTYRay
 T8u8yySW3x0mu+H8vJMaWJXUNaEltjGrtuhksGIc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 011D26024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: Need help: how to locate failure from irq_chip subsystem
To: Pintu Agarwal <pintu.ping@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Russell King - ARM Linux <linux@armlinux.org.uk>, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, kernelnewbies@kernelnewbies.org
References: <CAOuPNLj4QzNDt0npZn2LhZTFgDNJ1CsWPw3=wvUuxnGtQW308g@mail.gmail.com>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <bceb32be-d508-c2a4-fa81-ab8b90323d3f@codeaurora.org>
Date: Fri, 18 Jan 2019 15:54:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAOuPNLj4QzNDt0npZn2LhZTFgDNJ1CsWPw3=wvUuxnGtQW308g@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_022440_360094_DFCC5FE7 
X-CRM114-Status: GOOD (  20.72  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Pintu-san,

On 1/18/2019 3:38 PM, Pintu Agarwal wrote:
> Hi All,
> 
> Currently, I am trying to debug a boot up crash on some qualcomm
> snapdragon arm64 board with kernel 4.9.
> I could find the cause of the failure, but I am unable to locate from
> which subsystem/drivers this is getting triggered.
> If you have any ideas or suggestions to locate the issue, please let me know.
> 
> This is the snapshot of crash logs:
> [    6.907065] Unable to handle kernel NULL pointer dereference at
> virtual address 00000000
> [    6.973938] PC is at 0x0
> [    6.976503] LR is at __ipipe_ack_fasteoi_irq+0x28/0x38
> [    7.151078] Process qmp_aop (pid: 24, stack limit = 0xfffffffbedc18000)
> [    7.242668] [<          (null)>]           (null)
> [    7.247416] [<ffffff9469f8d2e0>] __ipipe_dispatch_irq+0x78/0x340
> [    7.253469] [<ffffff9469e81564>] __ipipe_grab_irq+0x5c/0xd0
> [    7.341538] [<ffffff9469e81d68>] gic_handle_irq+0xc0/0x154
> 
> [    6.288581] [PINTU]: __ipipe_ack_fasteoi_irq - called
> [    6.293698] [PINTU]: __ipipe_ack_fasteoi_irq:
> desc->irq_data.chip->irq_hold is NULL
> 
> When I check, I found that the irq_hold implementation is missing in
> one of the irq_chip driver (expected by ipipe), which I am supposed to
> implement.
> 
> But I am unable to locate which irq_chip driver.
> If there are any good techniques to locate this in kernel, please help.
> 

Could you please tell which QCOM SoC this board is based on?

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
