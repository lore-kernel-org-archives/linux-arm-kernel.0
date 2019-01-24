Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CB7C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:49:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F4921726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y1cQuuRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F4921726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vqs+YxN5Arv5NYbPMa1fES3an/wckNb71XHrO+mvTSk=; b=Y1cQuuRno+vBGN
	98pr7b6pyYu9KJ/PXZQTiBJkzU06A+aD6HO/K7TI3SIych/oRGn6bWSkYiBHD5sEz/APTZnjk60ge
	RUcuvsLAmbz9PMBWnypDjtVeGeOvDHy6pnmR+jL83nYtigaJAP4kYs9l7JbiFKKFIxzcUXu/i5epb
	0vMBb53cqtPpQa6MVGsKn96iONGgC9SqJUBjLGJ0TtqT7K+PIdMPavgiE5aEFVadl3wadEFfCZkOr
	oX3u6zl/0CXA4Rrusr2G3vZrAypKpL5eJYoBPVhalyyx1vdUPKA6zDUs4hLX2JBlqiUe4H/kNrSzT
	kQhgvkYHrrMMR+/NZOoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gml0C-00033O-Jz; Thu, 24 Jan 2019 19:49:28 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gml09-00032h-Hm
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 19:49:26 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id CF2048181;
 Thu, 24 Jan 2019 19:49:31 +0000 (UTC)
Date: Thu, 24 Jan 2019 11:49:20 -0800
From: Tony Lindgren <tony@atomide.com>
To: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v3 0/2] Support for eMMC in AM65x-evm
Message-ID: <20190124194920.GU5720@atomide.com>
References: <20190117094424.7683-1-faiz_abbas@ti.com>
 <d75a123b-9e97-a3d1-1e3c-41ef6942dffb@ti.com>
 <20190124124032.aqp4ctqkpozbttwl@kahuna>
 <6b10e04d-47b7-09ed-9d03-d37732569b92@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6b10e04d-47b7-09ed-9d03-d37732569b92@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_114925_626945_B20476EB 
X-CRM114-Status: UNSURE (   6.00  )
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
Cc: Nishanth Menon <nm@ti.com>, mark.rutland@arm.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 Faiz Abbas <faiz_abbas@ti.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [190124 19:46]:
> I am not currently publishing -next branch, but I can start tracking one.

Yes please do as the patches should be sitting in
Linux next for at least two weeks before merging.
And there can be often delays of multiple days with
getting patches merged to armsoc next branch.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
