Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216FDC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:26:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2188218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NNUJr6qH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DmhbAQai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2188218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/VDy9cyeAaVu+AB8lPV7A/+G+HYYZ2MGFJ83zuuwkZY=; b=NNUJr6qHoqBAMC
	usn5cME+s8w/FZwel9jBRCWRgJzn3NYfnX7Bs1XPdJEJAusUDTsgPVK/9R3iqtQtYtvKtFp//9WW/
	HFooh+P5IvyuyMsHVc4dDE+DA2L4gd17baGUwqP/hFIijovxLavEm3+dWrUwv4rMEkuCuk0kPRGBm
	AorW0Tf37KzWh7Ixzjhbx4my8cit4c2q6irdydlMqS0TM1xeRsDwp6HkplDYx4J4CQkDNR5lOqpz7
	uJ6ocORlbqXL1iFmBHOitH+CGp76NJuDsg3l5NCbDGjYjsHv76B/pv2/otGDcyMH36mQpdep4ZQOT
	FTn1fycL2MR0EBzyn0jA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpgKY-000456-Qn; Fri, 01 Feb 2019 21:26:34 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpgKV-00044n-Hq
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 21:26:33 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x11LOJ7i086365;
 Fri, 1 Feb 2019 21:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=dovBxOd9J5ZjP2z51d4DjxFghwISXIsl79OcbtFXKvA=;
 b=DmhbAQaiQPz1ohrEIV8ysPPzwMrVObCM+CNmhFqT1klQUU8cLvNLAAsNkqSX15qdx1eS
 TDAvKoxswxVSIlb3kxxGEdITpaCdswg8cYw9Z3sabTBU9APfwTNDRTdh41hQH4p0hlq5
 E9MjVSDCTn098zOEdY1RxeplbEDItfVk/PTNtsuD3GE1ztkJGMOFwikPUWpjeJezHLRH
 dU2gdiqEc+aGrvJnQONQ4ivhhzjuJ6nZ4OQWOP25IdEpCB85ZqNZk+awW/drHwXAA3Sw
 4QdBXrc+eTpF70MxI5j4qju9V3rWA/ZwKLl5edixQPUikMW7Yo5ifVn89WO1JPVeLUyv +w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by aserp2130.oracle.com with ESMTP id 2q8d2es53a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Feb 2019 21:26:19 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x11LQDiM017941
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 Feb 2019 21:26:13 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x11LQ9EV030487;
 Fri, 1 Feb 2019 21:26:09 GMT
Received: from [10.39.246.40] (/10.39.246.40)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 01 Feb 2019 13:26:08 -0800
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH 2/3] locking/qspinlock: Introduce CNA into the slow path
 of qspinlock
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <2c8aabab-1bb0-0708-94c4-305fd860609e@redhat.com>
Date: Fri, 1 Feb 2019 16:26:06 -0500
Message-Id: <62BE66CF-1CFA-4921-B2FF-70D5460845D6@oracle.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-3-alex.kogan@oracle.com>
 <2c8aabab-1bb0-0708-94c4-305fd860609e@redhat.com>
To: Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9154
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=847 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902010151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_132631_696202_8BAC6AD1 
X-CRM114-Status: GOOD (  20.57  )
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
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, peterz@infradead.org,
 dave.dice@oracle.com, will.deacon@arm.com, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org, Rahul Yadav <rahul.x.yadav@oracle.com>,
 mingo@redhat.com, Steven Sistare <steven.sistare@oracle.com>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Cj4gT24gSmFuIDMxLCAyMDE5LCBhdCAxMjozOCBQTSwgV2FpbWFuIExvbmcgPGxvbmdtYW5AcmVk
aGF0LmNvbT4gd3JvdGU6Cj4gCj4gT24gMDEvMzAvMjAxOSAxMDowMSBQTSwgQWxleCBLb2dhbiB3
cm90ZToKPj4gSW4gQ05BLCBzcGlubmluZyB0aHJlYWRzIGFyZSBvcmdhbml6ZWQgaW4gdHdvIHF1
ZXVlcywgYSBtYWluIHF1ZXVlIGZvcgo+PiB0aHJlYWRzIHJ1bm5pbmcgb24gdGhlIHNhbWUgc29j
a2V0IGFzIHRoZSBjdXJyZW50IGxvY2sgaG9sZGVyLCBhbmQgYQo+PiBzZWNvbmRhcnkgcXVldWUg
Zm9yIHRocmVhZHMgcnVubmluZyBvbiBvdGhlciBzb2NrZXRzLiBGb3IgZGV0YWlscywKPj4gc2Vl
IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fYXJ4
aXYub3JnX2Fic18xODEwLjA1NjAwJmQ9RHdJRmFRJmM9Um9QMVl1bUNYQ2dhV0h2bFpZUjhQWmg4
QnY3cUlyTVVCNjVlYXBJX0puRSZyPUh2aGszRjRvbWRDay1HRTFQVE9tM0tuMEE3QXBXT1oyYVpM
VHVWeEZLNGsmbT1SZHNSVTRvVTJqLV9oTkc1a0RDNVpFRV9YSGlrbDNRTE50dENhQmRlM1FVJnM9
TlE4NDBTMWx6NTNDcTdBbk9sUFdkbmpaSTdfSWMzcmZZc2YtdzJhWXVzNCZlPS4KPj4gCj4+IE5v
dGUgdGhhdCB0aGlzIHZhcmlhbnQgb2YgQ05BIG1heSBpbnRyb2R1Y2Ugc3RhcnZhdGlvbiBieSBj
b250aW51b3VzbHkKPj4gcGFzc2luZyB0aGUgbG9jayB0byB0aHJlYWRzIHJ1bm5pbmcgb24gdGhl
IHNhbWUgc29ja2V0LiBUaGlzIGlzc3VlCj4+IHdpbGwgYmUgYWRkcmVzc2VkIGxhdGVyIGluIHRo
ZSBzZXJpZXMuCj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IEtvZ2FuIDxhbGV4LmtvZ2FuQG9y
YWNsZS5jb20+Cj4+IFJldmlld2VkLWJ5OiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBv
cmFjbGUuY29tPgo+IAo+IEp1c3Qgd29uZGVyaW5nIGlmIHlvdSBoYXZlIHRyaWVkIGluY2x1ZGUg
UEFSVklSVF9TUElOTE9DS1Mgb3B0aW9uIHRvIHNlZQo+IGlmIHRoYXQgcGF0Y2ggbWF5IHNjcmV3
IHVwIHRoZSBQViBxc3BpbmxvY2sgY29kZS4KTm8sIEkgaGF2ZW7igJl0IHlldC4KVGhlIGlkZWEg
d2FzIHRvIG1ha2UgaXQgd29yayBmb3Igbm9uLVBWIHN5c3RlbXMgZmlyc3QsIGFuZCB0aGVuIGV4
dGVuZCB0byBQVi4KCj4gCj4gQW55d2F5LCBJIGRvIGJlbGlldmUgeW91ciBjbGFpbSB0aGF0IE5V
TUEtYXdhcmUgcXNwaW5sb2NrIGlzIGdvb2QgZm9yCj4gbGFyZ2Ugc3lzdGVtcyB3aXRoIG1hbnkg
bm9kZXMuIEhvd2V2ZXIsIGFsbCB0aGVzZSBleHRyYSBjb2RlIGFyZQo+IG92ZXJoZWFkIGZvciBz
bWFsbCBzeXN0ZW1zIHRoYXQgaGF2ZSBhIHNpbmdsZSBub2RlL3NvY2tldCwgZm9yIGluc3RhbmNl
Lgo+IAo+IEkgd2lsbCBzdXBwb3J0IGRvaW5nIHNvbWV0aGluZyBzaW1pbGFyIHRvIHdoYXQgaGFk
IGJlZW4gZG9uZSB0byBzdXBwb3J0Cj4gUFYgcXNwaW5sb2NrLiBJT1csIGEgc2VwYXJhdGUgc2xv
d3BhdGggZnVuY3Rpb24gdGhhdCBjYW4gYmUgcGF0Y2hlZCB0bwo+IGJlY29tZSB0aGUgZGVmYXVs
dCBkZXBlbmRpbmcgb24gdGhlIHN5c3RlbSBiZWluZyBydW4gb24gb3IgYSBrZXJuZWwgYm9vdAo+
IG9wdGlvbiBzZXR0aW5nLgo+IAo+IEkgd291bGQgbGlrZSB0byBrZWVwIHRoZSBjb3JlIHNsb3dw
YXRoIGZ1bmN0aW9uIHNpbXBsZSBhbmQgZWFzeSB0bwo+IHVuZGVyc3RhbmQuIFNvIG1vc3Qgb2Yg
dGhlIENOQSBjb2RlIHNob3VsZCBiZSBlbmNhcHN1bGF0ZWQgaW50byBzb21lCj4gaGVscGVyIGZ1
bmN0aW9ucyBhbmQgcHV0IGludG8gYSBzZXBhcmF0ZWQgZmlsZS4KU291bmRzIGdvb2QuIApJIHRo
aW5rIGl0IHNob3VsZCBiZSBwcmV0dHkgc3RyYWlnaHRmb3J3YXJkIHRvIGVuY2Fwc3VsYXRlIHRo
ZSBDTkEgY29kZSBhbmQgZG8gd2hhdCB5b3Ugc3VnZ2VzdC4KV2Ugd2lsbCBsb29rIGludG8gdGhh
dC4KClRoYW5rcywK4oCUIEFsZXgKCj4gCj4gVGhhbmtzLAo+IExvbmdtYW4KPiAKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
