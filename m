Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74B4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:36:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC49320651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hG8lRvN6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hFhA8QE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC49320651
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NqKl1a8rtvxb3MaO0RXisVqeVV6QJ+1JSbo4niaDsRY=; b=hG8lRvN6sQTqrX
	xHVwEazEX5BQZ1HL1n4FBCEm4kjbWrnr9r2HqBuZ+NaM6TKz6YhpMGHZ8YrGEMhamb9IFTvO04tdg
	AY+yGHdMEK8B+1PoHMX4AIYZRKRhGOCoNvRcH72guxEvciosDw2yDDWNeIuiZrr/8+sXwzBRereQG
	bJ1Q5ENlS8F1C9LqjH2Bb5AeSsGH+VELAaIwy7ltXmPb0Jzkrxy0M6gJjFrc5iDDZkDUpnm6GSSkO
	CfC8dSo+HNHFO2FkvkFkwI2+StEqJLDMJl+1+e4ijQ9GRoWCi5Xj0loIZinlZNMNFVOpedQQmsNWr
	gL9OzK5q6X3N5UPaMB3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2PM-0002X5-Ig; Mon, 14 Jan 2019 13:36:04 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2GW-0004vB-W7
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 13:27:43 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EDQmWa019648;
 Mon, 14 Jan 2019 07:26:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547472408;
 bh=0PiaQYnV59ccfwEhn8gPR5j82jBP2sS0jMXzDzaA8TY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=hFhA8QE82uMeSb5OF7qMlUx6XubeLPJNUbOTu8pcgaQaL98xcm7YrnF8fMnDsopih
 7trFXBk+ZF6gKvoVgNkgxThAyfJOGvhWTOXhA+L2cb8LCuqsAyoBQnprtQsrnsGoCv
 mUKcD/laa7eRygEsk9MHJAKduAPXVkBzQRUa1WBg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EDQmfb095069
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Jan 2019 07:26:48 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 07:26:46 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 07:26:47 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EDOoWj028516;
 Mon, 14 Jan 2019 07:26:43 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring
 <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 23/24] misc: pci_endpoint_test: Add support to test PCI EP in
 AM654x
Date: Mon, 14 Jan 2019 18:54:23 +0530
Message-ID: <20190114132424.6445-24-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114132424.6445-1-kishon@ti.com>
References: <20190114132424.6445-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_052657_875214_4404DE56 
X-CRM114-Status: GOOD (  16.57  )
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
 Jesper Nilsson <jesper.nilsson@axis.com>, Arnd Bergmann <arnd@arndb.de>,
 Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
 Kishon Vijay Abraham I <kishon@ti.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VEkncyBBTTY1NHggUENJZSBFUCBoYXMgYSByZXN0cmljdGlvbiB0aGF0IEJBUl8wIGlzIG1hcHBl
ZCB0bwphcHBsaWNhdGlvbiByZWdpc3RlcnMuICJQQ0llIEluYm91bmQgQWRkcmVzcyBUcmFuc2xh
dGlvbiIgc2VjdGlvbiBpbgpBTTY1eCBTaXRhcmEgUHJvY2Vzc29ycyBUUk0gKFNQUlVJRDcg4oCT
IEFwcmlsIDIwMTgpIGRlc2NyaWJlcyBCQVIwIGlzCnJlc2VydmVkLiBDb25maWd1cmUgcGNpX2Vu
ZHBvaW50X3Rlc3QgdG8gdXNlIEJBUl8yIGluc3RlYWQuCkFsc28gc2V0IGFsaWdubWVudCB0byA2
NEsgc2luY2UgIlBDSWUgU3Vic3lzdGVtIEFkZHJlc3MgVHJhbnNsYXRpb24iCnNlY3Rpb24gaW4g
VFJNIGluZGljYXRlcyBtaW5pbXVtIEFUVSB3aW5kb3cgc2l6ZSBpcyA2NEsuCgpTaWduZWQtb2Zm
LWJ5OiBLaXNob24gVmlqYXkgQWJyYWhhbSBJIDxraXNob25AdGkuY29tPgotLS0KIGRyaXZlcnMv
bWlzYy9wY2lfZW5kcG9pbnRfdGVzdC5jIHwgMTYgKysrKysrKysrKysrKysrKwogMSBmaWxlIGNo
YW5nZWQsIDE2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvcGNpX2Vu
ZHBvaW50X3Rlc3QuYyBiL2RyaXZlcnMvbWlzYy9wY2lfZW5kcG9pbnRfdGVzdC5jCmluZGV4IDg5
NmUyZGY5NDAwZi4uNmRmYWVlYWVlYzBhIDEwMDY0NAotLS0gYS9kcml2ZXJzL21pc2MvcGNpX2Vu
ZHBvaW50X3Rlc3QuYworKysgYi9kcml2ZXJzL21pc2MvcGNpX2VuZHBvaW50X3Rlc3QuYwpAQCAt
NzUsNiArNzUsMTEgQEAKICNkZWZpbmUgUENJX0VORFBPSU5UX1RFU1RfSVJRX1RZUEUJCTB4MjQK
ICNkZWZpbmUgUENJX0VORFBPSU5UX1RFU1RfSVJRX05VTUJFUgkJMHgyOAogCisjZGVmaW5lIFBD
SV9ERVZJQ0VfSURfVElfQU02NTQJCQkweGIwMGMKKworI2RlZmluZSBpc19hbTY1NF9wY2lfZGV2
KHBkZXYpCQlcCisJCSgocGRldiktPmRldmljZSA9PSBQQ0lfREVWSUNFX0lEX1RJX0FNNjU0KQor
CiBzdGF0aWMgREVGSU5FX0lEQShwY2lfZW5kcG9pbnRfdGVzdF9pZGEpOwogCiAjZGVmaW5lIHRv
X2VuZHBvaW50X3Rlc3QocHJpdikgY29udGFpbmVyX29mKChwcml2KSwgc3RydWN0IHBjaV9lbmRw
b2ludF90ZXN0LCBcCkBAIC01ODgsNiArNTkzLDcgQEAgc3RhdGljIGxvbmcgcGNpX2VuZHBvaW50
X3Rlc3RfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVkIGludCBjbWQsCiAJaW50IHJl
dCA9IC1FSU5WQUw7CiAJZW51bSBwY2lfYmFybm8gYmFyOwogCXN0cnVjdCBwY2lfZW5kcG9pbnRf
dGVzdCAqdGVzdCA9IHRvX2VuZHBvaW50X3Rlc3QoZmlsZS0+cHJpdmF0ZV9kYXRhKTsKKwlzdHJ1
Y3QgcGNpX2RldiAqcGRldiA9IHRlc3QtPnBkZXY7CiAKIAltdXRleF9sb2NrKCZ0ZXN0LT5tdXRl
eCk7CiAJc3dpdGNoIChjbWQpIHsKQEAgLTU5NSw2ICs2MDEsOCBAQCBzdGF0aWMgbG9uZyBwY2lf
ZW5kcG9pbnRfdGVzdF9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50IGNtZCwK
IAkJYmFyID0gYXJnOwogCQlpZiAoYmFyIDwgMCB8fCBiYXIgPiA1KQogCQkJZ290byByZXQ7CisJ
CWlmIChpc19hbTY1NF9wY2lfZGV2KHBkZXYpICYmIGJhciA9PSBCQVJfMCkKKwkJCWdvdG8gcmV0
OwogCQlyZXQgPSBwY2lfZW5kcG9pbnRfdGVzdF9iYXIodGVzdCwgYmFyKTsKIAkJYnJlYWs7CiAJ
Y2FzZSBQQ0lURVNUX0xFR0FDWV9JUlE6CkBAIC03ODUsMTAgKzc5MywxOCBAQCBzdGF0aWMgdm9p
ZCBwY2lfZW5kcG9pbnRfdGVzdF9yZW1vdmUoc3RydWN0IHBjaV9kZXYgKnBkZXYpCiAJcGNpX2Rp
c2FibGVfZGV2aWNlKHBkZXYpOwogfQogCitzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9lbmRwb2lu
dF90ZXN0X2RhdGEgYW02NTRfZGF0YSA9IHsKKwkudGVzdF9yZWdfYmFyID0gQkFSXzIsCisJLmFs
aWdubWVudCA9IFNaXzY0SywKK307CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9p
ZCBwY2lfZW5kcG9pbnRfdGVzdF90YmxbXSA9IHsKIAl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9J
RF9USSwgUENJX0RFVklDRV9JRF9USV9EUkE3NHgpIH0sCiAJeyBQQ0lfREVWSUNFKFBDSV9WRU5E
T1JfSURfVEksIFBDSV9ERVZJQ0VfSURfVElfRFJBNzJ4KSB9LAogCXsgUENJX0RFVklDRShQQ0lf
VkVORE9SX0lEX1NZTk9QU1lTLCAweGVkZGEpIH0sCisJeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1Jf
SURfVEksIFBDSV9ERVZJQ0VfSURfVElfQU02NTQpLAorCSAgLmRyaXZlcl9kYXRhID0gKGtlcm5l
bF91bG9uZ190KSZhbTY1NF9kYXRhCisJfSwKIAl7IH0KIH07CiBNT0RVTEVfREVWSUNFX1RBQkxF
KHBjaSwgcGNpX2VuZHBvaW50X3Rlc3RfdGJsKTsKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
