Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83E7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:44:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4A620879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PFemJHiC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFw8CK5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4A620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s0kGzzJ4w+IgXTZrFTyoED33ADsIpjryi9e4sA1KW90=; b=PFemJHiCml/2TJ
	/yL1RQ5pH1Sp4Vg6G7JypTSuXLoOZIrpBteeztHrsPYeIw2seHBK4XQCbFDqvLF9dxCX7HiUsea0G
	Nj3lnZDKuzWjT0dJWKJhEekaGx0LNkWO+757a+y3yJdfLVhtMJ7ozkpXIm+8LiDSIdAIU/4M2h6Sw
	NMwNopxznc0VJj+Sv/a2JrWHJTC3F9Aj+fzSFVLSuoN8a0OW4KaYO7pBrnSmzVb657IIBqh6Emk4h
	RFfeyEWqc7f1kx4Ii0jSdTJgSz5YEGbIExSgpV5NEScHmCdSdi/VXAQe0wZFRjEOg+Qb0y4UOSZrG
	1CgYrt8lv29y4KO0vvxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghadB-0001H0-R9; Thu, 10 Jan 2019 13:44:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghad8-0001Gf-My
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 13:44:20 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C17EC20879;
 Thu, 10 Jan 2019 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547127858;
 bh=OolbA9aGphu2cjQZEXQLcUdpYRZzKQHPy0SRTPOcFJA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UFw8CK5KSL8a0kDnIMAxgneW/G9iDqkWN/YdMUMpoJ5C0ZR5pjPAfczXN6gubumLX
 Os4OSgZTeei45D2gG4T8a6Y6TRDomlgKBCwYPFWLPEnxGoG4ZnhSODjScJOaIvoQlD
 xan72CEzwJ3b7P3rEHdvEH2luIMlMQS3j/o5TT+c=
Date: Thu, 10 Jan 2019 21:44:04 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Subject: Re: [PATCH v2 18/34] dt-bindings: arm: Convert FSL board/soc
 bindings to json-schema
Message-ID: <20190110134402.GB30487@dragon>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-19-robh@kernel.org>
 <20181206023140.GZ3987@dragon>
 <CAL_JsqK5nBdk-MiuTPMxr9oXqXnLqeMU3vtZi6AnT9V35_W55A@mail.gmail.com>
 <20181208015835.GM3987@dragon> <20190110064256.GA25218@dragon>
 <dc0ef959-78a0-2a32-c0f9-e8da11e035e6@ysoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dc0ef959-78a0-2a32-c0f9-e8da11e035e6@ysoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_054418_766728_CBD350B5 
X-CRM114-Status: UNSURE (   8.11  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <grant.likely@arm.com>,
 Sean Hudson <darknighte@darknighte.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 ARM-SoC Maintainers <arm@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBKYW4gMTAsIDIwMTkgYXQgMTA6NDQ6MDNBTSArMDAwMCwgVm9rw6HEjSBNaWNoYWwg
d3JvdGU6Ci4uLgo+ID4gV2hhdCBoYXBwZW5lZCB0byB0aGlzPyAgSXQgc2VlbXMgdGhlIHBhdGNo
IGRpZCBub3QgaGl0IHY1LjAtcmMxLgo+IAo+IEhpIFNoYXduLAo+IFJvYiBhY3R1YWxseSBhc2tl
ZCB5b3UgYSBzaW1pbGFyIHF1ZXN0aW9uIHR3byBkYXlzIGFnby4uCj4gCj4gaHR0cHM6Ly9sa21s
Lm9yZy9sa21sLzIwMTkvMS84Lzc1NAoKT29wcywgaXQgc2VlbXMgdGhlcmUgd2VyZSBzb21lIG1p
c2NvbW11bmljYXRpb24gYmV0d2VlbiBSb2IgYW5kIG1lLiAgTGV0Cm1lIGZpeCB0aGlzIGJ5IHF1
ZXVpbmcgdGhpcyBwYXRjaCBvbiBteSB0cmVlIG5vdy4KClNoYXduCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
