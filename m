Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4F9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:48:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C0562081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T7KDyAnl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="RIEWumvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0562081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TfKrHuaYm+JjHARTp3pjDYeQQtXD/ZwFOwe6EiwSlMY=; b=T7KDyAnlsnVrLw
	mPsq3jgme8yqO508fhRNp6WFOPtCBPW4KYLlcsB9twLzxGNfnKFUN2ZI7HIKZFp4g9hk7fd0t5sNd
	NLsnffq2loj/3mPu1zSVdpXSDtGAyc19VW8PAmM9a3NhUZZ35aRHrn+xLNA7HR7CX0qBrfWHDrSVT
	v5iJnnWWAiuscHvpP5/dc9qWRiX4zNMaa2tWufvbiMw+m5q4eOey9Jsfu2Kp/AdPAA76yC+jbSXsw
	3zq5l5I0TdS2v+sCyQfaujWzhZB9Ifk8ohDdhEttCquyFucMRjSC4ugTEDOoRvif18ih4Igezpsfv
	gz97J2/TQ+8s9DIMcxDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUC07-0001mB-G0; Tue, 04 Dec 2018 14:48:39 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUC03-0001bW-Vu
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:48:37 +0000
Received: from penelope.horms.nl (96-64-203-130-static.hfc.comcastbusiness.net
 [96.64.203.130])
 by kirsty.vergenet.net (Postfix) with ESMTPA id B515B25B7C3;
 Wed,  5 Dec 2018 01:48:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1543934904; bh=9c0VKMlr4G0qlS81aEtR0YhJxfiJsuSOyDVDXo0NivY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RIEWumvwAZ+JJTZR51F0Vel9B+UV1kGQndX0l6Jr85CQh2s2WzeAQaW1XcjVha5BB
 N7cglLcBiKn8Z36+8WhbJbgBpmrZkm/LWI8CsCSLJpXOms4I/uPI8WFJ7WoTkiblqK
 5ISgdIbQh18D+Kb4xm5ehr2ei67xTbZApYFc6kMM=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id BD81FE217E3; Tue,  4 Dec 2018 06:48:22 -0800 (PST)
Date: Tue, 4 Dec 2018 06:48:22 -0800
From: Simon Horman <horms@verge.net.au>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 26/34] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
Message-ID: <20181204144822.uqonsto45u7ysdu5@verge.net.au>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-27-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203213223.16986-27-robh@kernel.org>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_064836_170602_A6B4EC65 
X-CRM114-Status: GOOD (  12.80  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Grant Likely <grant.likely@arm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 03:32:15PM -0600, Rob Herring wrote:
> Convert Renesas SoC bindings to DT schema format using json-schema.
> 
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/shmobile.txt      | 151 ------------
>  .../devicetree/bindings/arm/shmobile.yaml     | 218 ++++++++++++++++++
>  2 files changed, 218 insertions(+), 151 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/shmobile.yaml

Hi Rob,

what is this based on? I get a conflict when applying the .txt change
and if I knew the base for this patch it would be rather easy to work
out what has changed.

Also, should we do an s/shmobile.txt/shmobile.yaml/ in MAINTAINERS?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
