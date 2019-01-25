Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF09C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:38:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E5DF218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MJtUaEbN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nn+reeA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5DF218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FTDQcl2vefyaN5hZcgu7/hijXWAsr1ARTeuREBTAan0=; b=MJtUaEbNcQ2kZK
	EbWaHdjfXHcsCpK7KvEPlc2aWMEQ1aCeN0XRpqW1eRcUCHfdxXMyTxL+PUsQIhV6dzQ5PE/HXBNle
	F/5T+gd7bHk5G87jvdjH3dRClh30oLFnJx0sVeCLQAFy73X9MjRJXB1NY2GZUoGZbPYfmoj9OEBQC
	ToPmN3XBBCDeztDNeO3nXWl23/GzpNMFVp5xFqpHfoKYW6fS2lfhdd9Hc4fwCyy9cCoX8oG355fbt
	WDPF8XYfIL20+OLabEKRC1Ud/CVOz8WY1yp1A1Jc0622arxXUhs9rSaDH7OVeKDvvpsnD/aEqmKq/
	r9iqvzo22svxvdIWilRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmys8-0003wk-Rq; Fri, 25 Jan 2019 10:38:04 +0000
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmys4-0003wN-7c
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:38:01 +0000
Received: by mail-qk1-x743.google.com with SMTP id 68so5087012qke.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 02:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=klEb6fjdDLnRB0knxL2KW1PkKMB1j6jmIlkOzYEg8Ds=;
 b=Nn+reeA1iEmyvbUNE7l7T4l/suF7Z3aOzezbZodhKrELWeqDfc86oy+SEuQiTvaigE
 Wg3bIn1HK6fLbe7+lzyxDy3KF3cU0EWbN/hRp0vNl5QeDJzpUYbliyFSS5gSkuEQvYwi
 +RW1qbue9dP70wGD4QCW4mKHUcRiK/35CYeV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=klEb6fjdDLnRB0knxL2KW1PkKMB1j6jmIlkOzYEg8Ds=;
 b=tr+IfkYIBOzGeIFvafWunoO+5Gp0fMEZS1yZrZRFeBdGJgA/E0puF1Wv5f1kjpLDoN
 WdTQrpZPzflq8pET3uph0C/wBI+9yUO12RvPMiIv4dPXRn9sZydXJF2eQ7z9VX1Qf6oo
 PaTrPcYfFYo3o6I0OcrUiYrPHhXD64HK8MKBZ4vhlokT3NmjcTcNBbjSo0/K5bXE7zOo
 5hh5BGZ6aa9fYRxnjpyyb13N5LT7UUvoCDbEZIEPOQVIWe/ZchkbwE3nFdvGt8KaBMB6
 cWVjWU65SqKTlLZr3AUeRK0QFArVg6SFdfXySfbFssIQ0Iv0aGMXXMvF6MECvMnu1fb1
 uIvQ==
X-Gm-Message-State: AJcUukdXnubK4PIVmlCXJXPe30SNAku4BumbbPSJyPq4JBh5XXWWIh9M
 hsP/MIM/9osivtjGSLNHEFZTPavG38r1cUv7b1g4Tg==
X-Google-Smtp-Source: ALg8bN4CExBMYPoHhulvoc6KO9PpBVUHI7JkcwQfBSmendId0IyIsMSRX9GTJJ0JMc5oazwg0ZBfD42Qmo6tcko06l0=
X-Received: by 2002:a37:b2c2:: with SMTP id b185mr8999350qkf.194.1548412678233; 
 Fri, 25 Jan 2019 02:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20181218215944.2444-1-mike.leach@linaro.org>
 <20181218215944.2444-2-mike.leach@linaro.org>
 <353c8f4b-f48f-863c-7149-342b764a02c0@codeaurora.org>
In-Reply-To: <353c8f4b-f48f-863c-7149-342b764a02c0@codeaurora.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 25 Jan 2019 10:37:45 +0000
Message-ID: <CAJ9a7Vh6McpjtyRuBDPSYMWec0TuWkXeOLBOpKvv8tWUU0sV2A@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/2] drivers: amba: Updates to component
 identification for driver matching.
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_023800_293496_5BBE30BA 
X-CRM114-Status: GOOD (  19.44  )
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
Cc: Rajendra Nayak <rnayak@codeaurora.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Sai
On Fri, 25 Jan 2019 at 07:20, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi Mike,
>
> Thanks for the patch.
>
> BTW somehow I can't find the latest series in my inbox, so commenting
> on this here.
>
> Mathieu pointed me to this patch series.This solves CPU debug module
> sharing same PID as ETM on MSM8996. I will be posting patch for CPU
> debug UCI table soon.
>
> But please find my one comment inline.
>
> On 12/19/2018 3:29 AM, Mike Leach wrote:
> > The CoreSight specification (ARM IHI 0029E), updates the ID register
> > requirements for components on an AMBA bus, to cover both traditional
> > ARM Primecell type devices, and newer CoreSight and other components.
> >
> > The Peripheral ID (PID) / Component ID (CID) pair is extended in certain
> > cases to uniquely identify components. CoreSight components related to
> > a single function can share Peripheral ID values, and must be further
> > identified using a Unique Component Identifier (UCI). e.g. the ETM, CTI,
> > PMU and Debug hardware of the A35 all share the same PID.
> >
>
> [..]
>
> > +static const struct amba_id *
> > +amba_lookup(const struct amba_id *table, struct amba_device *dev)
> > +{
> >       while (table->mask) {
> > -             ret = (dev->periphid & table->mask) == table->id;
> > -             if (ret)
> > -                     break;
> > +             if (((dev->periphid & table->mask) == table->id) &&
> > +                     ((dev->cid != CORESIGHT_CID) ||
> > +                      (amba_cs_uci_id_match(table, dev))))
>
> Shouldn't the check be (dev->cid == CORESIGHT_CID) ?
> Without this STM fails to probe on both SDM845 and MSM8996.
>
I believe the test is correct

To expand the logic here:

if  (dev->periphid & table->mask) == table->id) {
      //** match on peripheral ID at this point
     if (CID != CORESIGHT_ID)
               return table; //** not coresight - match on peripheral ID only
     //** or
     if (amba_cs_uci_id_match() )
                return table;  //** is coresight - match on UCI if
available - otherwise peripheral ID only;

However - looking at the coresight STM driver - this is using the
private .data field in the amba_id for a name - which I had not
spotted before.
I will have to revisit this patchset to fix either the amba id struct
or the method for getting the uci data into the amba_id.data which
allows for multiple uses.

Regards

Mike


> With this,
>
> Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>
> Thanks,
> Sai
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
