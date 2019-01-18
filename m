Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5318C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:48:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E6820883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i4LkIkte";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6MnRUdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E6820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sn+1DLjdovqI1y7HwIdwZ2hpzwXQ3zk0VH1A9A103sc=; b=i4LkIkteanXwfk
	5oBmFZ+4Rpk0qwzfUJ3xGMgzgufdY3GB+RdKUPk0cZP72TY/S+dS579qsj2hXctyECakAbhYUz2j7
	x3UQdyvVjQ0y2GEUw1LH5S39xDey+csnNt4wdjOz0st8SA71pEcMfcalnRgPV87Aghi562TK00SEY
	tQ3lu+14TEZ2e6dRqWf3iRbpvskvdONKSfZrnlvZDpHa3/ZjwAC+C0TCqOaIit1mtswlGXqJvR7hN
	KI5lh1r8ABM+fM1j6c3z6kYVxOi6qWsxAEpdGXHHCzWfgWpUiV0GbFm1sJW9a4rH4Z7MBIKhgMP2O
	iIAIugtxXHj3GVA9Oagg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkRhg-00045J-Ek; Fri, 18 Jan 2019 10:48:48 +0000
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkRhd-00044o-0R
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 10:48:46 +0000
Received: by mail-vs1-xe41.google.com with SMTP id u11so8120115vsp.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 02:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/6xliivq0weCXLfwCUUU2y3nNNwTp933/QmOo/bU0eY=;
 b=C6MnRUdvpvjVi5Kc8Lceq9DKjFe5J546YEJCUr3Sbn1TcFwfxAzTWbjASQrCNA6aGh
 Nu/6WGPZxYRxA/SP6he88jxtClUyBRL+kl2le9yc41CozxPqdcpzZtFWFFtmSk9q/IrS
 HHahJkKxV2iH2vPXAwYh3qMunjbO0J2LEhLf8NG3QzP8ns6wtmr5u32u7kKLP3eWButc
 TZ8XelSo1gGw4j3PnEwKa80b1ml+h4JXNIkIuun5HIV0fRllQsNUfe7GN9YlNKAObGGo
 kM32yguM1ceiCrAWAVr68YUwEHv2cai2UhJ0xo8+YTnRF8yU+9/mncUtqtLonPnGQH8M
 kfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/6xliivq0weCXLfwCUUU2y3nNNwTp933/QmOo/bU0eY=;
 b=FwYtPaM6siamngHAS2O3rSeWxBqq2o6Cg3rOSpOLUTvQQclz9Ntgyu5OfzOwS5Ok6A
 qUCmpZ2xVD+HepoIekNaU23eNk1q4l93oaWdI76Fg2QKN476dhTMt55U3Ed/ADdATcR4
 qBDEj8UMOyq5ySImFjzJvnQczujWrJD/elMQXOl8dh53qEqHbiac1lhpVIuN310VURKe
 h3fBuDs1sdP2OSjoGjzPRDGJZK//qG1CeVnIEWcPZrB0LrDcDGkXGgTVIFSqZ2Cj8qqf
 jB0L2u/P+JAdb9OarBWCEXFcXoH/sesxexzavvibG4ZcJA7X1WziAzmd8vOgIL2xg5d9
 pdaw==
X-Gm-Message-State: AJcUukcfNX/Kv0dgNFud6Xu/ok7tVH8vorC0RC1c7e0T4lZUo6FJR0jN
 sXcRxYW6Kena4XDPydWldMwv44Kfgh2JeCRMwiSlv/koutThxg==
X-Google-Smtp-Source: ALg8bN7HsppUgj5spIWajytKcejIfmTNluhxxl0gRonQb5lcTa162V7q5iApGv92T5XidVHBMY1/wVNcnfaji/TcPRo=
X-Received: by 2002:a67:f793:: with SMTP id j19mr6934457vso.196.1547808523523; 
 Fri, 18 Jan 2019 02:48:43 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLj4QzNDt0npZn2LhZTFgDNJ1CsWPw3=wvUuxnGtQW308g@mail.gmail.com>
 <bceb32be-d508-c2a4-fa81-ab8b90323d3f@codeaurora.org>
In-Reply-To: <bceb32be-d508-c2a4-fa81-ab8b90323d3f@codeaurora.org>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Fri, 18 Jan 2019 16:18:32 +0530
Message-ID: <CAOuPNLiNtPFksCuZF_vL6+YuLG0i0umzQhMCyEN69h9tySn2Vw@mail.gmail.com>
Subject: Re: Need help: how to locate failure from irq_chip subsystem
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_024845_095024_39DF8706 
X-CRM114-Status: GOOD (  20.95  )
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
Cc: linux-pm@vger.kernel.org, kernelnewbies@kernelnewbies.org,
 open list <linux-kernel@vger.kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 3:54 PM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi Pintu-san,
>
> On 1/18/2019 3:38 PM, Pintu Agarwal wrote:
> > Hi All,
> >
> > Currently, I am trying to debug a boot up crash on some qualcomm
> > snapdragon arm64 board with kernel 4.9.
> > I could find the cause of the failure, but I am unable to locate from
> > which subsystem/drivers this is getting triggered.
> > If you have any ideas or suggestions to locate the issue, please let me know.
> >
> > This is the snapshot of crash logs:
> > [    6.907065] Unable to handle kernel NULL pointer dereference at
> > virtual address 00000000
> > [    6.973938] PC is at 0x0
> > [    6.976503] LR is at __ipipe_ack_fasteoi_irq+0x28/0x38
> > [    7.151078] Process qmp_aop (pid: 24, stack limit = 0xfffffffbedc18000)
> > [    7.242668] [<          (null)>]           (null)
> > [    7.247416] [<ffffff9469f8d2e0>] __ipipe_dispatch_irq+0x78/0x340
> > [    7.253469] [<ffffff9469e81564>] __ipipe_grab_irq+0x5c/0xd0
> > [    7.341538] [<ffffff9469e81d68>] gic_handle_irq+0xc0/0x154
> >
> > [    6.288581] [PINTU]: __ipipe_ack_fasteoi_irq - called
> > [    6.293698] [PINTU]: __ipipe_ack_fasteoi_irq:
> > desc->irq_data.chip->irq_hold is NULL
> >
> > When I check, I found that the irq_hold implementation is missing in
> > one of the irq_chip driver (expected by ipipe), which I am supposed to
> > implement.
> >
> > But I am unable to locate which irq_chip driver.
> > If there are any good techniques to locate this in kernel, please help.
> >
>
> Could you please tell which QCOM SoC this board is based on?
>

Snapdragon 845 with kernel 4.9.x
I want to know from which subsystem it is triggered:drivers/soc/qcom/

>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
