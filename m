Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880C5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:53:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BFC2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kQS77HSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BFC2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sS1JVHCOiASX0kyqqXcmbed3LHP2X1DUp4GC+iA3ozE=; b=kQS77HSMZ/fYMs
	uTdLDJF2U0lEaNau9BRsFdJh+8r2GH4ELSl6Avs53I3E7e2d/vUlofdaGp0dapCtKlhPQaOoFuR5z
	5LVWXy9NagGH+oJf+3fQnkA0iQsh2zzSsAcXYU+UXTKLo473APwKbB0eCYHpb9fQrcikyZ1iLH/yh
	S5E0JMNhaGk3uVCPu10GD0MM7EjOCpDt8i33JnwVj03zSkMl2kCnCIc2oyWshzyyLxPP632oO/i+f
	CrhZCg/Qva7PQFZMuSk11OUdpVFQNf5V1wksvTacsIrlfquTtToTnnVXEyN6BCc7ic3NzcE4Y3ool
	dBrJ1orhOnGFZP9qxBIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWLzx-0002lQ-5C; Mon, 10 Dec 2018 13:53:25 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWLzl-0002bt-NP
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 13:53:23 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBADqrXU014959;
 Mon, 10 Dec 2018 07:52:53 -0600
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBADqr0b016724
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 07:52:53 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 07:52:53 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 07:52:53 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBADqrs3029631;
 Mon, 10 Dec 2018 07:52:53 -0600
Date: Mon, 10 Dec 2018 07:52:33 -0600
From: Nishanth Menon <nm@ti.com>
To: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am654-base-board: Add MMC/SD
 support
Message-ID: <20181210135233.66qbbnmzpz3mwuwu@kahuna>
References: <20181207084233.13700-1-faiz_abbas@ti.com>
 <20181207084233.13700-3-faiz_abbas@ti.com>
 <20181208155427.jmidz4vsw4k4qj36@akan>
 <c1dd9783-84dc-9dad-ea94-9a14a4ad814d@ti.com>
 <20181210120647.i3ply3p7umvedb3u@akan>
 <66f9d53b-abec-0a28-8eae-ecb99b075db4@ti.com>
 <a73337c2-977c-c9a8-141e-cf91a4591cbc@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a73337c2-977c-c9a8-141e-cf91a4591cbc@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_055314_006488_596BF7AE 
X-CRM114-Status: GOOD (  12.49  )
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
 Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, kishon@ti.com,
 t-kristo@ti.com, robh+dt@kernel.org, adrian.hunter@intel.com,
 michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 19:03-20181210, Faiz Abbas wrote:
> > I think you can rely on the author to tell you when something is> actually ready to be merged (and you can tell him/her to remind you).
> 
> Yes. I will ping Nishanth once the bindings are in next.

In addition, when you are ready, please also check if the patches
need rebase on top of Tero's next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/kristo/linux.git/log/?h=4.20-rc1-am65x-queue

-- 
Regards,
Nishanth Menon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
