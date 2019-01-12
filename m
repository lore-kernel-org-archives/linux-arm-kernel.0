Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E168C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 07:05:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5604A20835
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 07:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jmMav4WI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+YWv36x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5604A20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jSe1U7G0P6UncPb+6JgoSygbaVtH574OlztUjIooinA=; b=jmMav4WIzABDgt
	3UBx/iQtYC+SweT2QPcTweUDXXxm2fYUFZWNIcLS3nNsWJoF9NoNEjiN2lXUG83ATDIeYQ8oYW6uH
	WTmZWXH00TTaSxU9hvOKtceORk58ShjYOidxRTQ8YLEVBU8Y3xx8EHMHwA3QyhGEfLcbmJhsJeTGm
	5I7L9AY8NAM5j0HOZi0CSw/8vTSswXPO+NQ4vQOkzjNkLPrJ6MdtVy//sAumWlzvlXMCZyfR29W58
	9LInshFBM2FFoJ9Jg0TpsaiBxGSsHJsY/jl7FMVsgto1M7PkyrJSvJ4ZI9kDXK3pHPctF3q/1ZtZX
	03xwtXjqEXPH9CnulJqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giDLw-0000yo-FC; Sat, 12 Jan 2019 07:05:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giDLs-00008f-5P
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 07:05:06 +0000
Received: from dragon (li1566-229.members.linode.com [139.162.86.229])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ACCAE20835;
 Sat, 12 Jan 2019 07:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547276701;
 bh=79SsgUVQx6d1RYQ1k40FU4v/w94/GoM6ijUpTJg8OsA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W+YWv36xyhIbCWIvytMFW2lgfe+W+kvveJ+5RKBxNsYhsEd/HDNLxYXCYKGQnChxH
 TABO8wB5uqFPJi4cKcusjCS1aWl7HAz8mjsUEA69wy2HSgzf0Epa5AVK33OHDHTeSX
 2zkI8aB8BKPyTRmZUHI1OMshZXS9LsDGsfEUhffg=
Date: Sat, 12 Jan 2019 15:04:33 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH 2/6] ARM i.MX21: Add devicetree support
Message-ID: <20190112070430.GB11426@dragon>
References: <20181222105200.18502-1-shc_work@mail.ru>
 <20181222105200.18502-2-shc_work@mail.ru>
 <20190112025302.GQ32649@dragon>
 <1547270224.382322259@f75.i.mail.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547270224.382322259@f75.i.mail.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_230504_227050_7A7F605A 
X-CRM114-Status: GOOD (  11.41  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
 Russell King <linux@armlinux.org.uk>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gU2F0LCBKYW4gMTIsIDIwMTkgYXQgMDg6MTc6MDRBTSArMDMwMCwgQWxleGFuZGVyIFNoaXlh
biB3cm90ZToKPiBIZWxsby4KPiAKPiA+0KHRg9Cx0LHQvtGC0LAsIDEyINGP0L3QstCw0YDRjyAy
MDE5LCA1OjUzICswMzowMCDQvtGCIFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz46Cj4g
Pgo+ID5PbiBTYXQsIERlYyAyMiwgMjAxOCBhdCAwMTo1MTo1NlBNICswMzAwLCBBbGV4YW5kZXIg
U2hpeWFuIHdyb3RlOgo+ID4+IFRoaXMgcGF0Y2ggYWRkcyBiYXNpYyBkZXZpY2V0cmVlIHN1cHBv
cnQgZm9yIGkuTVgyMSBiYXNlZCBTb0NzLgo+ID4+IAo+ID4+IFNpZ25lZC1vZmYtYnk6IEFsZXhh
bmRlciBTaGl5YW4gPCBzaGNfd29ya0BtYWlsLnJ1ID4KPiA+V2hhdCBpLk1YMjEgYm9hcmQgYXJl
IHlvdSBydW5uaW5nIGRldmljZXRyZWUgc3VwcG9ydCBvbj8KPiAKPiBJIGRvbid0IGhhdmUgYW55
IGhhcmR3YXJlIGZvciBvLk1YMjEgU29DLgo+IEhhdmUgYW55IGNvbW1lbnRzIG9yIHNvbWV0aGlu
ZyB3cm9uZz8KCklmIHRoZXJlIGlzIG5vIHJlYWwgdXNlcnMgZm9yIHRoZSBoYXJkd2FyZSwgSSB3
b3VsZCBsZWF2ZSBpdCBhcyBpdCBpcwphbmQgcmF0aGVyIG5vdCBhZGQgbmV3IGNvZGUgZm9yIGl0
LgoKU2hhd24KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
