Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAE7C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:59:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E20DC20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r1lbPDlW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrqqOaTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20DC20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TY2QV01ICLY4MlH/Yo/KTJ+hwLjnuE3mFohN/fNdg4M=; b=r1lbPDlWG4GR9W
	Dph91WKim1EZuCTXfeZ73+UXEec2QQ0kogSk+QR5uncp859JlgEyqyHo5ra+UuJXQZ28A6ODA1x28
	jP9b4/FXavM8wDPA6fxwsOaRUiAVmGant6V2sc7kY0zTc9iVtqJj9A60e/AxcCvJxhYJYIFFkcRoL
	SMgDIsv9m6nU+ZT5rpK445SUmvBxO+Xk0NICE06kpapu+ZFkaiqGgW2V47S5aqlKPg00PwTpNNv9i
	T33fyODJb0w0wvFaL8A4x0dByVXVj744v7V+uCGdLakadIIzu07mlJSsB8uLLF2IFf0SPlPkap8Te
	MA00dl9ss4tEc55X9aMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZaI-0001ti-BY; Wed, 05 Dec 2018 15:59:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZaF-0001sm-9G
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 15:59:32 +0000
Received: from localhost (unknown [106.201.124.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 51DE920850;
 Wed,  5 Dec 2018 15:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544025560;
 bh=rmDmFM1Bg4XU33mltuunMZWS0Dse78bB8tFhI28Txzg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WrqqOaTxcFIwaxxVzkAkRa337HDalXuSec7bxE3I5x1pOHLYOptKjT8Xu6+YhI1DN
 Fm0p+lhFdUrMGWkPVPCEjYmK7QEC1G8A47UCZYL820l7TDgpnCpMPvZMpSJDYZkLBF
 JkJdaZIAHLa1lsKgr3NR8PY9VX9TBmj04FKv+Z9I=
Date: Wed, 5 Dec 2018 21:29:12 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH] dmaengine: remove DBGFS_FUNC_DECL()
Message-ID: <20181205155912.GP2847@vkoul-mobl>
References: <20181130154249.3222-1-tiny.windzz@gmail.com>
 <20181205082719.GF2847@vkoul-mobl>
 <CAEExFWu1ahDPqKbYWKPY_bQuw=1Kp1gUki+CpQ7Mq5sNNiy_tg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEExFWu1ahDPqKbYWKPY_bQuw=1Kp1gUki+CpQ7Mq5sNNiy_tg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_075931_345016_BCA7742B 
X-CRM114-Status: GOOD (  11.97  )
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
Cc: linux-soc@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, okaya@kernel.org, sudeep.dutt@intel.com,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org,
 ashutosh.dixit@intel.com, David Brown <david.brown@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
 dan.j.williams@intel.com, robert.jarzmik@free.fr, daniel@zonque.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDUtMTItMTgsIDIzOjQ5LCBGcmFuayBMZWUgd3JvdGU6Cj4gT24gV2VkLCBEZWMgNSwgMjAx
OCBhdCA0OjI3IFBNIFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4KPiA+
IE9uIDMwLTExLTE4LCAxMDo0MiwgWWFuZ3RhbyBMaSB3cm90ZToKPiA+ID4gV2UgYWxyZWFkeSBo
YXZlIHRoZSBERUZJTkVfU0hPV19BVFRSSUJVVEUsVGhlcmUgaXMgbm8gbmVlZCB0byBkZWZpbmUK
PiA+ID4gc3VjaCBhIG1hY3JvLHNvIHJlbW92ZSBEQkdGU19GVU5DX0RFQ0wuQWxzbyB1c2UgbWFj
cm8gdG8gc2ltcGxpZnkgc29tZQo+ID4gPiBjb2RlLgo+ID4KPiA+IFNwYWNlcyBhZnRlciBmdWxs
IHN0b3AgYW5kIGNvbW1hIHBsZWFzZQo+ID4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogWWFu
Z3RhbyBMaSA8dGlueS53aW5kenpAZ21haWwuY29tPgo+ID4gPiAtLS0KPiA+ID4gIGRyaXZlcnMv
ZG1hL2FtYmEtcGwwOHguYyAgICAgfCAxNCArKy0tLS0tLS0tLS0tLQo+ID4gPiAgZHJpdmVycy9k
bWEvbWljX3gxMDBfZG1hLmMgICB8IDIyICsrKy0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ID4gIGRy
aXZlcnMvZG1hL3B4YV9kbWEuYyAgICAgICAgfCAyNCArKysrKysrKysrKystLS0tLS0tLS0tLS0K
PiA+ID4gIGRyaXZlcnMvZG1hL3Fjb20vaGlkbWFfZGJnLmMgfCAzMyArKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KPiA+Cj4gPiBEbyB5b3UgbWluZCBzcGxpdHRpbmcgaXQgcGVyIGZp
bGUuCj4gSGkgVmlub2Q6Cj4gCj4gV2h5IG5vdCBhcHBseSBpdCBvbmNlIO+8n1RoZSBjaGFuZ2Ug
aXMgbm90IHRvbyBiaWcuCgpJdCBpcyBub3QgYWJvdXQgYmlnIG9yIHNtYWxsLiBBIHBhdGNoIHNo
b3VsZCBkbyBvbmUgdGhpbmcgYW5kIHRvdWNoIGEKc2luZ2xlIG1vZHVsZS4KCkl0IGFsc28gaGVs
cHMgcGVvcGxlIHdoZW4gdGhleSBsb29rIGF0IGNoYW5nZXMgYW5kIGJhY2twb3J0cy4KCi0tIAp+
Vmlub2QKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
