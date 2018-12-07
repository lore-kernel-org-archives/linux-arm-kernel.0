Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98F1C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:27:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B823F20837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h2V3TZAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B823F20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2W6ijt1vDjRN9YYonHZP3vMdmavHOw86VrHeAL8mGxw=; b=h2V3TZAF6K0mrA
	YOZLZAemJJxaUi+VvUGDlzxNbxtkxYJxSGkOqtVM0Ch++i5zfa7u0+iPlnsLvP195ubqosCojRXAt
	fVGwX9Z7zdtP+3AiZOnVUweLIpkKE4VdLRzHa52ojsGb5F2a7goVAjSEyzymtKxbzTkVX69F1CdSa
	nSivxFCETe2hqT/H3Skp3LtHbVZ/iVTpKj/yRs3uXzEWHsFWRxDkO7DA8k3Oe0Iq30BxdtkskLp1h
	YKtFibumF57NyFT6ewi8c6yA8ScXPLmjiDeykCNJ/hoM8L/gyFzCbr9OzHGeA45bVynJDgNgdX8rx
	xBMo9qhBmwwn3UIMX6xw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVIyp-0004uv-9w; Fri, 07 Dec 2018 16:27:55 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVIym-0004u1-AD
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 16:27:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08DED15AB;
 Fri,  7 Dec 2018 08:27:40 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9921C3F575;
 Fri,  7 Dec 2018 08:27:35 -0800 (PST)
Date: Fri, 7 Dec 2018 16:27:34 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v11 8/8] interconnect: sdm845: Fix build failure after
 cmd_db API change
Message-ID: <20181207162733.pdd62qvqzd6xk4nr@queper01-lin>
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
 <20181207152917.4862-9-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207152917.4862-9-georgi.djakov@linaro.org>
User-Agent: NeoMutt/20171215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_082752_357063_347A4E1D 
X-CRM114-Status: UNSURE (   9.41  )
X-CRM114-Notice: Please train this message.
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
Cc: mark.rutland@arm.com, sanjayc@nvidia.com, maxime.ripard@bootlin.com,
 mturquette@baylibre.com, daidavid1@codeaurora.org, bjorn.andersson@linaro.org,
 skannan@codeaurora.org, abailon@baylibre.com, lorenzo.pieralisi@arm.com,
 vincent.guittot@linaro.org, seansw@qti.qualcomm.com, khilman@baylibre.com,
 evgreen@chromium.org, ksitaraman@nvidia.com, devicetree@vger.kernel.org,
 arnd@arndb.de, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 robh+dt@kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
 rjw@rjwysocki.net, dianders@chromium.org, amit.kucheria@linaro.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Georgi,

On Friday 07 Dec 2018 at 17:29:17 (+0200), Georgi Djakov wrote:
> Recently the cmd_db_read_aux_data() function was changed to avoid using
> memcpy and return a pointer instead. Update the code to the new API and
> fix the build failure.
> 
> Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/qcom/sdm845.c | 26 ++++++++++++++------------

IIUC this file is introduced by patch 5. Should the fix be squashed
into patch 5 directly ? Just to keep things bisectable.

Thanks,
Quentin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
