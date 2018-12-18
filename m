Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A786FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:11:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B20218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c7QHcY2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B20218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N297UNPt1o9yr7RnnwB12J87MAtZkSx63ga18ZpTGMY=; b=c7QHcY2C20adpZ
	R/H0K+jbYcMbtPUSMMhZoxZAi3Up6OXVpOcM3TGGYv9LzEhxBmNrV1eubJXPN6p5v6PfH1Xx6aJIx
	NubNLr8b2paDR+m2z6cxQPHjbRtyUslF6iSW43oh5nT/OEWcC9YchqpXUKh7pb8sZ4LwIhFhwGBqQ
	YQEui1U3pzHwGh40arRaPj7kYzqYV6enDO6QDOeiLg6pjF/OPtuQBBnd0X9eS2gG3WKhB0jYcM92j
	R3XB2P8dhMHUukgMS6hTwkQm0mRfdoYaREGo7Y8zOEgHxaPt0AnAcgFerpdZBTems/A2Mn7+jB65O
	fepwN1woMFVKQV36409g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZLhl-0006Co-Q0; Tue, 18 Dec 2018 20:11:01 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZLhb-0005sL-St
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 20:10:58 +0000
Received: from oxbsltgw05.schlund.de ([212.227.220.149]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mn1mb-1hItNY2ChT-00kAKe; Tue, 18 Dec 2018 21:10:31 +0100
Date: Tue, 18 Dec 2018 21:10:30 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Horia Geanta <horia.geanta@nxp.com>
Message-ID: <2071995319.127120.1545163830046@email.ionos.de>
In-Reply-To: <VI1PR0402MB3485A452549CF37694720A7B98BC0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <beb32683-fbd0-fc17-8e71-4f4f51163223@free.fr>
 <VI1PR0402MB3485824A9FB3BC878E7B83D498C60@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <20181213064803.kd7p7fzsegu6nhnl@localhost>
 <1541367377.58314.1544910265605@email.ionos.de>
 <VI1PR0402MB3485A452549CF37694720A7B98BC0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Subject: Re: [PATCH v3 7/9] arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:zKs6KogVMtyI6s8EVuQmT1/aAzgCc1dWI/BgHXOOOq2hHU+ixaQ
 AZy9BJaevHHJaeNiylfcHg2j3aTaqQWmLia+5A7N1oqeXJ7fTPMRySOW9ql9JFwmpYqawOW
 jGMY3Yc5JIvmTyY8Ol2qS6I3nI1jMnXb/xbK7UY1e61Tvy/IOd4Omq6x6w/CwwsQlWNiDWj
 z1l9iXxi6nJVrkqdMDsrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ACpmdDnor00=:OT33SqLoMFLLzgfGbgmEy+
 LLJ+0bpp3g1zvir6EWXWDALxIaL7W5d+6PFB1u5tvY76AzFIR5Y1VzsQ/EKuVI+zkE/cm2POD
 GQfbLl5LjgmD0ob4H92UmfYKd4jbQBPS13nttPzTmVr/q4SAomRkZUjK88qGF/Ig2BR7tdjsa
 rCiq0nB/luEnNU9KA6iWHuURfNTdHzzVYutwjL35ECHH3xPsUIDoP2rE/FEvAbC2yXW70ZWk+
 fxfux/rzXB155Kygs4WHvuLQHz45l2GA6Rr0cA488bjkMzBAKNtbJKOEHyyBlij7uqA67oYfR
 VRo6OohFpLbxKEFWgermrdyMhNNWKpNwgJc8foWHSK38Pnst20MR8X2lUQ8yaaGKvtxI6UmrD
 jAYauY2PRj6ssxAGmVgVfDdLgNeln0Iu+tX9yoJCL+gmoTxdzcOl9Z6sEMlhrFlj60IQJC6FK
 sySpxUM5F86vXopK1Hf7p+ehjO7soWYmFcFds7pUwgnyMLSdR6anSrEGlTmWB+rGYguddUc3v
 MlnN0FaZieQ/tS3vpXw8KpeBVrA7lWX2ER73nqYRBjFyK/zt1xg8jiZvptHIdMi46TFdw8/2q
 TGn35DWaDgGu9OesFEeNNrxchEq/PGIu5zhbwhj/HNeqnXdy1jViNhXxv2lzANuuH1qY1PYdV
 NabF0L8uNC9eczI+V/u2L0UiPgK4QO+ryaYB4LaV/1cDYetIZVAZdYEj/fFQbI20CIgjHvAz/
 /d9NFYlU7lhHxMyvjjisK/Xqp6vGgd7SEhWSFAau6yhkkEMjEAEmYWhWOqPpBd8jD0idPU7xd
 PMmIFE4Idun6x+c2+f87yHKxoqjp/Ck0u7hiGtr5QvESpWXSGR983eHApo3KFTmGHwwoR1q+A
 0oydXexOO8ZbKpW2Pbvw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_121052_466739_C587C953 
X-CRM114-Status: GOOD (  19.50  )
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, arm-soc <arm@kernel.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>, LKML <linux-kernel@vger.kernel.org>,
 linux-next@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSG9yaWEsCgo+IEhvcmlhIEdlYW50YSA8aG9yaWEuZ2VhbnRhQG54cC5jb20+IGhhdCBhbSAx
Ny4gRGV6ZW1iZXIgMjAxOCB1bSAxNjozMyBnZXNjaHJpZWJlbjoKPiAKPiAKPiBPbiAxMi8xNS8y
MDE4IDExOjQ0IFBNLCBTdGVmYW4gV2FocmVuIHdyb3RlOgo+ID4gSGksCj4gPiAKPiA+PiBPbG9m
IEpvaGFuc3NvbiA8b2xvZkBsaXhvbS5uZXQ+IGhhdCBhbSAxMy4gRGV6ZW1iZXIgMjAxOCB1bSAw
Nzo0OCBnZXNjaHJpZWJlbjoKPiA+Pgo+ID4+Cj4gPj4gT24gRnJpLCBOb3YgMDksIDIwMTggYXQg
MDY6MDU6MjRBTSArMDAwMCwgSG9yaWEgR2VhbnRhIHdyb3RlOgo+ID4+PiBPbiAxMS85LzIwMTgg
MzoxMSBBTSwgTWFyYyBHb256YWxleiB3cm90ZToKPiA+Pj4+IENvbW1pdCBlODM0MmNjNzk1NGUg
KCJlbmFibGUgQ0FBTSBjcnlwdG8gZW5naW5lIG9uIFFvcklRIERQQUEyIFNvQ3MiKQo+ID4+Pj4g
ZW5hYmxlZCBDUllQVE9fREVWX0ZTTF9EUEFBMl9DQUFNLCB3aGljaCBkZXBlbmRzIG9uIEZTTF9N
Q19EUElPLAo+ID4+Pj4gd2hpY2ggaXMgbm90IHNldC4gRW5hYmxlIEZTTF9NQ19CVVMsIGFuZCBi
dWlsZCBGU0xfTUNfRFBJTyBhbmQKPiA+Pj4+IENSWVBUT19ERVZfRlNMX0RQQUEyX0NBQU0gYXMg
bW9kdWxlcy4KPiA+Pj4+Cj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXJjIEdvbnphbGV6IDxtYXJj
LncuZ29uemFsZXpAZnJlZS5mcj4KPiA+Pj4gUmV2aWV3ZWQtYnk6IEhvcmlhIEdlYW50xIMgPGhv
cmlhLmdlYW50YUBueHAuY29tPgo+ID4+Cj4gPj4gSSBoYWQgdG8gcmVkbyB0aGlzIG9uZSwgYW5k
IHdoZW4gSSBkaWQgSSBub3RpY2VkIHRoYXQgdGhlcmUncyBhbHNvIGFuIGV0aGVybmV0Cj4gPj4g
ZHJpdmVyLiBTaG91bGQgdGhhdCBiZSBlbmFibGVkIGFzIHdlbGw/Cj4gPj4KPiA+IAo+ID4gdGhp
cyBwYXRjaCBpbiBuZXh0LTIwMTgxMjE0IGJyZWFrcyAibWFrZSBtb2R1bGVzX2luc3RhbGwiIGZv
ciBhcm02NC9kZWZjb25maWcgb24gbXkgVWJ1bnR1IG1hY2hpbmU6Cj4gPiAKPiA+IERFUE1PRCAg
NC4yMC4wLXJjNi1uZXh0LTIwMTgxMjE0Cj4gPiBkZXBtb2Q6IEVSUk9SOiBGb3VuZCA2IG1vZHVs
ZXMgaW4gZGVwZW5kZW5jeSBjeWNsZXMhCj4gPiBkZXBtb2Q6IEVSUk9SOiBDeWNsZSBkZXRlY3Rl
ZDogY2FhbWFsZ19kZXNjIC0+IGRwYWEyX2NhYW0gLT4gYXV0aGVuYwo+ID4gZGVwbW9kOiBFUlJP
UjogQ3ljbGUgZGV0ZWN0ZWQ6IGNhYW1hbGdfZGVzYyAtPiBkcGFhMl9jYWFtIC0+IGZzbF9tY19k
cGlvCj4gPiBkZXBtb2Q6IEVSUk9SOiBDeWNsZSBkZXRlY3RlZDogZHBhYTJfY2FhbSAtPiBjYWFt
aGFzaF9kZXNjIC0+IGRwYWEyX2NhYW0KPiA+IGRlcG1vZDogRVJST1I6IEN5Y2xlIGRldGVjdGVk
OiBjYWFtYWxnX2Rlc2MgLT4gZHBhYTJfY2FhbSAtPiBjYWFtaGFzaF9kZXNjIC0+IGVycm9yCj4g
PiBkZXBtb2Q6IEVSUk9SOiBDeWNsZSBkZXRlY3RlZDogY2FhbWFsZ19kZXNjIC0+IGRwYWEyX2Nh
YW0gLT4gY2FhbWhhc2hfZGVzYyAtPiBjYWFtYWxnX2Rlc2MKPiA+IAo+ID4gQWZ0ZXIgcmV2ZXJ0
aW5nIG9mIHRoaXMgcGF0Y2ggdGhlIGlzc3VlIGRpc2FwcGVhcmVkLgo+ID4gCj4gU2VlbXMgdGhl
cmUncyBhIGRlcGVuZGVuY3kgY3ljbGUgYi93IGRwYWEyX2NhYW0gYW5kIGNhYW17YWxnLGhhc2h9
X2Rlc2MsIGFzIGZvbGxvd3M6Cj4gCj4gQS0+Qgo+IC0tLQo+IGRwYWEyX2NhYW0gbmVlZHMgY25z
dHJfKiBleHBvcnRlZCBieSBjYWFte2FsZyxoYXNofV9kZXNjCj4gCj4gQi0+QQo+IC0tLQo+IGNh
YW17YWxnLGhhc2h9X2Rlc2MgbmVlZCBjYWFtX2lteCwgY2FhbV9saXR0bGVfZW5kOgo+IGNhYW17
aGFzaCxhbGd9X2Rlc2MuYwo+IAktLT4gZGVzY19jb25zdHIuaCAoaW5jbHVkZWQgZm9yIGRlc2Ny
aXB0b3JzIGdlbmVyYXRpb24gZnVuY3Rpb25zKQo+IAkJLS0+IHJlZ3MuaCAoaW5jbHVkZWQgZm9y
IGVuZGlhbm5lc3MgaGVscGVycykKPiAJCQktLT4gZXh0ZXJuIGJvb2wgY2FhbV9pbXgsIGNhYW1f
bGl0dGxlX2VuZAo+IGNhYW1faW14LCBjYWFtX2xpdHRsZV9lbmQgYXJlIGV4cG9ydGVkIGJ5IGRw
YWEyX2NhYW0gLSBjYWFtYWxnX3FpMi5jICh3aGVuCj4gQ09ORklHX0NSWVBUT19ERVZfRlNMX0NB
QU09bikKPiAKPiBDb3VsZCB3ZSBkcm9wIHRoaXMgcGF0Y2gsIHVudGlsIENBQU0gZHJpdmVyIGdl
dHMgYSBwcm9wZXIgZml4ICh3aGljaCBpcyBub3QKPiBzdHJhaWdodGZvcndhcmQpPwoKdGhpcyBp
c3N1ZSBzdGlsbCBwZXJzaXN0cyBpbiA0LjIwLjAtcmM3LW5leHQtMjAxODEyMTguIENvdWxkIHlv
dSBwbGVhc2Ugc2VuZCBhIHBhdGNoIHRvIHJldmVydCB0aGlzIGNoYW5nZT8KClRoYW5rcyBTdGVm
YW4KCj4gCj4gVGhhbmtzLAo+IEhvcmlhCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAo+IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
