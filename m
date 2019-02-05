Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA0BC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:08:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6B02175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HV0T+LKA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vzDwJm95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6B02175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8eCq85/eQEnKPbEGp24Hijg8xMaUTeScAuzHQXAsQa0=; b=HV0T+LKAKvBRWk
	bhijO2HRD4gfJJQrej+lfjSYSWbZDE0z7riLIhNy+ncA6BJLd6D/3z/HwY0q1fVaiLj2+Xsof0TzD
	YC2XnXSx6mL4xY/Tk16ZwjPHpefCwFVKFiBMFhtan5k5TD133LEbbTaIvxGabOxeDna2ePfzy4Cnb
	eOPbKGrV4f8IRFPYb/vaCSxW0MVu+7rMDoXM2oOHQdr56GYaO/eRiL/qfJaEeHj9k7Jd/n684PBqD
	8q58FUITyxMsE0YJWNVbzh5B500fV8U/SlXYlCXTllIz6G5bSNWFKdr/pa5tVmElI3EwgXnMB3LSg
	f9SnloQs43rGoQ3hwAFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr7ws-0004YM-24; Tue, 05 Feb 2019 21:08:06 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr7wo-0004Xu-B7
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 21:08:04 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x15L4ABx173307;
 Tue, 5 Feb 2019 21:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=m96kazws33ron0aki5AooH0yyu3XbZINH3epnn7EtvY=;
 b=vzDwJm9541ymmwW/tsjxwvwzXMFCaa4I7IEyuA1uLlVtG2m3rFvOz1vbXNyOY26CCCDR
 EFSj+7gT9Jwd8D9rZjb6QI9P+CGXnmCPGQQc/pBPlEJfNB6Nh9WhplueYbn7oOV6QJxh
 vJEx2+mrt4dSiT3Z1lOyPlFXgDixOTTJGEdEiUBu3iRKYFuPD5LRPGiSa1lOBvEFgG3t
 yHaU3tkS4AwbYiaAioc9s+VnX2RazaT7gwXEtGGMlEFKN5NHMU1DCBCXv/pcHslQAvj9
 AUH2emCMepvO8Zr8jTqfcZsZT9ArZ6s97X6xvVtm0gmcKDeh1dSTR/ssv5ZST/sSLZ3c 2A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by userp2130.oracle.com with ESMTP id 2qd9ardjvq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Feb 2019 21:07:39 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x15L7dMG005170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Feb 2019 21:07:39 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x15L7cfu015545;
 Tue, 5 Feb 2019 21:07:38 GMT
Received: from [10.39.215.77] (/10.39.215.77)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 05 Feb 2019 21:07:37 +0000
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance
 into CNA
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190205092256.GN17528@hirez.programming.kicks-ass.net>
Date: Tue, 5 Feb 2019 16:07:37 -0500
Message-Id: <4A727687-51F9-4FD0-9608-CDBAD6A6EF07@oracle.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-4-alex.kogan@oracle.com>
 <20190131100009.GB31534@hirez.programming.kicks-ass.net>
 <10672939-5C35-4DEF-AFDE-99E85E0F9C46@oracle.com>
 <20190205092256.GN17528@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9158
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902050156
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_130802_509368_EF2E11F3 
X-CRM114-Status: GOOD (  17.46  )
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
 Rahul Yadav <rahul.x.yadav@oracle.com>, mingo@redhat.com,
 Steven Sistare <steven.sistare@oracle.com>, longman@redhat.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

WyBSZXNlbmRpbmcgYWZ0ZXIgY29ycmVjdGluZyBhbiBpc3N1ZSB3aXRoIHRoZSBpbmNsdWRlZCBV
UkwgYW5kIGNvcnJlY3RpbmcgYSB0eXBvIAppbiBXYWltYW7igJlzIG5hbWUg4oCUIHNvcnJ5IGFi
b3V0IHRoYXQhIF0KCj4gT24gRmViIDUsIDIwMTksIGF0IDQ6MjIgQU0sIFBldGVyIFppamxzdHJh
IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj4gCj4gT24gTW9uLCBGZWIgMDQsIDIwMTkg
YXQgMTA6MzU6MDlQTSAtMDUwMCwgQWxleCBLb2dhbiB3cm90ZToKPj4gCj4+PiBPbiBKYW4gMzEs
IDIwMTksIGF0IDU6MDAgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4g
d3JvdGU6Cj4+PiAKPj4+IE9uIFdlZCwgSmFuIDMwLCAyMDE5IGF0IDEwOjAxOjM1UE0gLTA1MDAs
IEFsZXggS29nYW4gd3JvdGU6Cj4+Pj4gQ2hvb3NlIHRoZSBuZXh0IGxvY2sgaG9sZGVyIGFtb25n
IHNwaW5uaW5nIHRocmVhZHMgcnVubmluZyBvbiB0aGUgc2FtZQo+Pj4+IHNvY2tldCB3aXRoIGhp
Z2ggcHJvYmFiaWxpdHkgcmF0aGVyIHRoYW4gYWx3YXlzLiBXaXRoIHNtYWxsIHByb2JhYmlsaXR5
LAo+Pj4+IGhhbmQgdGhlIGxvY2sgdG8gdGhlIGZpcnN0IHRocmVhZCBpbiB0aGUgc2Vjb25kYXJ5
IHF1ZXVlIG9yLCBpZiB0aGF0Cj4+Pj4gcXVldWUgaXMgZW1wdHksIHRvIHRoZSBpbW1lZGlhdGUg
c3VjY2Vzc29yIG9mIHRoZSBjdXJyZW50IGxvY2sgaG9sZGVyCj4+Pj4gaW4gdGhlIG1haW4gcXVl
dWUuICBUaHVzLCBhc3N1bWluZyBubyBmYWlsdXJlcyB3aGlsZSB0aHJlYWRzIGhvbGQgdGhlCj4+
Pj4gbG9jaywgZXZlcnkgdGhyZWFkIHdvdWxkIGJlIGFibGUgdG8gYWNxdWlyZSB0aGUgbG9jayBh
ZnRlciBhIGJvdW5kZWQKPj4+PiBudW1iZXIgb2YgbG9jayB0cmFuc2l0aW9ucywgd2l0aCBoaWdo
IHByb2JhYmlsaXR5Lgo+Pj4+IAo+Pj4+IE5vdGUgdGhhdCB3ZSBjb3VsZCBtYWtlIHRoZSBpbnRl
ci1zb2NrZXQgdHJhbnNpdGlvbiBkZXRlcm1pbmlzdGljLAo+Pj4+IGJ5IHN0aWNraW5nIGEgY291
bnRlciBvZiBpbnRyYS1zb2NrZXQgdHJhbnNpdGlvbnMgaW4gdGhlIGhlYWQgbm9kZQo+Pj4+IG9m
IHRoZSBzZWNvbmRhcnkgcXVldWUuIEF0IHRoZSBoYW5kb2ZmIHRpbWUsIHdlIGNvdWxkIGluY3Jl
bWVudAo+Pj4+IHRoZSBjb3VudGVyIGFuZCBjaGVjayBpZiBpdCBpcyBiZWxvdyBhIHRocmVzaG9s
ZC4gVGhpcyBhZGRzIGFub3RoZXIKPj4+PiBmaWVsZCB0byBxdWV1ZSBub2RlcyBhbmQgbmVhcmx5
LWNlcnRhaW4gbG9jYWwgY2FjaGUgbWlzcyB0byByZWFkIGFuZAo+Pj4+IHVwZGF0ZSB0aGlzIGNv
dW50ZXIgZHVyaW5nIHRoZSBoYW5kb2ZmLiBXaGlsZSBzdGlsbCBiZWF0aW5nIHN0b2NrLAo+Pj4+
IHRoaXMgdmFyaWFudCBhZGRzIGNlcnRhaW4gb3ZlcmhlYWQgb3ZlciB0aGUgcHJvYmFiaWxpc3Rp
YyB2YXJpYW50Lgo+Pj4gCj4+PiAoYWxzbyBoZWF2aWx5IHN1ZmZlcnMgZnJvbSB0aGUgc29ja2V0
ID09IG5vZGUgY29uZnVzaW9uKQo+Pj4gCj4+PiBIb3cgd291bGQgeW91IHN1Z2dlc3QgUlQgJ3R1
bmVzJyB0aGlzPwo+Pj4gCj4+PiBSVCByZWxpZXMgb24gRklGTyBmYWlybmVzcyBvZiB0aGUgYmFz
aWMgc3BpbmxvY2sgcHJpbWl0aXZlczsgeW91IGp1c3QKPj4+IGNvbXBsZXRlbHkgd3JlY2tlZCB0
aGF0Lgo+PiAKPj4gVGhpcyBpcyB0cnVlIHRoYXQgQ05BIHRyYWRlcyBzb21lIGZhaXJuZXNzIGZv
ciBzaG9ydGVyIGxvY2sgaGFuZG92ZXIKPj4gbGF0ZW5jeSwgbXVjaCBsaWtlIGFueSBvdGhlciBO
VU1BLWF3YXJlIGxvY2suCj4+IAo+PiBDYW4geW91IGV4cGxhaW4sIGhvd2V2ZXIsIHdoYXQgZXhh
Y3RseSBicmVha3MgaGVyZT8KPiAKPiBUaW1lbGluZXNzIGd1YXJhbnRlZXMuIEZJRk8tZmFpciBo
YXMgd2VsbCBkZWZpbmVkIHRpbWUgYmVoYXZpb3VyOyB5b3UKPiBrbm93IGV4YWN0bHkgaG93IGxv
bmcgeW91IGdldCB0byB3YWl0IGJlZm9yZSB5b3UgYWNxdWlyZSB0aGUgbG9jaywKPiBuYW1lbHkg
aG93ZXZlciBtYW55IHdhaXRlcnMgYXJlIGluIGZyb250IG9mIHlvdSBtdWx0aXBsaWVkIGJ5IHRo
ZSB3b3JzdAo+IGNhc2Ugd2FpdCB0aW1lLgpHb3QgaXQg4oCUIHRoYW5rcyBmb3IgdGhlIGNsYXJp
ZmljYXRpb24hCgo+IAo+IERvaW5nIHRpbWUgYW5hbHlzaXMgb24gYSByYW5kb21pemVkIGFsZ29y
aXRobSBpc24ndCBteSBpZGVhIG9mIGZ1bi4KPiAKPj4gSXQgc2VlbXMgdGhhdCBldmVuIHRvZGF5
LCBxc3BpbmxvY2sgZG9lcyBub3Qgc3VwcG9ydCBSVF9QUkVFTVBULCBnaXZlbgo+PiB0aGF0IGl0
IHVzZXMgcGVyLUNQVSBxdWV1ZSBub2Rlcy4KPiAKPiBJdCBkb2VzIHdvcmsgd2l0aCBSVCwgY29t
bWl0Ogo+IAo+ICA3YWE1NGJlMjk3NjUgKCJsb2NraW5nL3FzcGlubG9jaywgeDg2OiBQcm92aWRl
IGxpdmVuZXNzIGd1YXJhbnRlZSIpCj4gCj4gaXQgYSBkaXJlY3QgcmVzdWx0IG9mIFJUIG9ic2Vy
dmluZyBmdW5uaWVzIHdpdGggaXQuIEkndmUgbm8gaWRlYSB3aHkgeW91Cj4gdGhpbmsgaXQgd291
bGQgbm90IHdvcmsuCkp1c3QgdHJ5aW5nIHRvIGdldCB0byB0aGUgYm90dG9tIG9mIGl0IOKAlCBh
cyBvZiB0b2RheSwgcXNwaW5sb2NrIGV4cGxpY2l0bHkgYXNzdW1lcwpubyBwcmVlbXB0aW9uIHdo
aWxlIHdhaXRpbmcgZm9yIHRoZSBsb2NrLgoKSGVyZSBpcyB3aGF0IFdhaW1hbiBoYWQgdG8gc2F5
IGFib3V0IHRoYXQgaW4gaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzU2MTc3NToKCiJUaGUgaWRl
YSBiZWhpbmQgdGhpcyBzcGlubG9jayBpbXBsZW1lbnRhdGlvbiBpcyB0aGUgZmFjdCB0aGF0IHNw
aW5sb2NrcwphcmUgYWNxdWlyZWQgd2l0aCBwcmVlbXB0aW9uIGRpc2FibGVkLiBJbiBvdGhlciB3
b3JkcywgdGhlIHByb2Nlc3MKd2lsbCBub3QgYmUgbWlncmF0ZWQgdG8gYW5vdGhlciBDUFUgd2hp
bGUgaXQgaXMgdHJ5aW5nIHRvIGdldCBhCnNwaW5sb2NrLuKAnQoKVGhpcyB3YXMgYmFjayBpbiAy
MDEzLCBidXQgdGhlIGNvZGUgc3RpbGwgdXNlcyBwZXItQ1BVIHF1ZXVlIG5vZGVzLAphbmQgQUZB
SUNULCBwcmVlbXB0aW9uIHdpbGwgYnJlYWsgdGhpbmdzIHVwLgoKU28gd2hhdCB5b3UgYXJlIHNh
eWluZyBpcyB0aGF0IFJUIHdvdWxkIGJlIGZpbmUgYXNzdW1pbmcgbm8gcHJlZW1wdGlvbiBpbgp0
aGUgc3BpbmxvY2sgYXMgbG9uZyBhcyBpdCBwcm92aWRlcyBGSUZPPyBPciB0aGVyZSBpcyBzb21l
IGZ1dHVyZSBjb2RlIHBhdGNoIAp0aGF0IHdpbGwgdGFrZSBjYXJlIG9mIHRoZSDigJxubyBwcmVl
bXB0aW9u4oCdIGFzc3VtcHRpb24gKGJ1dCBzdGlsbCBhc3N1bWUgRklGTyk/CgpUaGFua3MsCuKA
lCBBbGV4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
