Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C8DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:05:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A7832082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G3ueFXC1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j5lOUEsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7832082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gVjB7bEs+kZIrM+n37rDz9qpp/UsLwZ9zF4oqWINZ30=; b=G3ueFXC1Idg1ug
	vSB/jKzpiUGgxTPccntWpgoMmgiInRhDZV3w4RYE9x7gRkOMDhwWa4b7vzJRwiM1bOZSH6s0Z2yWq
	H0jXUo+DC0fOZH561mY8xO7Q+zUer8e6bKcJNuzXvGn7Zns1msbV641oEboUJuspOHIBiHDZEcbw2
	C+vY8k2lWyHZP7D+yBdrWzoqDvHgISkqD60V5Jsw74luNqr1Z1v+2yBZZMv9uGvihX7wYx8rSiEt4
	p9SvTG3Rwrn7LspkzfqUv8R71hls4CKEJashE25df4thTVx4XvG/2aFtJD/LbOYa01T1UGAxdvQ6q
	2F8VHzJjZIx1d68I7v1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gToqs-0007hA-Mg; Mon, 03 Dec 2018 14:05:34 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gToqk-0007fi-NL
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 14:05:32 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20181203140514euoutp01d56d63f349e689ebccb184dbd73cf44b~s1638vPae3189031890euoutp01V
 for <linux-arm-kernel@lists.infradead.org>;
 Mon,  3 Dec 2018 14:05:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20181203140514euoutp01d56d63f349e689ebccb184dbd73cf44b~s1638vPae3189031890euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543845914;
 bh=4XTGEwSLqTxYOaFkZGwe6FCXg8g2lq0yX2XPPQZs+kE=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=j5lOUEspNMwTJZLpPQXjj4u7iNA5XBQQSKRJk1fzM9Wq0bSSGQ62jyvF8v25EeKBR
 KPjCJ7rA40R02eNoYw0Ik2/gTM3HEuo/Rgms5kY2kIOQywioKGuWMTxsWTwaq23PM2
 p5yKVLhxlxJXCdBLiZYJErAZLmpqMLUQPKQjQbNY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181203140513eucas1p1d5807c493d4fbe8f07d3ba8b8a9f3576~s163KQ7uE3174631746eucas1p1w;
 Mon,  3 Dec 2018 14:05:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 6D.50.04806.918350C5; Mon,  3
 Dec 2018 14:05:13 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20181203140512eucas1p19d36dff812fd391107d679e180f230cf~s162a71z91445614456eucas1p1h;
 Mon,  3 Dec 2018 14:05:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20181203140512eusmtrp147fc00d887152dfba7092c09d4af13a9~s162KvK1v0748507485eusmtrp1j;
 Mon,  3 Dec 2018 14:05:12 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-92-5c0538199710
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id C1.D4.04128.818350C5; Mon,  3
 Dec 2018 14:05:12 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181203140511eusmtip2d53337947f88fa5271296a6d674f8e92~s161NcpWc3120731207eusmtip2F;
 Mon,  3 Dec 2018 14:05:11 +0000 (GMT)
Subject: Re: [PATCH 3/6] devfreq: add support for suspend/resume of a
 devfreq device
To: Chanwoo Choi <cw00.choi@samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
From: Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <1aaf315b-f262-dad1-0e82-548410d10b5e@partner.samsung.com>
Date: Mon, 3 Dec 2018 15:05:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5BFB3C17.40502@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se1BMcRj1u+8am2uL/eS94w+ZUQjzGxpv5prxB2YYQ6NW3Um0qb2FMCPP
 Qmgw1HrEbJIts6xtrWqLpJ1tS+URQiE0HmuwnsPEXjej/853znfmO2fm40j1KSaUS0xOEw3J
 uiQtE0jZ637cGjsI09Hj7rWH4utlYfhSnoXGVy59pfH9z100Lqi9ReMdJguDG/bp8cHOtyRu
 arrI4sbt71hsPOIksLWzlcZ3yk8w2Le/FuG8pioCX6h9wuKz91sI/GhbMYOf1N/0+z23abzL
 Wcvi3SUfaPyuuZ2aoRHsFXZaKD1VioTjmS2UkHvwExJMla8JwWrewwjVJ0tZ4XLhVqG7jhVs
 97Io4YDNjITikm+s4LMOW6haHhgVLyYlrhcNEdNiA1d/tN0lU86HbXQb85hM1DZiLwrggJ8I
 bstDYi8K5NR8MYJ20ytaFtT8ZwTdBWGK4EOQt6+M+udo6vBSinAOganoGVIGL4LWnJd/7cH8
 Uiiu/M7KQgjvQVBdXcPIA8nvIqH7g80/cBzDh4PDnCobVPw8OFBVRciY4kdB+dU2VsYD+GWQ
 3VHCKDv9wZ3/4m+MAD4M3hdWIBmTvAbaXhQQCh4OO8qOk/It4B9zcO3nIVbJPQcuWtp7cDC8
 cdl68BDwHM7p6SZBY7aZUfAWyHI7enamwg1XCy1nJv2HLeURCj0TXI+crEwDHwQPvP2VCEFw
 yH6MVGgVZO9WK9ujwZbTTCh4IJwrPcrmIq2xVzFjrzLGXmWM/++eRpQZacR0SZ8gSpHJ4oZw
 SaeX0pMTwuPW6a3I/7WebtcXB6r6taoG8RzS9lXNiKGi1bRuvZShr0HAkdoQVUqqn1LF6zI2
 iYZ1MYb0JFGqQYM5SqtRbe7zdIWaT9CliWtFMUU0/FMJLiA0Exmw41NWVH65ZWNL2RR7aHb9
 Q/PdqLmFi2efHop9I7L6dax5vCV2QUxqUdexAScyPEfprabl84sS3COrmyctiW8cSiyY3Nmg
 qXBclqbPcXmtXYN2JvqO1DtzG+oKIxYFjdq+M/h9qzNu1vMb3tw0YcjsCSvv/O7nZM88i34Q
 2XAm8mZfLSWt1o0fQxok3R+H5bCDsQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfO2TlKq9O0fDEoW33IwOm8voaJBMWJgqSii5lz6GmKzunO
 JtkXNVNrXdSQsHmL5XVa5pz3NBpm5GVTKyUvXdAK06SylKBGmyPw2+95/s+PhwceChO2EJ5U
 YoqaVaXIkkV8V3zQ9vytD0REtJ8xexd62uqNmkuaCNTevEKgiZ+fCVTZZyFQzv0mPhq6rkAF
 swsYslofkWj48iKJdMU9PGScHSfQy64yPlq+2QdQibWXhx70zZCoemKUh6ay6/hoZuCZ3R8c
 I1BuTx+J8hq+EWhx5C0e4cG0dbcRTGNFI2BKs0ZxprDgB2DuP57nMUbDNT7zpLyRZFqqMhlb
 P8mYXufjzC2TATB1Dasks2zcHimIEoeplBo165Wg5NT7ReckyF8sCUVi/8BQsSQg5Pw+/yCR
 b3hYPJucmM6qfMNjxQnfTa+w1Hrviy90JfwsMOmlBS4UpAOh9d1XXAtcKSFdDaBFX4Q5g63w
 dm876WQ3+Gdcy3cOLQC4+v4O4Qjc6FNQe+Mv6Qjc6UEAi60DPEeB0bkYnP+qB06lA4NvJhfs
 SyiKT4thhyHNYQvoQ/BWby/PwTi9G3Z1Tq6t20KfgcPzD4FzZjN8cXcOd7AL7Q2XqrrX+hgd
 DCtaPmBO9oCTc5U8J++AOa2lWCEQ6tbpunWKbp2iW6fcA7gBuLMaTiFXcP5iTqbgNClycZxS
 YQT2h2nr/23qANqlE2ZAU0C0QRAhxaOFhCydy1CYAaQwkbsgNc3eEsTLMi6xKqVUpUlmOTMI
 sh9XhHluiVPa3y9FLZUESUJQqCQkICQgGIk8BFa/jCghLZep2SSWTWVV/z0e5eKZBTbFH6/x
 01QpRhRHzaba7Uxn/cbOhj3DJqkc1E/XvLu0UNg/EfxRH5F/weZ5BNR1dedXZflMmYtO2k4f
 CzqYViaNia88XLuUYxvOMazmjnkV0eUrv5IiLWExQ2flv6t9GvK+WLSxmcT0rPsBdcunbVcS
 9dlXd1q8TtQLlm+GW+dEOJcgk+zFVJzsH13OnWxGAwAA
X-CMS-MailID: 20181203140512eucas1p19d36dff812fd391107d679e180f230cf
X-Msg-Generator: CA
X-RootMTR: 20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382@eucas1p1.samsung.com>
 <1542823301-23563-4-git-send-email-l.luba@partner.samsung.com>
 <5BF61B3A.9050402@samsung.com>
 <cce4f194-b574-a12c-e876-f11a6f245940@partner.samsung.com>
 <5BF7419E.90006@samsung.com>
 <734d0941-c885-4d36-274b-23843d6626c1@partner.samsung.com>
 <5BFB3C17.40502@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_060526_900138_9D3D3DC4 
X-CRM114-Status: GOOD (  24.83  )
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
Cc: mark.rutland@arm.com, len.brown@intel.com, tony.luck@intel.com,
 keescook@chromium.org, b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
 anton@enomsg.org, rjw@rjwysocki.net, robh+dt@kernel.org,
 tjakobi@math.uni-bielefeld.de, kyungmin.park@samsung.com,
 myungjoo.ham@samsung.com, kgene@kernel.org, pavel@ucw.cz, ccross@android.com,
 krzk@kernel.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQ2hhbndvbyBDaG9pLAoKT24gMTEvMjYvMTggMToxOSBBTSwgQ2hhbndvbyBDaG9pIHdyb3Rl
Ogo+IEhpIEx1a2FzeiwKPiAKPiBJIGFkZCB0aGUgb25lIG1vcmUgY29tbWVudCBmb3IgZGV2ZnJl
cV9yZXN1bWVfZGV2aWNlKCkKPiAKPiBPbiAyMDE464WEIDEx7JuUIDIz7J28IDE5OjAxLCBMdWth
c3ogTHViYSB3cm90ZToKPj4gSGkgQ2hhbndvbyBDaG9pLAo+Pgo+PiBPbiAxMS8yMy8xOCAxMjo1
NCBBTSwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+Pj4gSGkgTHVrYXN6LAo+Pj4KPj4+IEkgYWRkIG9u
ZSBtb3JlIGNvbW1lbnQgYWJvdXQgZGV2ZnJlcV9yZXN1bWVfZGV2aWNlKCkuCj4+Pgo+Pj4gT24g
MjAxOOuFhCAxMeyblCAyMuydvCAyMDowMCwgTHVrYXN6IEx1YmEgd3JvdGU6Cj4+Pj4KPj4+Pgo+
Pj4+IE9uIDExLzIyLzE4IDM6NTggQU0sIENoYW53b28gQ2hvaSB3cm90ZToKPj4+Pj4gT24gMjAx
OOuFhCAxMeyblCAyMuydvCAwMzowMSwgTHVrYXN6IEx1YmEgd3JvdGU6Cj4+Pj4+PiBUaGUgcGF0
Y2ggYWRkcyBzdXBwb3J0IGZvciBoYW5kbGluZyBzdXNwZW5kL3Jlc3VtZSBwcm9jZXNzLgo+Pj4+
Pj4gSXQgdXNlcyBhdG9taWMgdmFyaWFibGVzIHRvIG1ha2Ugc3VyZSBubyByYWNlIGNvbmRpdGlv
bgo+Pj4+Pj4gYWZmZWN0cyB0aGUgcHJvY2Vzcy4KPj4+Pj4+Cj4+Pj4+PiBUaGUgcGF0Y2ggZHJh
d3Mgb24gVG9iaWFzIEpha29iaSdzIHdvcmsgcG9zdGVkIH4yIHllYXJzIGFnbywgd2hvIHRyaWVk
IHRvCj4+Pj4+PiBzb2x2ZSBpc3N1ZSB3aXRoIGRldmZyZXEgZGV2aWNlJ3MgZnJlcXVlbmN5IGR1
cmluZyBzdXNwZW5kL3Jlc3VtZS4KPj4+Pj4+IER1cmluZyB0aGUgZGlzY3Vzc2lvbiBvbiBMS01M
IHNvbWUgY29ybmVyIGNhc2VzIGFuZCBjb21tZW50cyBhcHBlYXJlZAo+Pj4+Pj4gcmVsYXRlZCB0
byB0aGUgZGVzaWduLiBUaGlzIHBhdGNoIGFkZHJlc3MgdGhlbSBrZWVwaW5nIGluIG1pbmQgc3Vn
Z2VzdGlvbnMKPj4+Pj4+IGZyb20gQ2hhbndvbyBDaG9pLgo+Pj4+Pgo+Pj4+PiBQbGVhc2UgcmVt
b3ZlIHRoZSBkdXBsaWNhdGUgaW5mb3JtYXRpb24gYWJvdXQgcGF0Y2ggaGlzdG9yeS4KPj4+Pj4K
Pj4+Pj4+Cj4+Pj4+PiBTdWdnZXN0ZWQtYnk6IFRvYmlhcyBKYWtvYmkgPHRqYWtvYmlAbWF0aC51
bmktYmllbGVmZWxkLmRlPgo+Pj4+Pj4gU3VnZ2VzdGVkLWJ5OiBDaGFud29vIENob2kgPGN3MDAu
Y2hvaUBzYW1zdW5nLmNvbT4KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEx1a2FzeiBMdWJhIDxsLmx1
YmFAcGFydG5lci5zYW1zdW5nLmNvbT4KPj4+Pj4+IC0tLQo+Pj4+Pj4gICAgIGRyaXZlcnMvZGV2
ZnJlcS9kZXZmcmVxLmMgfCA0NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0KPj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgNiBk
ZWxldGlvbnMoLSkKPj4+Pj4+Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kZXZmcmVxL2Rl
dmZyZXEuYyBiL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMKPj4+Pj4+IGluZGV4IGNmOWM2NDMu
LjdlMDlkZTggMTAwNjQ0Cj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jCj4+
Pj4+PiArKysgYi9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jCj4+Pj4+PiBAQCAtODcyLDE0ICs4
NzIsMzMgQEAgRVhQT1JUX1NZTUJPTChkZXZtX2RldmZyZXFfcmVtb3ZlX2RldmljZSk7Cj4+Pj4+
PiAgICAgICovCj4+Pj4+PiAgICAgaW50IGRldmZyZXFfc3VzcGVuZF9kZXZpY2Uoc3RydWN0IGRl
dmZyZXEgKmRldmZyZXEpCj4+Pj4+PiAgICAgewo+Pj4+Pj4gLQlpZiAoIWRldmZyZXEpCj4+Pj4+
PiAtCQlyZXR1cm4gLUVJTlZBTDsKPj4+Pj4+ICsgICAgICAgIGludCByZXQ7Cj4+Pj4+Cj4+Pj4+
IE1vdmUgJ3JldCcgZGVmaW5pdGlvbiB1bmRlciAnaWYgKGRldmZyZXEtPnN1c3BlbmRfZnJlcSkg
eycKPj4+Pj4gYmVjYXVzZSAncmV0JyBpcyB1c2VkIGlmIHN1c3BlbmRfZnJlcSBpc24ndCB6ZXJv
Lgo+Pj4+IE5vdCBvbmx5IHRoZXJlLCA2IGxpbmVzIGFib3ZlICdyZXQnIGlzIHVzZWQgZm9yCj4+
Pj4gZGV2ZnJlcS0+Z292ZXJub3ItPmV2ZW50X2hhbmRsZXIoKS4KPj4+Cj4+PiBPSy4KPj4+Cj4+
Pj4+Cj4+Pj4+PiArICAgICAgICB1bnNpZ25lZCBsb25nIHByZXZfZnJlcTsKPj4+Pj4+ICsgICAg
ICAgIHUzMiBmbGFncyA9IDA7Cj4+Pj4+PiArCj4+Pj4+PiArICAgICAgICBpZiAoIWRldmZyZXEp
Cj4+Pj4+PiArICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+Pj4+Pj4gKwo+Pj4+Pj4g
KyAgICAgICAgaWYgKGRldmZyZXEtPmdvdmVybm9yKSB7Cj4+Pj4+PiArCQlyZXQgPSBkZXZmcmVx
LT5nb3Zlcm5vci0+ZXZlbnRfaGFuZGxlcihkZXZmcmVxLAo+Pj4+Pj4gKwkJCQkJREVWRlJFUV9H
T1ZfU1VTUEVORCwgTlVMTCk7Cj4+Pj4+PiArCQlpZiAocmV0KQo+Pj4+Pj4gKwkJCXJldHVybiBy
ZXQ7Cj4+Pj4+PiArCX0KPj4+Pj4+ICAgICAKPj4+Pj4+IC0JaWYgKCFkZXZmcmVxLT5nb3Zlcm5v
cikKPj4+Pj4+IC0JCXJldHVybiAwOwo+Pj4+Pj4gKwlpZiAoZGV2ZnJlcS0+c3VzcGVuZF9mcmVx
KSB7Cj4+Pj4+PiArCQlpZiAoYXRvbWljX2luY19yZXR1cm4oJmRldmZyZXEtPnN1c3BlbmRfY291
bnQpID4gMSkKPj4+Pj4+ICsJCQlyZXR1cm4gMDsKPj4+Pj4+ICAgICAKPj4+Pj4+IC0JcmV0dXJu
IGRldmZyZXEtPmdvdmVybm9yLT5ldmVudF9oYW5kbGVyKGRldmZyZXEsCj4+Pj4+PiAtCQkJCURF
VkZSRVFfR09WX1NVU1BFTkQsIE5VTEwpOwo+Pj4+Pj4gKwkJcmV0ID0gZGV2ZnJlcV9zZXRfdGFy
Z2V0KGRldmZyZXEsIGRldmZyZXEtPnN1c3BlbmRfZnJlcSwKPj4+Pj4+ICsJCQkJCSAmcHJldl9m
cmVxLCBmbGFncyk7Cj4+Pj4+Cj4+Pj4+IFJlbW92ZSB0aGUgJ3ByZXZfZnJlcScgcGFyYW1ldGVy
Lgo+Pj4+IE9LCj4+Pj4+Cj4+Pj4+PiArCQlpZiAocmV0KQo+Pj4+Pj4gKwkJCXJldHVybiByZXQ7
Cj4+Pj4+PiArCj4+Pj4+PiArCQlkZXZmcmVxLT5yZXN1bWVfZnJlcSA9IHByZXZfZnJlcTsKPj4+
Pj4KPj4+Pj4gQXMgSSBjb21tZW50ZWQgb24gcGF0Y2gyLCBpZiBkZXZmcmVxX3NldF90YWdldCBz
YXZlIHRoZSBjdXJyZW50IGZyZXF1ZW5jeQo+Pj4+PiB0byAnZGV2ZnJlcS0+cmVzdW1lX2ZyZXEn
LCB0aGlzIGxpbmUgaXMgbm90IG5lZWRlZC4KPj4+PiBPSwo+Pj4+Pgo+Pj4+Pgo+Pj4+Pj4gKwl9
Cj4+Pj4+PiArCj4+Pj4+PiArICAgICAgICByZXR1cm4gMDsKPj4+Pj4+ICAgICB9Cj4+Pj4+PiAg
ICAgRVhQT1JUX1NZTUJPTChkZXZmcmVxX3N1c3BlbmRfZGV2aWNlKTsKPj4+Pj4+ICAgICAKPj4+
Pj4+IEBAIC04OTMsOSArOTEyLDIzIEBAIEVYUE9SVF9TWU1CT0woZGV2ZnJlcV9zdXNwZW5kX2Rl
dmljZSk7Cj4+Pj4+PiAgICAgICovCj4+Pj4+PiAgICAgaW50IGRldmZyZXFfcmVzdW1lX2Rldmlj
ZShzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSkKPj4+Pj4+ICAgICB7Cj4+Pj4+PiArICAgICAgICBp
bnQgcmV0Owo+Pj4+Pgo+Pj4+PiBNb3ZlICdyZXQnIGRlZmluaXRpb24gdW5kZXIgJ2lmIChkZXZm
cmVxLT5zdXNwZW5kX2ZyZXEpIHsnCj4+Pj4+IGJlY2F1c2UgJ3JldCcgaXMgdXNlZCBpZiBzdXNw
ZW5kX2ZyZXEgaXNuJ3QgemVyby4KPj4+PiBPSwo+Pj4KPj4+IElmIHlvdSBjaGFuZ2UgdGhlIGRl
dmZyZXFfcmVzdW1lX2RldmljZSgpIGFjY29yZGluZyB0byBteSBuZXcgY29tbWVudCwKPj4+IHBs
ZWFzZSBpZ25vcmUgaXQuCj4+Pgo+Pj4+Pgo+Pj4+Pj4gKyAgICAgICAgdW5zaWduZWQgbG9uZyBw
cmV2X2ZyZXE7Cj4+Pj4+Cj4+Pj4+IFJlbW92ZSBwcmV2X2ZyZXEgdmFyaWFibGUgd2hpY2ggaXMg
bm90IHVzZWQgb24gdGhpcyBmdW5jdGlvbi4KPj4+Pj4gQWZ0ZXIgY2FsbGluZyBkZXZmcmVxX3Nl
dF90YXJnZXQsIHByZXZfZnJlcSBpcyBub3QgdXNlZC4KPj4+PiBPSwo+Pj4+Pgo+Pj4+Pj4gKyAg
ICAgICAgdTMyIGZsYWdzID0gMDsKPj4+Pj4+ICsKPj4+Pj4+ICAgICAJaWYgKCFkZXZmcmVxKQo+
Pj4+Pj4gICAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4+Pj4+PiAgICAgCj4+Pj4+PiArCWlmIChkZXZm
cmVxLT5zdXNwZW5kX2ZyZXEpIHsKPiAKPiBJbiBkZXZmcmVxX3Jlc3VtZV9kZXZpY2UoKSwgaXQg
c2hvdWxkIGNoZWNrIHRoZSAnZGV2ZnJlcS0+cmVzdW1lX2ZyZXEnCj4gaW5zdGVhZCBvZiAnZGV2
ZnJlcS0+c3VzcGVuZF9mcmVxJy4KT0ssIEkgd2lsbCBmaXggaXQuCgpSZWdhcmRzLApMdWthc3oK
Cj4gCj4gCj4+Pj4+PiArCQlpZiAoYXRvbWljX2RlY19yZXR1cm4oJmRldmZyZXEtPnN1c3BlbmRf
Y291bnQpID49IDEpCj4+Pj4+PiArCQkJcmV0dXJuIDA7Cj4+Pj4+PiArCj4+Pj4+PiArCQlyZXQg
PSBkZXZmcmVxX3NldF90YXJnZXQoZGV2ZnJlcSwgZGV2ZnJlcS0+cmVzdW1lX2ZyZXEsCj4+Pj4+
PiArCQkJCQkgJnByZXZfZnJlcSwgZmxhZ3MpOwo+Pj4+Pgo+Pj4+PiBSZW1vdmUgdGhlICdwcmV2
X2ZyZXEnIHBhcmFtZXRlci4KPj4+PiBPSwo+Pj4+Pgo+Pj4+Pj4gKwkJaWYgKHJldCkKPj4+Pj4+
ICsJCQlyZXR1cm4gcmV0Owo+Pj4+Pj4gKwl9Cj4+Pj4+PiArCj4+Pj4+PiAgICAgCWlmICghZGV2
ZnJlcS0+Z292ZXJub3IpCj4+Pj4+PiAgICAgCQlyZXR1cm4gMDsKPj4+Cj4+PiBQbGVhc2UgY2hh
bmdlIHRoZSBjb2RlIGFzIGZvbGxvd2luZyBiZWNhdXNlIHlvdSB1c2VzIHRoZSBmb2xsb3dpbmcg
dHlwZQo+Pj4gaW4gdGhlIGRldmZyZXFfc3VzcGVuZF9kZXZpY2UoKS4gSWYgdGhlcmUgaXMgYW55
IHNwZWNpYWwgaXNzdWUsIHBsZWFzZQo+Pj4ga2VlcCB0aGUgc2FtZSBmb3JtYXQgaW4gb3JkZXIg
dG8gaW1wcm92ZSB0aGUgcmVhZGFiaWxpdHkuCj4+Pgo+Pj4gCWlmIChkZXZmcmVxLT5nb3Zlcm5v
cikgewo+Pj4gCQlyZXQgPSBkZXZmcmVxLT5nb3Zlcm5vci0+ZXZlbnRfaGFuZGxlcihkZXZmcmVx
LAo+Pj4gCQkJCURFVkZSRVFfR09WX1JFU1VNRSwgTlVMTCk7Cj4+PiAJCWlmIChyZXQpCj4+PiAJ
CQlyZXR1cm4gcmV0Owo+Pj4gCX0KPj4+Cj4+Pgo+PiBPSywgSSB3aWxsIGNoYW5nZSB0aGUgY29k
ZSB0byBrZWVwIHRoZSBzYW1lIGZvcm1hdC4KPj4gVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lgo+
Pgo+PiBSZWdhcmRzLAo+PiBMdWthc3oKPj4KPj4KPj4KPiAKPiAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
