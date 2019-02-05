Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08A7C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:45:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537E320844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pfo4KeP1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZFN9hJ9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537E320844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=21tjkYQatTqLeiIKH49wC7HvgzD+IIBbF/BvZBUrCyM=; b=Pfo4KeP1+Z7ecK
	8qtLyHoSoN948Xyez0+XNu8f2Tq1IE7oAu244AzKoRiF3K8xk+yk0HawfeW/YiABHnsp9s/fVqZyt
	KNpnxZ+SigYe38IVlEzRGtnebYdYA2aYBy7RwUBvsSspwSCCyI8A/63iCeq0yE9RGeFEGjkRqCOGu
	fb/Dr83yzIlkuq2RHp4yMrhXdhm1r40yNRlH6WEMDR5MTNl0RwM8QLVjuecu+LehFI8MBRPKAkg4Q
	uS2+YVMN48uTJnyWj480Uhxy4evMnXtkM5mRa5yOpjql46DGp7mFL1akibrH7ti1MIS9B2TMPMHI7
	CKYI4C8EcawNDaXANQvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqrfv-0006PL-QY; Tue, 05 Feb 2019 03:45:31 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqrfs-0006Ow-K1
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 03:45:30 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x153YDEN088462;
 Tue, 5 Feb 2019 03:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=JMERaVWO3bx90UjO8dqcTmU3ZftGStLoslI5tKbbeNQ=;
 b=ZFN9hJ9GJ5s8T+SL6MZYd0lXtiRvjqMgYqzLwXTrvzOuw4ETLNmAwID4SNYaTZQmhlbz
 302Wtv2hKupvgWGETYz2IWTl+3pC25aAzSWZz7zj2eZ4/GBj5ymKnHI7de+gC8m4mQFy
 Is+huBEcwy8dCpAN5Dwztu7HG5PimDknoekVaI1dwppSQ7ASq+/vRciL41tUf7JI1hbq
 HyEwy8aYxY/BMZiUGPv6ncdnB8F23MEdDUFxOqF9ksY7O+j+HMZVhsxZNwlYOr/bAEwN
 GA+yLMimtdhoFhUH8vZ3ZoqViSnqfXMyj5iLHkRvugWY1ZSBG8YCvln1/ehYjAqJ/aAf QQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by aserp2130.oracle.com with ESMTP id 2qd97erpgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Feb 2019 03:35:24 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x153ZHoN026523
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Feb 2019 03:35:17 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x153ZEPS012979;
 Tue, 5 Feb 2019 03:35:14 GMT
Received: from [192.168.0.6] (/209.6.165.165)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 05 Feb 2019 03:35:13 +0000
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance
 into CNA
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190131100009.GB31534@hirez.programming.kicks-ass.net>
Date: Mon, 4 Feb 2019 22:35:09 -0500
Message-Id: <10672939-5C35-4DEF-AFDE-99E85E0F9C46@oracle.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-4-alex.kogan@oracle.com>
 <20190131100009.GB31534@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9157
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=766 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902050026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_194528_755326_F1E3B96A 
X-CRM114-Status: GOOD (  13.27  )
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
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, dave.dice@oracle.com,
 will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 rahul.x.yadav@oracle.com, mingo@redhat.com, steven.sistare@oracle.com,
 longman@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
 daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Cj4gT24gSmFuIDMxLCAyMDE5LCBhdCA1OjAwIEFNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOgo+IAo+IE9uIFdlZCwgSmFuIDMwLCAyMDE5IGF0IDEwOjAxOjM1
UE0gLTA1MDAsIEFsZXggS29nYW4gd3JvdGU6Cj4+IENob29zZSB0aGUgbmV4dCBsb2NrIGhvbGRl
ciBhbW9uZyBzcGlubmluZyB0aHJlYWRzIHJ1bm5pbmcgb24gdGhlIHNhbWUKPj4gc29ja2V0IHdp
dGggaGlnaCBwcm9iYWJpbGl0eSByYXRoZXIgdGhhbiBhbHdheXMuIFdpdGggc21hbGwgcHJvYmFi
aWxpdHksCj4+IGhhbmQgdGhlIGxvY2sgdG8gdGhlIGZpcnN0IHRocmVhZCBpbiB0aGUgc2Vjb25k
YXJ5IHF1ZXVlIG9yLCBpZiB0aGF0Cj4+IHF1ZXVlIGlzIGVtcHR5LCB0byB0aGUgaW1tZWRpYXRl
IHN1Y2Nlc3NvciBvZiB0aGUgY3VycmVudCBsb2NrIGhvbGRlcgo+PiBpbiB0aGUgbWFpbiBxdWV1
ZS4gIFRodXMsIGFzc3VtaW5nIG5vIGZhaWx1cmVzIHdoaWxlIHRocmVhZHMgaG9sZCB0aGUKPj4g
bG9jaywgZXZlcnkgdGhyZWFkIHdvdWxkIGJlIGFibGUgdG8gYWNxdWlyZSB0aGUgbG9jayBhZnRl
ciBhIGJvdW5kZWQKPj4gbnVtYmVyIG9mIGxvY2sgdHJhbnNpdGlvbnMsIHdpdGggaGlnaCBwcm9i
YWJpbGl0eS4KPj4gCj4+IE5vdGUgdGhhdCB3ZSBjb3VsZCBtYWtlIHRoZSBpbnRlci1zb2NrZXQg
dHJhbnNpdGlvbiBkZXRlcm1pbmlzdGljLAo+PiBieSBzdGlja2luZyBhIGNvdW50ZXIgb2YgaW50
cmEtc29ja2V0IHRyYW5zaXRpb25zIGluIHRoZSBoZWFkIG5vZGUKPj4gb2YgdGhlIHNlY29uZGFy
eSBxdWV1ZS4gQXQgdGhlIGhhbmRvZmYgdGltZSwgd2UgY291bGQgaW5jcmVtZW50Cj4+IHRoZSBj
b3VudGVyIGFuZCBjaGVjayBpZiBpdCBpcyBiZWxvdyBhIHRocmVzaG9sZC4gVGhpcyBhZGRzIGFu
b3RoZXIKPj4gZmllbGQgdG8gcXVldWUgbm9kZXMgYW5kIG5lYXJseS1jZXJ0YWluIGxvY2FsIGNh
Y2hlIG1pc3MgdG8gcmVhZCBhbmQKPj4gdXBkYXRlIHRoaXMgY291bnRlciBkdXJpbmcgdGhlIGhh
bmRvZmYuIFdoaWxlIHN0aWxsIGJlYXRpbmcgc3RvY2ssCj4+IHRoaXMgdmFyaWFudCBhZGRzIGNl
cnRhaW4gb3ZlcmhlYWQgb3ZlciB0aGUgcHJvYmFiaWxpc3RpYyB2YXJpYW50Lgo+IAo+IChhbHNv
IGhlYXZpbHkgc3VmZmVycyBmcm9tIHRoZSBzb2NrZXQgPT0gbm9kZSBjb25mdXNpb24pCj4gCj4g
SG93IHdvdWxkIHlvdSBzdWdnZXN0IFJUICd0dW5lcycgdGhpcz8KPiAKPiBSVCByZWxpZXMgb24g
RklGTyBmYWlybmVzcyBvZiB0aGUgYmFzaWMgc3BpbmxvY2sgcHJpbWl0aXZlczsgeW91IGp1c3QK
PiBjb21wbGV0ZWx5IHdyZWNrZWQgdGhhdC4KClRoaXMgaXMgdHJ1ZSB0aGF0IENOQSB0cmFkZXMg
c29tZSBmYWlybmVzcyBmb3Igc2hvcnRlciBsb2NrIGhhbmRvdmVyIGxhdGVuY3ksIG11Y2ggbGlr
ZSBhbnkgb3RoZXIgTlVNQS1hd2FyZSBsb2NrLgoKQ2FuIHlvdSBleHBsYWluLCBob3dldmVyLCB3
aGF0IGV4YWN0bHkgYnJlYWtzIGhlcmU/Ckl0IHNlZW1zIHRoYXQgZXZlbiB0b2RheSwgcXNwaW5s
b2NrIGRvZXMgbm90IHN1cHBvcnQgUlRfUFJFRU1QVCwgZ2l2ZW4gdGhhdCBpdCB1c2VzIHBlci1D
UFUgcXVldWUgbm9kZXMuCgpUaGFuayB5b3UsCuKAlCBBbGV4CgoKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
