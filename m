Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF01C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:23:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC98218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mFKgz14o";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jq/Tws8l";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WxMmqbTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC98218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wN3uZxEb8OrUGbesRxbLwdcC6OApOYpMpiyoVuvHMEM=; b=mFKgz14owfjuiEXOI1PWpdTM2
	IJYiNubZCzxRBIe9mZirbU6KkJARrr5wE7n+pfHaTKDwGAyI01YqQcpDD8XBBiakJPt/vNVVSnamh
	DJbV2/M2ZDbSnmEUIwR89gfecFvF0b241002Dy3SX5LNDpEvUBOke2/0qvcGJZx2rEQwmpooRKTAy
	OXuQjebkpemUEvfW5n31fdh+JMq1G/hn1zKAOgKvINYGVa23MM/WAbG991wSXd6FBBVnnoT+uASXH
	z1Do+SYRZkZ/7im7KZoSsUyUDJBA0Tc50EK7VihrSjDhRaeC2putwUKZpMkQVlXvdjsRBjonwD30w
	pTujkYnnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpARK-0000pc-1e; Thu, 31 Jan 2019 11:23:26 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpARG-0000pH-Fr
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 11:23:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id EB1DC6030D; Thu, 31 Jan 2019 11:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548933801;
 bh=27sPpMVytBxo/dSpOXz7XscvzaW7yqjIC6rPP2BIWAs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Jq/Tws8lqtc1USiumadYHdgMNtHCfOdhnQmbP1kXgBuRgaAS6p/gTXZ9uh9hoXTds
 oxnTrQ6hYq5sIuH53R8Gqb2WfdLkCirjHJrPYmHpTByp008keOKk7wUzfeYYn12Yfv
 i4/Iy2vLKcWq/4ajc6Pc8PU7IDTDDpxs3j8OASl0=
Received: from [192.168.43.47] (unknown [27.59.108.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 1450C6030D;
 Thu, 31 Jan 2019 11:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548933798;
 bh=27sPpMVytBxo/dSpOXz7XscvzaW7yqjIC6rPP2BIWAs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=WxMmqbTqwwZ2bVm9hamfxDFoTuJEOODyqSupT1JMxqtC4JEmp1LXDO31Yme75yNax
 cF+9Ey0vJYVilUKqOSee+3A4zvWfxogmIZFzYpKDyaNQqWEqmcYm1PFcUobyzbPWvx
 8GFcGmMi9hc9kCzU7+QXexrjrh+FbKNIsgfmhkGw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1450C6030D
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH v4 1/3] drivers: amba: Updates to component identification
 for driver matching.
To: Mike Leach <mike.leach@linaro.org>, linux-arm-kernel@lists.infradead.org, 
 coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20190130234051.2294-1-mike.leach@linaro.org>
 <20190130234051.2294-2-mike.leach@linaro.org>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <dc23a09c-7814-8fa1-ed07-7afe9eb3e7ed@codeaurora.org>
Date: Thu, 31 Jan 2019 16:53:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130234051.2294-2-mike.leach@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_032322_564940_6084634A 
X-CRM114-Status: GOOD (  16.17  )
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
Cc: arm@kernel.org, linux@armlinux.org.uk, mathieu.poirier@linaro.org,
 suzuki.poulose@arm.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/31/2019 5:10 AM, Mike Leach wrote:
> The CoreSight specification (ARM IHI 0029E), updates the ID register
> requirements for components on an AMBA bus, to cover both traditional
> ARM Primecell type devices, and newer CoreSight and other components.
> 
> The Peripheral ID (PID) / Component ID (CID) pair is extended in certain
> cases to uniquely identify components. CoreSight components related to
> a single function can share Peripheral ID values, and must be further
> identified using a Unique Component Identifier (UCI). e.g. the ETM, CTI,
> PMU and Debug hardware of the A35 all share the same PID.
> 
> Bits 15:12 of the CID are defined to be the device class.
> Class 0xF remains for PrimeCell and legacy components.
> Class 0x9 defines the component as CoreSight (CORESIGHT_CID above)
> Class 0x0, 0x1, 0xB, 0xE define components that do not have driver support
> at present.
> Class 0x2-0x8,0xA and 0xD-0xD are presently reserved.
> 
> The specification futher defines which classes of device use the standard
> CID/PID pair, and when additional ID registers are required.
> 
> This patch introduces the amba_cs_uci_id structure which will be used in
> all coresight drivers for indentification via the private data pointer in
> the amba_id structure.
> 
> Existing drivers that currently use the amba_id->data pointer for private
> data are updated to use the amba_cs_uci_id->data pointer. Macros and
> inline functions are added to simplify this code.
> 

Thanks Mike, this fixes STM probe with UCI change.

Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
