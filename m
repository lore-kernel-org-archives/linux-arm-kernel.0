Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D2BC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:22:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 918AA2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AN97WBtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918AA2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ktFQpoNOOWGEho+o810RRy4/TRsyd0BbCFcq5G6IhvU=; b=AN97WBtmpJGgL3
	uydYUz5oJIsD4O2EMYboYEeCF995bhBA8+ecTKCP8iFbvJrKHGEgFlJrNgatN+Trlp5higw0+NTqe
	eLUXXAF4112zuHqFPII+XRZBfnH9l/x+6qGFnX4a2rdU/nBSmM7SOTKN8NqB4lpuSW61iUke/w/Lb
	mwIEXcyUKBOJSSV8vb8pCLV4oCnXqsYVbaz/0C4aAfuyTdPnja3j170ytJlzrBC6pGcUuekltRz3b
	xlgviSrrzlWB9Wk/L1JIF2S704SNnDRCSUVNCIheusicUv4PLb2jGScJk0oAO/0EiaSJx+65AUUmo
	RKuYKNm8Q/pQIRk9qhuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtW8w-0000eI-T0; Tue, 12 Feb 2019 11:22:26 +0000
Received: from mail-pg1-f177.google.com ([209.85.215.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtW8R-0008U1-Bx
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 11:21:57 +0000
Received: by mail-pg1-f177.google.com with SMTP id i130so855010pgd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 03:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+sa+HGFFklO8SW2DkFnpaWAA9j1lrtp2VZ1bk/Z4jmo=;
 b=fTfG3T/n0PYkfua52C8/QNRlzeheyW9Hal1dADtb6Geo4bQr1c7Brcq9DrZOjM7bgC
 gdxTNzC9pHP1yaRQsxuOkBmjV5fe9wXJXhU00teJFGiwA5E545vmbOLsnw5JRCbaw7Lp
 zw4cZNxV3nKv5Vr1sPw3bqGAAGCfaaZl5u04aqma9cO9os0LJiCKDZawO32SczDrDpO6
 jcpeNJZOgv8TYwC7SALUBqWgI7IMG69GV+6KyPH6Bpj1ZIgNM2Cn9zcq0bybARt0xh5z
 cfuVKGdKiWirFFim4YBa4tFzpun8TsRg4UWWhLAQ8jZ1gdFp+NZ5RqTKu0M0VOHsfm//
 w+dg==
X-Gm-Message-State: AHQUAuYDx6p2/J6xOyD/n9EoxO9s0sweQxcHqXspTb6TtSud8mZdOGt8
 e5TKWNJmvf8/nUWgs9d7d64yoQ==
X-Google-Smtp-Source: AHgI3Ia4TQ5C0c05RgEiDWh76euaziWALZSD7pVA7b/sIKrlWHr/PjGyas37tSHn2sbZsGEU8I2xsg==
X-Received: by 2002:aa7:8a19:: with SMTP id m25mr3624923pfa.0.1549970514377;
 Tue, 12 Feb 2019 03:21:54 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net.
 [61.216.91.114])
 by smtp.gmail.com with ESMTPSA id s16sm22282264pfk.166.2019.02.12.03.21.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 03:21:53 -0800 (PST)
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL 3/7] i.MX DT bindings update for 5.1
Date: Tue, 12 Feb 2019 19:21:22 +0800
Message-Id: <20190212112126.572-3-shawnguo@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190212112126.572-1-shawnguo@kernel.org>
References: <20190212112126.572-1-shawnguo@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_032155_771201_01B61B61 
X-CRM114-Status: GOOD (  15.60  )
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
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com, kernel@pengutronix.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQXJuZCwgT2xvZiwKCkluIHRoZSBwYXN0LCBJIHdhcyBzaW1wbHkgdXNpbmcgaW14L2R0IGJy
YW5jaCB0byBjb2xsZWN0IGkuTVggcGxhdGZvcm0KcmVsYXRlZCBEVCBiaW5kaW5ncyBjaGFuZ2Vz
LCB0b2dldGhlciB3aXRoIGFybTMyIGR0cyBvbmVzLiAgTm93IHdpdGggdGhlCm1vdmUgdG8ganNv
bi1zY2hlbWEsIHdlIGFyZSB1c2luZyBhIHNpbmdsZSBmc2wueWFtbCBmaWxlIHRvIGFjY29tbW9k
YXRlCmJvdGggYXJtMzIgYW5kIGFybTY0IHBsYXRmb3JtIGJpbmRpbmdzLCB3aGlsZSB3ZSBoYXZl
IHNlcGFyYXRlIGJyYW5jaGVzCmZvciBkdHMgY2hhbmdlcyAtIGlteC9kdCBhbmQgaW14L2R0NjQu
ICBUbyBhdm9pZCBjb25mbGljdHMsIEkgY2hvc2UgdG8KY3JlYXRlIGEgbmV3IGJyYW5jaCBpbXgv
YmluZGluZ3MgZm9yIGkuTVggcGxhdGZvcm0gYmluZGluZ3MgY2hhbmdlIGZvcgp0aGlzIGN5Y2xl
LiAgVGhhdCdzIHdoeSB3ZSBnZXQgdGhpcyBwdWxsIHJlcXVlc3QsIHdoaWNoIHlvdSB3aWxsIHB1
bGwKaW50byBhcm0tc29jIG5leHQvZHQgYnJhbmNoLCBJIGd1ZXNzLgoKRm9yIGZ1dHVyZSBjeWNs
ZXMsIEkgd291bGQgbGlrZSB0byBoZWFyIHlvdXIgdGhvdWdodHMgb24gaWYgd2UgY2FuIHVzZQph
IHNpbmdsZSBicmFuY2ggZm9yIGJvdGggYXJtMzIgYW5kIGFybTY0IGR0cyBjaGFuZ2VzLCBzbyB0
aGF0IHRoZQpiaW5kaW5ncyBjaGFuZ2VzIGNhbiBnbyBpbiB0aGVyZSB0b28uICBUaGFua3MuCgpT
aGF3bgoKClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgYmZlZmZkMTU1MjgzNzcy
YmJlNzhjNmEwNWRlYzdjMDEyOGVlNTAwYzoKCiAgTGludXggNS4wLXJjMSAoMjAxOS0wMS0wNiAx
NzowODoyMCAtMDgwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0OgoK
ICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc2hhd25ndW8v
bGludXguZ2l0IHRhZ3MvaW14LWJpbmRpbmdzLTUuMQoKZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2Vz
IHVwIHRvIDJhMDA1Mzk3MTE3MDE5Y2JkNGU0YTA5YWI1Y2Y4OTZhMTZiNjUyYzU6CgogIGR0LWJp
bmRpbmdzOiBmc2w6IHNjdTogYWRkIGlteDhxbSBzY3UgY2xvY2sgc3VwcG9ydCAoMjAxOS0wMi0w
MSAxNDoyMToyMiArMDgwMCkKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KaS5NWCBEVCBiaW5kaW5ncyB1cGRhdGUgZm9yIDUu
MToKIC0gQ29udmVydCB0aGUgYmluZGluZ3Mgb2YgRlNMIFNvQ3MgYW5kIHRoZSBib2FyZHMgYnVp
bHQgb24gRlNMIFNvQ3MgdG8KICAganNvbi1zY2hlbWEuCiAtIEFkZCBiaW5kaW5ncyBmb3IgYm9h
cmRzOiBpLk1YOFFYUCBNRUssIExTMTAxMkEgYmFzZWQgT3hhbGlzLCBhbmQKICAgaS5NWDYgYmFz
ZWQgWSBTb2Z0IElPVEEgRHJhY28gYW5kIEh5ZHJhLgogLSBBZGQgdmVuZG9yIHByZWZpeCBmb3Ig
RUJTLVNZU1RBUlQgR21iSCBhbmQgQ2F0YWx5c3QgU2VtaWNvbmR1Y3Rvci4KIC0gQWRkIGJpbmRp
bmdzIGZvciBpbXg4cW0gc2N1IGNsb2NrIGFuZCBpbXg3dWxwIHN5c3RlbSBpbnRlZ3JhdGlvbgog
ICBtb2R1bGUuCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCkFpc2hlbmcgRG9uZyAoMyk6CiAgICAgIGR0LWJpbmRpbmdzOiBh
cm06IGlteDogYWRkIGlteDhxeHAgbWVrIHN1cHBvcnQKICAgICAgZHQtYmluZGluZ3M6IGZzbDog
c2N1OiBhZGQgZmFsbGJhY2sgY29tcGF0aWJsZSBzdHJpbmcgZm9yIGNsb2NrCiAgICAgIGR0LWJp
bmRpbmdzOiBmc2w6IHNjdTogYWRkIGlteDhxbSBzY3UgY2xvY2sgc3VwcG9ydAoKQW5zb24gSHVh
bmcgKDEpOgogICAgICBkdC1iaW5kaW5nczogZnNsOiBhZGQgaW14N3VscCBzeXN0ZW0gaW50ZWdy
YXRpb24gbW9kdWxlIGJpbmRpbmcKCk1hbml2YW5uYW4gU2FkaGFzaXZhbSAoMyk6CiAgICAgIGR0
LWJpbmRpbmdzOiBhcm06IGZzbDogRml4IGJpbmRpbmdzIGZvciBMUzEwMTJBIGFuZCBMUzEwMjFB
IGJhc2VkIGJvYXJkcwogICAgICBkdC1iaW5kaW5nczogdmVuZG9yLXByZWZpeGVzOiBBZGQgRUJT
LVNZU1RBUlQgR21iSCBWZW5kb3IgUHJlZml4CiAgICAgIGR0LWJpbmRpbmdzOiBhcm06IGZzbDog
QWRkIGRldmljZXRyZWUgYmluZGluZyBmb3IgT3hhbGlzCgpNYXJ0eW4gV2VsY2ggKDEpOgogICAg
ICBkdC1iaW5kaW5nczogQWRkIHZlbmRvciBwcmVmaXggZm9yIENhdGFseXN0IFNlbWljb25kdWN0
b3IKClJvYiBIZXJyaW5nICgxKToKICAgICAgZHQtYmluZGluZ3M6IGFybTogQ29udmVydCBGU0wg
Ym9hcmQvc29jIGJpbmRpbmdzIHRvIGpzb24tc2NoZW1hCgpWb2vDocSNIE1pY2hhbCAoMSk6CiAg
ICAgIGR0LWJpbmRpbmdzOiBhcm06IEFkZCBZIFNvZnQgSU9UQSBEcmFjbywgSHlkcmEgYW5kIFVy
c2EgYm9hcmRzCgogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hcm1hZGV1
cy50eHQgfCAgIDYgLQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9iaGYu
dHh0ICAgICAgfCAgIDYgLQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2NvbXB1bGFiLWJv
YXJkcy50eHQgICAgfCAgMjUgLS0tCiAuLi4vYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsaW14
N3VscC1zaW0udHh0ICAgICB8ICAxNiArKwogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2Zy
ZWVzY2FsZS9mc2wsc2N1LnR4dCAgfCAgIDcgKy0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vZnNsLnR4dCAgICAgIHwgMjM3IC0tLS0tLS0tLS0tLS0tLS0tLS0tLQogRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbCAgICAgfCAyMzIgKysr
KysrKysrKysrKysrKysrKysKIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
aTJzZS50eHQgICAgIHwgIDIyIC0tCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL29saW1leC50eHQgICB8ICAxMCAtCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vdGVj
aG5vbG9naWMudHh0ICAgICAgICB8ICAyMyAtLQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvdmVu
ZG9yLXByZWZpeGVzLnR4dCAgICAgICAgfCAgIDIgKwogMTEgZmlsZXMgY2hhbmdlZCwgMjU1IGlu
c2VydGlvbnMoKyksIDMzMSBkZWxldGlvbnMoLSkKIGRlbGV0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2FybWFkZXVzLnR4dAogZGVsZXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYmhmLnR4dAogZGVs
ZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vY29t
cHVsYWItYm9hcmRzLnR4dAogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxpbXg3dWxwLXNpbS50eHQKIGRlbGV0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC50eHQK
IGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJt
L2ZzbC55YW1sCiBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9pMnNlLnR4dAogZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9hcm0vb2xpbWV4LnR4dAogZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vdGVjaG5vbG9naWMudHh0CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
