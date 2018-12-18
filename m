Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9781DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:41:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 556C7218A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hfs89c7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 556C7218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XHgTioXaeR3Ojp1UD26OmRBUMB0sAYqHpRA64f70DtI=; b=Hfs89c7m6z64Tu
	IUL7/jY7APK8ScQPmvD1wig2kA6veqLGbptGMLsbAx8eSpviQhORZ3n0kSwNQ9Vws/R95EHKJKBsa
	+wQ5reUrG2r9SUNhH0fo7BX3PdoM+RyF3y5F3b0hYZrFo1pX/+XoJwzK+2xrXZsRASD39+ah/wi+1
	MKvdZQmSXZ2e4NOfX34eXF6e+Qr5tYH1BDpgsAvvGxPfnJjDg5uKIcpo0LZDzjnRn9ITTt3frkva1
	/FxPWLk3yUakO2UWsnG6FUrTr3XZ7g5Wicz9fFePe7v+gQYeIFgpHSRpEqA2i+152NVC3LqTRY+2c
	E6Y3Bp5Dj4ticuX+XJ8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZFd7-0002R2-C0; Tue, 18 Dec 2018 13:41:49 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZFd3-00023H-3i
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 13:41:47 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5EA1520834; Tue, 18 Dec 2018 14:41:31 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr
 [90.88.157.38])
 by mail.bootlin.com (Postfix) with ESMTPSA id ED7FB207D9;
 Tue, 18 Dec 2018 14:41:30 +0100 (CET)
Date: Tue, 18 Dec 2018 14:41:30 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marek Behun <marek.behun@nic.cz>
Subject: Re: [PATCH v2 03/12] PCI: aardvark: Add PHY support
Message-ID: <20181218144130.3f1a75de@xps13>
In-Reply-To: <20181218140920.6935db39@nic.cz>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
 <20181212102142.16053-4-miquel.raynal@bootlin.com>
 <20181214014701.373b220b@nic.cz> <20181214015712.31f749ea@nic.cz>
 <20181217170724.58421a29@xps13> <20181217223430.182d01d8@nic.cz>
 <20181218091817.4a8a5d42@xps13> <20181218092314.725af970@xps13>
 <20181218140920.6935db39@nic.cz>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_054145_287774_FF2785B6 
X-CRM114-Status: GOOD (  10.03  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTWFyZWssCgpNYXJlayBCZWh1biA8bWFyZWsuYmVodW5AbmljLmN6PiB3cm90ZSBvbiBUdWUs
IDE4IERlYyAyMDE4IDE0OjA5OjIwCiswMTAwOgoKPiA+IFsyXQo+ID4gaHR0cHM6Ly9naXRodWIu
Y29tL0FSTS1zb2Z0d2FyZS9hcm0tdHJ1c3RlZC1maXJtd2FyZS9ibG9iL21hc3Rlci9kcml2ZXJz
L21hcnZlbGwvY29tcGh5L3BoeS1jb21waHktMzcwMC5jICAKPiAKPiBZZXMsIEkgdXNlZCBtYWlu
bGluZSBhdGYgKGl0IGRpZCBub3Qgd29yayBvdXQgb2YgdGhlIGJveCB3aXRoIDE4LjA5Cj4gYXRm
LW1hcnZlbGwgb2YgY291cnNlKS4gQnV0IHRoZXJlIGlzIG5vIF9wb3dlcl9vZmYgZnVuY3Rpb24g
Zm9yIFNHTUlJLAo+IG5vciBhIGRpZ2l0YWxfcmVzZXQgZnVuY3Rpb24gbGlrZSBpbiBjcDExMCBp
bXBsZW1lbnRhdGlvbi4KCkluZGVlZCwgYnV0IHdoeSB3b3VsZCB5b3UgbmVlZCBvbmU/IEp1c3Qg
dXNlIHRoZSBoZWxwZXJzIGZyb20gdGhlIGNvcmUKYW5kIGlmIHRoZXJlIGlzIG5vIGltcGxlbWVu
dGF0aW9uLCBub3RoaW5nIHNob3VsZCBoYXBwZW4gYW5kIHRoZSBoZWxwZXIKc2hvdWxkIGV4aXQg
d2l0aG91dCBlcnJvci4gSnVzdCBjYWxsIHBoeV9zZXRfbW9kZSgpL3BoeV9wb3dlcl9vbigpIGFu
CnlvdSBzaG91bGQgYmUgZ29vZC4KCgpUaGFua3MsCk1pcXXDqGwKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
