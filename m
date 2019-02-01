Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90FAC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:21:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772CD2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kXNBx+fn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rWsV8aN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772CD2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rS5uTWRcTZm0X4J3t9HUBZQ8Jo0YPKsALJIKasmqRpQ=; b=kXNBx+fn9l5VxI
	3aeTnPZNAIy/fusBpyL7mY7zXl+L1uouWgCoxvD30oEVRKXkkKnulORo25jKYd6KiT5ZUtv/D7Lhx
	3ui77+WN4SxZ+d99NlkJalhQYnnxWNAXy2pR84aLnWwyca4wlM9CB1gFdiyUy915aM+jEDWjZ1iR0
	tRmcSApS8pwMntWYZllNxWjRoTgSS/DRcyOxlU8CLW/lWiiHlU5K+IZQ038IAx7DHKLIMVNJLhErk
	bXs8lcdSx5wHXOxC6W8ntP//eQrnufsldhi2Xb+flAvy5sZgEH1I20SjORaMLcHPKM+0LC8DvVde3
	PvU0sKgeyiJNUo5+m8fg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpgFi-0002Ef-Pe; Fri, 01 Feb 2019 21:21:34 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpgFe-0002E8-F7
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 21:21:32 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x11LJ4Te082234;
 Fri, 1 Feb 2019 21:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=dhpkZZdzz+1m3AsfE8doVtl5zOEd1OtdZUCjhlrOFkE=;
 b=rWsV8aN3Om0VKWfSG8URjpvtjiUo4EL2c1BNbYA+mpZbKO3H3LKhJ1kYODoxdtGfjGtL
 3XSbEY0ddFTJPQHuL7o6aYOQU4jt1VYxwkAy9bKnDe9rSnDnALfJRfWV33ItVw33L2CZ
 kWrqBTeeCRemEqqOFXvWkhqugVOr00tk9MPbdh6sEEDu/H4R833HF+aWXp5KsRUuk5eI
 6F44cSPItps4wwhtfLOHRH6xEMGw5iHs69Yj1lHE7paMZLRGF/jULSxBbozopXY7Mvix
 /+0s2KmTVfT6cNP1w/JOpe66/wcdh+9WJf47YkKiv+mmxJLZ3PkGoaWUp19Rdin9XiPS dA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
 by aserp2130.oracle.com with ESMTP id 2q8d2es4fr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Feb 2019 21:20:57 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x11LKulr032732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 Feb 2019 21:20:57 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x11LKujP026297;
 Fri, 1 Feb 2019 21:20:56 GMT
Received: from [10.39.246.40] (/10.39.246.40)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 01 Feb 2019 13:20:55 -0800
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH 0/3] Add NUMA-awareness to qspinlock
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190131095638.GA31534@hirez.programming.kicks-ass.net>
Date: Fri, 1 Feb 2019 16:20:53 -0500
Message-Id: <6D5F7272-5E25-49C8-BAD4-D0D402068BA0@oracle.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131095638.GA31534@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9154
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902010150
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_132130_596344_B58D74AF 
X-CRM114-Status: GOOD (  20.26  )
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
 rahul.x.yadav@oracle.com, mingo@redhat.com,
 Steven Sistare <steven.sistare@oracle.com>, longman@redhat.com,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Cj4gT24gSmFuIDMxLCAyMDE5LCBhdCA0OjU2IEFNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOgo+IAo+IE9uIFdlZCwgSmFuIDMwLCAyMDE5IGF0IDEwOjAxOjMy
UE0gLTA1MDAsIEFsZXggS29nYW4gd3JvdGU6Cj4+IExvY2sgdGhyb3VnaHB1dCBjYW4gYmUgaW5j
cmVhc2VkIGJ5IGhhbmRpbmcgYSBsb2NrIHRvIGEgd2FpdGVyIG9uIHRoZQo+PiBzYW1lIE5VTUEg
c29ja2V0IGFzIHRoZSBsb2NrIGhvbGRlciwgcHJvdmlkZWQgY2FyZSBpcyB0YWtlbiB0byBhdm9p
ZAo+PiBzdGFydmF0aW9uIG9mIHdhaXRlcnMgb24gb3RoZXIgTlVNQSBzb2NrZXRzLiBUaGlzIHBh
dGNoIGludHJvZHVjZXMgQ05BCj4+IChjb21wYWN0IE5VTUEtYXdhcmUgbG9jaykgYXMgdGhlIHNs
b3cgcGF0aCBmb3IgcXNwaW5sb2NrLgo+IAo+IFNpbmNlIHlvdSB1c2UgTlVNQSwgdXNlIHRoZSB0
ZXJtIG5vZGUsIG5vdCBzb2NrZXQuIFRoZSB0d28gYXJlIG5vdAo+IHN0cmljdGx5IHJlbGF0ZWQu
CkdvdCBpdCwgdGhhbmtzLgoKPiAKPj4gQ05BIGlzIGEgTlVNQS1hd2FyZSB2ZXJzaW9uIG9mIHRo
ZSBNQ1Mgc3Bpbi1sb2NrLiBTcGlubmluZyB0aHJlYWRzIGFyZQo+PiBvcmdhbml6ZWQgaW4gdHdv
IHF1ZXVlcywgYSBtYWluIHF1ZXVlIGZvciB0aHJlYWRzIHJ1bm5pbmcgb24gdGhlIHNhbWUKPj4g
c29ja2V0IGFzIHRoZSBjdXJyZW50IGxvY2sgaG9sZGVyLCBhbmQgYSBzZWNvbmRhcnkgcXVldWUg
Zm9yIHRocmVhZHMKPj4gcnVubmluZyBvbiBvdGhlciBzb2NrZXRzLiBUaHJlYWRzIHJlY29yZCB0
aGUgSUQgb2YgdGhlIHNvY2tldCBvbiB3aGljaAo+PiB0aGV5IGFyZSBydW5uaW5nIGluIHRoZWly
IHF1ZXVlIG5vZGVzLiBBdCB0aGUgdW5sb2NrIHRpbWUsIHRoZSBsb2NrCj4+IGhvbGRlciBzY2Fu
cyB0aGUgbWFpbiBxdWV1ZSBsb29raW5nIGZvciBhIHRocmVhZCBydW5uaW5nIG9uIHRoZSBzYW1l
Cj4+IHNvY2tldC4gSWYgZm91bmQgKGNhbGwgaXQgdGhyZWFkIFQpLCBhbGwgdGhyZWFkcyBpbiB0
aGUgbWFpbiBxdWV1ZQo+PiBiZXR3ZWVuIHRoZSBjdXJyZW50IGxvY2sgaG9sZGVyIGFuZCBUIGFy
ZSBtb3ZlZCB0byB0aGUgZW5kIG9mIHRoZQo+PiBzZWNvbmRhcnkgcXVldWUsIGFuZCB0aGUgbG9j
ayBpcyBwYXNzZWQgdG8gVC4gSWYgc3VjaCBUIGlzIG5vdCBmb3VuZCwgdGhlCj4+IGxvY2sgaXMg
cGFzc2VkIHRvIHRoZSBmaXJzdCBub2RlIGluIHRoZSBzZWNvbmRhcnkgcXVldWUuIEZpbmFsbHks
IGlmIHRoZQo+PiBzZWNvbmRhcnkgcXVldWUgaXMgZW1wdHksIHRoZSBsb2NrIGlzIHBhc3NlZCB0
byB0aGUgbmV4dCB0aHJlYWQgaW4gdGhlCj4+IG1haW4gcXVldWUuCj4+IAo+PiBGdWxsIGRldGFp
bHMgYXJlIGF2YWlsYWJsZSBhdCBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIv
dXJsP3U9aHR0cHMtM0FfX2FyeGl2Lm9yZ19hYnNfMTgxMC4wNTYwMCZkPUR3SUJBZyZjPVJvUDFZ
dW1DWENnYVdIdmxaWVI4UFpoOEJ2N3FJck1VQjY1ZWFwSV9KbkUmcj1IdmhrM0Y0b21kQ2stR0Ux
UFRPbTNLbjBBN0FwV09aMmFaTFR1VnhGSzRrJm09N3NGWnJzZHBMSnhMUkhJRldOX3NFNnpnS3ky
MFRpOGxPb2VwaUV5aXBBbyZzPTVWUkFRVmp3MEIxU0NqdkJMenp3eGtIUTZUWjNGSWxfdEdEZnZu
M0ZYdm8mZT0uCj4gCj4gRnVsbCBkZXRhaWxzIHJlYWxseSBzaG91bGQgYWxzbyBiZSBpbiB0aGUg
Q2hhbmdlbG9nLiBZb3UgY2FuIHNraXAgbXVjaAo+IG9mIHRoZSBhY2FkZW1pYyBibGEtYmxhLCBi
dXQgdGhlIENoYW5nZWxvZyBzaG91bGQgYmUgc2VsZiBjb250YWluZWQuCj4gCj4+IFdlIGhhdmUg
ZG9uZSBzb21lIHBlcmZvcm1hbmNlIGV2YWx1YXRpb24gd2l0aCB0aGUgbG9ja3RvcnR1cmUgbW9k
dWxlCj4+IGFzIHdlbGwgYXMgd2l0aCBzZXZlcmFsIGJlbmNobWFya3MgZnJvbSB0aGUgd2lsbC1p
dC1zY2FsZSByZXBvLgo+PiBUaGUgZm9sbG93aW5nIGxvY2t0b3J0dXJlIHJlc3VsdHMgYXJlIGZy
b20gYW4gT3JhY2xlIFg1LTQgc2VydmVyCj4+IChmb3VyIEludGVsIFhlb24gRTctODg5NSB2MyBA
IDIuNjBHSHogc29ja2V0cyB3aXRoIDE4IGh5cGVydGhyZWFkZWQKPj4gY29yZXMgZWFjaCkuIEVh
Y2ggbnVtYmVyIHJlcHJlc2VudHMgYW4gYXZlcmFnZSAob3ZlciA1IHJ1bnMpIG9mIHRoZQo+PiB0
b3RhbCBudW1iZXIgb2Ygb3BzICh4MTBeNykgcmVwb3J0ZWQgYXQgdGhlIGVuZCBvZiBlYWNoIHJ1
bi4gVGhlIHN0b2NrCj4+IGtlcm5lbCBpcyB2NC4yMC4wLXJjNCsgY29tcGlsZWQgaW4gdGhlIGRl
ZmF1bHQgY29uZmlndXJhdGlvbi4KPj4gCj4+ICN0aHIgIHN0b2NrICBwYXRjaGVkIHNwZWVkdXAg
KHBhdGNoZWQvc3RvY2spCj4+ICAxICAgMi43MTAgICAyLjcxNSAgMS4wMDIKPj4gIDIgICAzLjEw
OCAgIDMuMDAxICAwLjk2Ngo+PiAgNCAgIDQuMTk0ICAgMy45MTkgIDAuOTM0Cj4gCj4gU28gbG93
IGNvbnRlbnRpb24gaXMgYWN0dWFsbHkgd29yc2UuIEZ1bm5pbHkgbG93IGNvbnRlbnRpb24gaXMg
dGhlCj4gbWFqb3JpdHkgb2Ygb3VyIGxvY2tzIGFuZCBpcyBfcmVhbGx5XyBpbXBvcnRhbnQuClRo
aXMgY2FuIGJlIG1vc3QgY2VydGFpbmx5IGVuZ2luZWVyZWQgb3V0LCBlLmcuLCBieSBjYWNoaW5n
IHRoZSBub2RlIElEIG9uIHdoaWNoIGEgdGFzayBpcyBydW5uaW5nLgpXZSB3aWxsIGxvb2sgaW50
byB0aGF0LgoKPiAKPj4gIDggICA1LjMwOSAgIDYuODk0ICAxLjI5OQo+PiAxNiAgIDYuNzIyICAg
OS4wOTQgIDEuMzUzCj4+IDMyICAgNy4zMTQgICA5Ljg4NSAgMS4zNTIKPj4gMzYgICA3LjU2MiAg
IDkuODU1ICAxLjMwMwo+PiA3MiAgIDYuNjk2ICAxMC4zNTggIDEuNTQ3Cj4+IDEwOCAgIDYuMzY0
ICAxMC4xODEgIDEuNjAwCj4+IDE0MiAgIDYuMTc5ICAxMC4xNzggIDEuNjQ3Cj4+IAo+PiBXaGVu
IHRoZSBrZXJuZWwgaXMgY29tcGlsZWQgd2l0aCBsb2Nrc3RhdCBlbmFibGVkLCBDTkEgCj4gCj4g
SSdsbCBpZ25vcmUgdGhhdCwgbG9ja3N0YXQvbG9ja2RlcCBlbmFibGVkIHJ1bnMgYXJlIG5vdCB3
aGF0IG9uZSB3b3VsZAo+IGNhbGwgcGVyZm9ybWFuY2UgcmVsZXZhbnQuClBsZWFzZSwgbm90ZSB0
aGF0IG9ubHkgb25lIHNldCBvZiByZXN1bHRzIGhhcyBsb2Nrc3RhdCBlbmFibGVkLgpUaGUgcmVz
dCBvZiB0aGUgcmVzdWx0cyAod2lsbC1pdC1zY2FsZSBpbmNsdWRlZCkgZG8gbm90IGhhdmUgaXQu
CgpSZWdhcmRzLArigJQgQWxleAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
