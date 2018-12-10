Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C96C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:50:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281812086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ga3VGMrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281812086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6m8Ls0DK9v5Jb8t8Sg6gpi0SmW1SqeUzWANIsIU4Ju0=; b=Ga3VGMrrVmAAms
	WA2PpeiBFuh2uA1/3zqj1voyIerVhl/K/IvdobsUyX6G2FF9VrUvzUDsAFHXppJpZQJj+lrLebdoK
	8zSRvhHvhK9WsIfX1y4nzkav0LRrQQigYRuwTTRxKKnc3IEAUds7Z3lA+uMJ66oUuwTCxuSfilpad
	el10wVX1Pl4kvdQpsw6tApkGdTygjs9Hn+3EwLsF1NDKr0fgSrUAecG4EuIGPBzgI2EjRNbktVnw/
	NBDfE+U+65n6XGfZA1aH27FgXEbB0XY9Mwym7vjeby5SeZMr6307jnNHJO9l4hqRqKN0KWoulX2gr
	Z7Td2X3Xhkp6wH1VaRZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWLx0-0001O5-Pv; Mon, 10 Dec 2018 13:50:22 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWLwx-0001IE-7b
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 13:50:20 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBADnwOx014245;
 Mon, 10 Dec 2018 07:49:58 -0600
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBADnw5S074360
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 07:49:58 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 07:49:58 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 07:49:58 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBADnwdo024647;
 Mon, 10 Dec 2018 07:49:58 -0600
Date: Mon, 10 Dec 2018 07:49:38 -0600
From: Nishanth Menon <nm@ti.com>
To: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am654-base-board: Add MMC/SD
 support
Message-ID: <20181210134938.hh4543yig6fngyrj@kahuna>
References: <20181207084233.13700-1-faiz_abbas@ti.com>
 <20181207084233.13700-3-faiz_abbas@ti.com>
 <20181208155427.jmidz4vsw4k4qj36@akan>
 <c1dd9783-84dc-9dad-ea94-9a14a4ad814d@ti.com>
 <20181210120647.i3ply3p7umvedb3u@akan>
 <66f9d53b-abec-0a28-8eae-ecb99b075db4@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <66f9d53b-abec-0a28-8eae-ecb99b075db4@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_055019_312865_F6E85C1B 
X-CRM114-Status: GOOD (  14.49  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org,
 Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, kishon@ti.com,
 t-kristo@ti.com, Faiz Abbas <faiz_abbas@ti.com>, adrian.hunter@intel.com,
 michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18:10-20181210, Sekhar Nori wrote:
> 
> I think you can rely on the author to tell you when something is
> actually ready to be merged (and you can tell him/her to remind you).
> 
> For the review itself, doing it by having a look at the dependencies
> mentioned in the cover letter (like available for this series) should be
> good enough (I feel).

Dependencies can be for multiple things.. anyways, Sigh..

> I am not sure if there is a need to post an "RFC version", and then
> follow it up with an actual "PATCH version" once dependencies are
> cleared though.
Heads up for the maintainers will be useful. For example:

Will be good to state in cover-letter instead of just stating
https://patchwork.kernel.org/cover/10717641/

State:

Bindings are in discussion[2], will confirm if approved and will
check if rebase is necessary.

This will indicate to the maintainer that patches are preliminary and
subject to change depending on bindings discussion and developer has
taken ownership of maintaining patch sanity.

-- 
Regards,
Nishanth Menon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
