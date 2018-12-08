Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CA3C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 02:23:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9BB2083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 02:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ev/AL3bJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="flvIeInL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9BB2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7Zuw+oScnFYCmZO1/eLCIaUNzOvvi+hHJtIK96QMlvw=; b=Ev/AL3bJUrSBgC
	t6fHUmQSjRB52ELVLebaj5304hnIJL3VV3OctkYsFEAParMq9d2Y/nV2XxNO6ZTXYhDlyfwklS3xa
	O1YVSAz3r4vuXI1aiv8v2iD3VVb7tbKG0m2BQgQqMySGle6Km1YdwjGBWYtOjTiR99coV0dBfRXXQ
	KlE1GwBWzNJSHXbyFYY6W5t80MIXaTU7Fvvam9nwV/P6XYaiTJ8ElW6uvVW82qNJllzC7NwMJ0dpP
	NOodSe1GJiOCCJ0t5/6ZwjSrQqwzMQDJz9IezQM07JquRrHlDb3vXrx8PHE38YPxbwz0a2KS+ife+
	B2W2AQkeSx0H5UH2I0QQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVSHW-0006bb-2p; Sat, 08 Dec 2018 02:23:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVSHT-0006bH-C7
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 02:23:48 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 56DFB2083D;
 Sat,  8 Dec 2018 02:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544235816;
 bh=YsWMQXUlJUkhaFqiLnia17Llmhi2TgXjYRC7qGY9VmM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=flvIeInLx0E56dCVtxvo7EjZHvtpcOnjFwArnfQAjU1mRzufy6gEqto0SGMvvY1eT
 P39pFL25rEsFOpk3zljgnpc0er2F22P8lMGkl94kE0ou9c9G2JEmY9VlJ9wYgORfA5
 yhFlCdPAZ82hX8dBJ2g6x7MoS9vqn+KsDb2NoruU=
Date: Sat, 8 Dec 2018 10:22:53 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Pramod Kumar <pramod.kumar_1@nxp.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: ls1012a: Add FRWY-LS1012A device tree
 binding
Message-ID: <20181208022252.GO3987@dragon>
References: <20181026084554.32290-1-pramod.kumar_1@nxp.com>
 <20181031064809.GF10386@tiger>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181031064809.GF10386@tiger>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_182347_430768_D0992095 
X-CRM114-Status: UNSURE (   9.86  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Leo Li <leoyang.li@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Oct 31, 2018 at 02:48:12PM +0800, Shawn Guo wrote:
> On Fri, Oct 26, 2018 at 08:45:26AM +0000, Pramod Kumar wrote:
> > LS1012A-FRWY is an ls1012a based SoC board
> > Add device tree binding for LS1012A-FRWY board
> > 
> > Signed-off-by: Pramod Kumar <pramod.kumar_1@nxp.com>
> 
> It should really be sent together with "arm64: dts: ls1012a: Add
> FRWY-LS1012A board support" as a patch series.
> 
> Applied, thanks.

I dropped this patch from my 4.21 queue for now, as Rob is moving the
bindings to json-schema during this development cycle.  I will add the
compatible back using json-schema format after 4.21-rc1 is available.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
