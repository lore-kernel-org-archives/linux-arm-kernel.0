Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2630EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:43:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6329218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y+oMc+6P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=maxbiz.eu header.i=@maxbiz.eu header.b="vOzHlUQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6329218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=maxbiz.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=iGwS48DVFB1awVDHWEwnZ5rQxUbkVNV6tZidpXhYYtI=; b=Y+oMc+6PrL6TEq
	1WDKeYRVuFvWm9+9jodB9Z0uoN1TU94YBqtkykqIS1PC/EPNBINEMkm49jbK0+4WPhybWrf2TsQTS
	0RlYLwCfh1rV+o1fagubMMelQOw60AL7Wb28L0R3XaDtLdE8FiKe7ERcl0ASl1Xgb6XqBAS7NDtAz
	AE8CXSKPCHofP07sr+nyEyuVAEdLq8hBLIIjdIzL/4JX+HGRhY3FZUtKBfWCVeePTSF9kWoHX/hWp
	aV4sR0YpgcpOH1i+CedTUlQBYy+x6ae/GT0mZg0Q8NpxQZK3wthh3Ad2LjCce/9iTfUuqAgmOYXNQ
	1QfcE7FQwvzr4i9o2o6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyuoO-00077A-1O; Wed, 27 Feb 2019 08:43:32 +0000
Received: from mail.maxbiz.eu ([80.211.46.33] helo=maxbiz.eu)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyuoK-00076e-Ku
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 08:43:30 +0000
Received: by maxbiz.eu (Postfix, from userid 1001)
 id 8C86CA1259; Wed, 27 Feb 2019 09:33:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=maxbiz.eu; s=mail;
 t=1551256989; bh=R4QEGHDcTE7B9tlwS/zEwnebz6wbE32ec3X/wEA4R+w=;
 h=Date:From:To:Subject:From;
 b=vOzHlUQxSs1DsRtSN3ySUi9pJ5oCEi6Zq+yXfu7cgeJFYGyHsXEegHQig4uc5LgC2
 izKlbG1/tkfMtPjLFzEDoOpc4qCuSJU3Oi5Lgb84nixiPApL3h4Kt8o2ZZPMiAz3wd
 kjIkxEl0BBtT2e9xRp9AyqFe55sSx6XRyGYd6j3M=
Received: by mail.maxbiz.eu for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 08:33:21 GMT
Message-ID: <20190227091246-0.1.1e.6b6g.0.4nny35do59@maxbiz.eu>
Date: Wed, 27 Feb 2019 08:33:21 GMT
From: =?UTF-8?Q?"L=C3=A1szl=C3=B3_P=C3=A9ter"?= <l.peter@maxbiz.eu>
To: <linux-arm-kernel@lists.infradead.org>
Subject: =?UTF-8?Q?Term=C3=A9szetbeni_juttat=C3=A1sok?=
X-Mailer: mail.maxbiz.eu
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_004328_884647_288C837B 
X-CRM114-Status: UNSURE (   2.91  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

w5xkdsO2emzDtm0hCiAKQsOhciAyMDE5IGphbnXDoXJqw6F0w7NsIHN6aW50ZSBtaW5kZW4gYsOp
cmVuIGvDrXbDvGxpIGp1dHRhdMOhcyBqw7Z2ZWRlbGVta8OpbnQgZm9nIGFkw7N6bmksIGEgdsOh
bGxhbGF0b2sgdMO2YmIgbWludCA1NSUtYSBtZWcga8OtdsOhbmphIHRhcnRhbmkgYSBkb2xnb3rD
s2kganV0dGF0w6Fzb2sgbmV0dMOzIMO2c3N6ZWfDqXQuCiAKSnV0dGF0w6FzaSBrw6FydHnDoWlu
ayBzemludGUgYXogw7Zzc3plcyBqZWxlbmxlZyBoYXN6bsOhbHQgYsOpcmVuIGvDrXbDvGxpIGp1
dHRhdMOhc3QgbGVmZWRpaywga29ybMOhdGxhbiBmZWxoYXN6bsOhbMOhc3NhbC4gTWluZGVubmFw
b3Mga8O2bHRzw6lnZWsgZmVkZXpoZXTFkWsgdmVsw7xrLCBww6lsZMOhdWwgw6lsZWxtaXN6ZXIg
dsOhc8OhcmzDoXMsIGVnw6lzenPDqWfDvGd5aSBlbGzDoXTDoXMsIHJ1aMOhemF0LCBlbGVrdHJv
bmlrYSwgw7x6ZW1hbnlhZ2vDtmx0c8OpZywga8O2em3FsWTDrWosIGlsbGV0dmUga8Opc3pww6lu
emZlbHbDqXRlbHJlIGlzIGFsa2FsbWFzYWsuCiAKRXogYXogZWd5ZXRsZW4gb2x5YW4ganV0dGF0
w6FzaSBrw6FydHlhIE1hZ3lhcm9yc3rDoWdvbiwgYW1lbHlldCBtaW5kZW4gaGF6YWkgUE9TIHRl
cm1pbsOhbCBlbGZvZ2FkLgogClRvdsOhYmJpIGluZm9ybcOhY2nDs8OpcnQga8OpcmVtLCBrZXJl
c3NlbiBmZWwhCgoKTMOhc3psw7MgUMOpdGVyClByb2R1Y3QgTWFuYWdlcgp3d3cubWF4Yml6LmV1
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
