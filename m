Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1929FC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:14:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD6F21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X2YAOpW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD6F21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IY8n6pcIA4pBcHfAbW8mRqB6EbYsII9VhqzLDwwS4Pc=; b=X2YAOpW1Nofek8
	l3G6VTuwjaxytQcCr+B6urrIAjIHACMGKV8XAxJpZ9mjPT3aXzSnUFFQk7DcYpmJ7Ly/1bOs0Hqyk
	dts9QW+J67duCIjQn94NkAGHAXv/YHT+hG+4za3E973JURYR4g9sH0MovFSNF6p6uvFa6nEEHc6TW
	aQtWqkW8Yd4d3L4AFcv2AYi75ZC6uS42D4p8dX7lNxyDLW40WJZRpO4cQrsQdE8p/NQu0XaNW9ljs
	xyhSy7ENWV2n8KjVy5TQGPANswGmQR/SvuN3tE46ByFi/h9KyyzHV5h7h7TLnpHYZIl06NLKtRetC
	Mai/PiAq45Onxp5F5ong==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpXig-0001fn-BJ; Fri, 01 Feb 2019 12:14:54 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpXid-0001fU-A9
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 12:14:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C522980D;
 Fri,  1 Feb 2019 04:14:50 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47E523F59C;
 Fri,  1 Feb 2019 04:14:48 -0800 (PST)
Date: Fri, 1 Feb 2019 12:14:45 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jolly Shah <JOLLYS@xilinx.com>
Subject: Re: [PATCH v6 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
Message-ID: <20190201121445.GD10042@e107155-lin>
References: <1548794301-30483-1-git-send-email-jollys@xilinx.com>
 <1548794301-30483-4-git-send-email-jollys@xilinx.com>
 <20190130101236.GA27201@e107155-lin>
 <BYAPR02MB59926CC0829613B4B52A7D3EB8910@BYAPR02MB5992.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR02MB59926CC0829613B4B52A7D3EB8910@BYAPR02MB5992.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_041451_355838_C189FFBD 
X-CRM114-Status: GOOD (  12.94  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "andy.gross@linaro.org" <andy.gross@linaro.org>,
 Rajan Vaja <RAJANV@xilinx.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Michal Simek <michals@xilinx.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 07:01:05PM +0000, Jolly Shah wrote:
> >
> > NACK, if this is for system suspend/reset ? You can just use exiting
> > sysfs, no need to create Xilinx specific new ones. Moreover you need to
> > use PSCI to make sure higher ELs can do orderly suspend/shutdown.
> >
>
> We have power off suspend mode which is not supported by existing sysfs and
> hence new one is needed. Suspend is handled through PSCI interface only.
>

I see only 2 cases supported SUSPEND_SYSTEM_SHUTDOWN and
SUSPEND_POWER_REQUEST. Both are already support so my NACK still stands.

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
