Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A80C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:49:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1537320657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DdYARvKe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2jc+7lH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1537320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S8uJ43cl1+2ZrF2/GQreFAwhnVEjQxCzgkwOqC+PZw0=; b=DdYARvKerx6hYt
	KAVXMVqAdi0gy7C4j71UlZSBLokCCpHMDtODFre1K+1/Gc2SRyS0pNuJ48lZ2jxTu55ynFRzh4VND
	iMAg6KUVdGur0DHMj+1w0q1FHqAbutO2JxVse3wJBbSsOwFLXniP0GEs46XfyZ2m2cz9OoCbvxMKo
	jIQ6Wz2/Rf2n0ePSbDMzlnXtGxCM/yppgTbcNPvuoXUoVzTDP0hxbv41mLZ+kDsplWbKG0TwVI7vM
	8nsackX5dsOOmgzt36/VUla5pCrOW7jbK1jKPChmMqT8nAxvE3EfvX8xjUGhT2uIKx0tYBEr5McxV
	XcBkZfy1ZD7TX1F2f/dA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjilB-0004kK-Ka; Wed, 16 Jan 2019 10:49:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjil8-0004k2-Cz
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 10:49:23 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 641E320657;
 Wed, 16 Jan 2019 10:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547635761;
 bh=h5Finl60Lp5X7zMSiLqpSBVjQCIX7wjKEljgw8VZ1xQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G2jc+7lHfEtjN8T5408MijRCwes83fdMpzbtAtnDM+DmW4IuXxVnztdgphb7XkKy1
 hlJV9aFTqTVz1kIw9sXpRiC+n45bq92se45Hj8JX4NIx7zySZngDeiR/q58YE+pLq4
 DcW52yGVPZPn+IdHGp/fJr07a6GdrFICdG8HJ9gI=
Date: Wed, 16 Jan 2019 18:48:57 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Subject: Re: [PATCH shawn/for-next v4 1/2] dt-bindings: arm: Add Y Soft IOTA
 Draco, Hydra and Ursa boards
Message-ID: <20190116104856.GK15808@dragon>
References: <1547562139-64730-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547562139-64730-1-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_024922_460754_26029AAC 
X-CRM114-Status: UNSURE (   6.90  )
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
 Andrew Lunn <andrew@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBKYW4gMTUsIDIwMTkgYXQgMDI6MjI6NDRQTSArMDAwMCwgVm9rw6HEjSBNaWNoYWwg
d3JvdGU6Cj4gVGhlc2UgYXJlIGkuTVg2RHVhbExpdGUvU29sbyBiYXNlZCBzaW5nbGUgYm9hcmQg
Y29tcHV0ZXJzIHVzZWQKPiBpbiB2YXJpb3VzIFkgU29mdCBwcm9kdWN0cy4KPiAKPiBDYzogQW5k
cmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhbCBWb2vDocSN
IDxtaWNoYWwudm9rYWNAeXNvZnQuY29tPgoKQXBwbGllZCBib3RoLCB0aGFua3MuCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
