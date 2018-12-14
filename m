Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFB0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:18:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4119E204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jz89OKsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4119E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7nvzYJcRS9kvxhHRqlMPm1nLJkxGha4+gYxKAOx6+bo=; b=Jz89OKsfiD1EhfE8Op8nTCKMZ
	WvyodwAsIaI1gDWPDpWRIN5JqubplfbnwvTFKGr6geF9c+oZ7eIV+FsfiHwFVJlQrQzjlLxtm8QqS
	AmjfYE1QVfRJrHuFibb37l0rySoZPINj9XGzYXPMLzSKMNw1QYRbY71U+ctXzn2J/RWH3CS+JPIsB
	UmXByFR4rhEEw4w4yjv2kqIAiRi8rVNy/I9mcp/fjm7JXlJzO/qkoZ6g03LUcjUtyOE0EZNvAyxvd
	il53XT0u1K3qUUiQWFXquuOTxTw8k9xqi2AfcCUSOXQE6LrtfcoPfQgRxeV7pWz3iOB7Y3NsSHWrr
	ttl2zJKug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXsyX-0006Xn-GS; Fri, 14 Dec 2018 19:18:17 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXsyU-0006X1-HU
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 19:18:15 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Dec 2018 11:18:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,354,1539673200"; d="scan'208";a="110454612"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.147])
 ([10.7.153.147])
 by orsmga003.jf.intel.com with ESMTP; 14 Dec 2018 11:18:03 -0800
Subject: Re: [PATCH 1/4] ARM: dts: aspeed: Add sensors devices for Facebook
To: Vijay Khemka <vijaykhemka@fb.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>
References: <20181213195319.1333402-1-vijaykhemka@fb.com>
 <CACPK8XfAXDHqWcD=OKm4UhCh-+-7GBxL02Fi9_jgdmo2ZQZSjg@mail.gmail.com>
 <B6C3C92D-1F9E-4425-ABF5-718D1A6755EB@fb.com>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <c1e35845-cb07-048f-bcf7-d7239a387027@linux.intel.com>
Date: Fri, 14 Dec 2018 11:18:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <B6C3C92D-1F9E-4425-ABF5-718D1A6755EB@fb.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_111814_594495_65727020 
X-CRM114-Status: GOOD (  16.52  )
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
 devicetree <devicetree@vger.kernel.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "james.feist@linux.intel.com" <james.feist@linux.intel.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Vijay,

On 12/14/2018 10:11 AM, Vijay Khemka wrote:
> On 12/13/18, 2:56 PM, "Joel Stanley" <joel@jms.id.au> wrote:

<snip>

>      > +               oemname0 = "MB_P3V3";
>      > +               oemname1 = "MB_P5V";
>      > +               oemname2 = "MB_P12V";
>      > +               oemname3 = "MB_P1V05";
>      > +               oemname4 = "MB_PVNN_PCH_STBY";
>      > +               oemname5 = "MB_P3V3_STBY";
>      > +               oemname6 = "MB_P5V_STBY";
>      
>      "oemname" isn't part of the upstream bindings. Is this something you
>      have patches for?
> This is a workaround field used by dbus-sensors application to avoid overlay for dynamic detection of devices based on json file definition.
> 
> Can you please also review other 3 patches in this series.
>      
> 

These oemname settings should not be added into here. You can add these
information into configuration of entity manager which uses overlay
templates for dbus-sensors. Also, as Joel said, "oemname" isn't part of
the upstream bindings.

Cheers,
Jae

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
