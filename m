Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9355C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:56:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87234218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o3PwV+Ab";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V4Bo2QDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87234218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v0bzfVAfyQ2NFwDmFTBU6hBEObIRn+Q0yKKCf4t4Y+k=; b=o3PwV+Ab1FGRvF
	xeVoMGewHw3Ka/7ZJfbkqm5BaYAg4ZHyJ60d9KkTc/jP+wRyZcCbsICACQrxXyuljyxYdYsUOJuaG
	r00MqLXIJMDqECiMQmrgtWIHReIt5LjkGBuZxbQca4L1djjuNCL1N7osfqG4AyGBVn9cHha9zBAAE
	EqlSCYRXi3tMDDFZPaSd8a/SxGgE63lyeuOocE8L63AsKN784KhUpESHzFWR7ZiriMInfpRQrhhd9
	wvDTrpO4liYa9dGgh86gOSvFr/awuL+JEJgR4GETsuH+i3J06aqAeftbQXWA2HBy1U0DaJoY9idKq
	/wROwWYu424xu6XDwbUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gudz2-0007W2-Ll; Fri, 15 Feb 2019 13:56:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gudz0-0007Vq-SW
 for linux-arm-kernel@bombadil.infradead.org; Fri, 15 Feb 2019 13:56:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OSeKz5xylM0wmZcQwGznGzC6Xg4nXc9M+T0JC7H+IFc=; b=V4Bo2QDaDugwWYw83s9GhDWC5C
 LMO+zvFIaOCC70RUmFC6HNxvfIETDgG/LX2+Qg2BPTNfHiWuDujNOH5HKZl9hff11vF0LZEQbqDf6
 Cus/OBZhdmHQnvscjboFEsQyQWfsqNFOwQBwxmsY4xMQXAJNVtRXOZEQdgk1AjKgSilFZyB3kXAY5
 roW8LVSCJlbbFUh5v1DvDS2bYP69kh13/No65ZNfw/TB3BbusquJCet/bWsNcRfmOBt6Zpa9pvTxA
 /AMMsEMZfLUAFG1TvV4Z6Cm3Kc03BHzgij0U5IFwU9G2W6NlukT2xV0M1TXJAfaGlBAlsUrcyeiqI
 lOBWGsCA==;
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gudyx-00047E-FQ
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 13:56:49 +0000
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 0B9D7FF805;
 Fri, 15 Feb 2019 13:56:13 +0000 (UTC)
Date: Fri, 15 Feb 2019 14:56:13 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: allwinner: h6: Add CPU Operating
 Performance Points table
Message-ID: <20190215135613.sdz56vtiawqeryi5@flea>
References: <20190214130910.9201-1-tiny.windzz@gmail.com>
 <20190214130910.9201-5-tiny.windzz@gmail.com>
 <20190214143842.nqsh6trwdjxq2ecd@flea>
 <CAEExFWuxrVC1J0g93R3ifaDxOGy-20B4jftoHw932V7+wqhtxw@mail.gmail.com>
 <CAEExFWv_K_07e30dgPbafVhDD_smwZkpi6Fqk6yzCahesdnrGg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEExFWv_K_07e30dgPbafVhDD_smwZkpi6Fqk6yzCahesdnrGg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_135647_549853_8ACEB106 
X-CRM114-Status: GOOD (  10.95  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkKCk9uIEZyaSwgRmViIDE1LCAyMDE5IGF0IDEyOjU2OjAzQU0gKzA4MDAsIEZyYW5rIExlZSB3
cm90ZToKPiBIb3cgYWJvdXQgdG8gaW1wbGVtZW50IGEgdGhlcm1hbCBkcml2ZXIgdGhhdCBpcyBu
b3QgaW50ZWdyYXRlZCB3aXRoCj4gZ3BhZGMg77yfCj4gCj4gR1BBREMgb24gc29jIGlzIHJhcmVs
eSB1c2VkIG5vdy4KCllvdSBtZWFuIEdQQURDIGluIGdlbmVyYWwsIG9yIHRoZSBncGFkYyBkcml2
ZXIgaW4gcGFydGljdWxhcj8KT3RoZXJ3aXNlLCB5ZXMsIGhhdmluZyBhIGRyaXZlciBmb3IgdGhl
IHRoZXJtYWwgc2Vuc29yIGluIHRoZSBINgpzb3VuZHMgbGlrZSBhIGdvb2QgcGxhbiBmb3IgdGhl
cm1hbCB0aHJvdHRsaW5nLCBidXQgSSBkb24ndCBzZWUgaXQgYXMKYSBkZXBlbmRlbmN5IGZvciB0
aGF0IHdob2xlIHNlcmllcy4KCk1heGltZQoKLS0gCk1heGltZSBSaXBhcmQsIEJvb3RsaW4KRW1i
ZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZwpodHRwczovL2Jvb3RsaW4uY29tCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
