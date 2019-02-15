Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6573CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:08:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A6B2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hMri17g9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=openedev.com header.i=@openedev.com header.b="fZxUwoR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A6B2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=openedev.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2hr3LU987SktD78bwUIBPzoa6+DNjcaRhpyidMuf6cc=; b=hMri17g90e1EHuvgC/OdLefhW
	k+3s5nFYVB8S+pL2LQIRDFSUVpHQyLi4r9zlAEzCZzq6wQVdQu6LeS9snEAdmbUTpfS37kHCKrW5H
	hH9RgAKZVT+58u7frRzbJLHfmRiQYR/Z/DeRsEhkejwR1L4DbOfllskNiyXXedepmUM41vk+o96l2
	esQngoJWRgM8viwtD3/6pNInXoe/RmW2e0qeY54R0dZ9vJh9iOAHwoNC4vjO8hgzY5WES6sZfrodk
	FdNghVYGqpdbWXUU92JuLV5LUtkDriPHfNCCDNpOXQ0pRoK6pS3A5T9TLUsRL4ko/lZDTA/WSkNQ3
	B3l+zIW/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugy6-0001dq-Pb; Fri, 15 Feb 2019 17:08:06 +0000
Received: from se14t.web-hosting.com ([162.255.118.155])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugy3-0001dG-RD
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 17:08:05 +0000
Received: from [68.65.123.203] (helo=server153.web-hosting.com)
 by se14.registrar-servers.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jagan@openedev.com>)
 id 1gugxu-0008eM-NQ; Fri, 15 Feb 2019 09:07:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=openedev.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0FO+3U5/R/kwZVYyxaFECfYxL1KcCsz8LoEiQs9DZ/k=; b=fZxUwoR8lmnRKfgcVHRcHxuyfB
 KUQf36hgTEh1Yny4CvaZv4Rrhr88MaLCkm+5z6hLcbX12QmqcVF0tJWPesPJQlMC6doufSnwBzT5u
 i70uZz+dXQq5DXr121ttZ7162QjqVrOD4Vm6IrvhVDMyvQdyySMilZ6jb0Y+PZ7C+l3EQJPR1z2pf
 EbwexNZj3sZzrLiauCl55/NkgPAIp5jQsV3DKpERjH9fwMae6HljuhtA+erZFRVA/g1ELq6EXOH+T
 DhbDHrgKBVI5zF9R1ivKL0nHcd3XOPL5XJNzSCS4rXLoK0DKMHpfCTbWTJoinCLneDYZqdjjR63p8
 EZ9ZSTVQ==;
Received: from [115.97.184.151] (port=54690 helo=[192.168.0.10])
 by server153.web-hosting.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <jagan@openedev.com>)
 id 1gugxl-001FSL-Lt; Fri, 15 Feb 2019 12:07:46 -0500
Subject: Re: [PATCH v3 0/8] drm/sun4i: dsi: Add burst mode support
To: Maxime Ripard <maxime.ripard@bootlin.com>
References: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
 <20190215141244.5jrrqkykna6enbtp@flea>
 <CAMty3ZAA90-fHPADJSE3ht9CiYWA3yBoyEy7wVv9=6C5JiaTVw@mail.gmail.com>
From: Jagan Teki <jagan@openedev.com>
Message-ID: <c46cd50a-3695-ebc8-0cd4-4ddc27fc353b@openedev.com>
Date: Fri, 15 Feb 2019 22:37:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMty3ZAA90-fHPADJSE3ht9CiYWA3yBoyEy7wVv9=6C5JiaTVw@mail.gmail.com>
Content-Language: en-US
X-OutGoing-Spam-Status: No, score=-1.0
X-Originating-IP: 68.65.123.203
X-SpamExperts-Domain: nctest.net
X-SpamExperts-Username: whmcalls3
Authentication-Results: registrar-servers.com;
 auth=pass (login) smtp.auth=whmcalls3@nctest.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.19)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5h8x8FAq/g0x+syUkusDCEV602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1sq48bE3uioY4Ys/ZPCDYPM24OD2qGt6TVUNM5e7f/llcIFypKUowh9t+MG6DS4MPE6
 oOmVc/t7yiP0OWhwYvD9XUdslZpdp+Px4yk+XmIlo4NudP3mk40QL/IeUdpn6Rnq/5LD6I3Rso2I
 1E66f671IzHws91ROPZiS5yRkSIjrtyy7k4695/fxkzEz8p7DGB07n5NqAnUcKzSfG77X4C9XZBN
 IfD5z8UHWNRk/ZlwOib+DGaBzdagfPMMbOILgAcBxSBCJ5TwgG6VOtkB2WzUaqVBmBHc9hKwA0t8
 RMmPhnbmXberQLRoM9oW/rpXeCzjRHgVCJX8riPc8/vgCQsZ0nD2B409c4bGXUtZlBIymuDGRycr
 IKPY7o8svDBPl95+OcDAquTEPCvkhtNu8xlOFaaUE6yniVHh7shcZCcb8U54yHbe0U2Q73dIPYtL
 RUypPWFefuWly7OfGYsjedvPKKZsbnOB9noa7PJ6v1+oxqqi6tZqnz+K07+Y9g+WjqvqtVz40oGA
 q5yAb0xXvJpzVSQaqOxyLIgt6sTDwVcWcL0nxN/HQUM9QMlTkrnxBmsf+ISDN/OacxcEjAyh4+g4
 ltPn/JBgX2CDl4r4VMvWrw8e39nPLD6REvE2LPoYp2pNZuMl2RpFrF/ORCBqH7EGtpV0foUL7ai8
 FSlqJ3s5/4Uebg8/NyDnGGFlWhTzBvDk3+iNqiYKhZaJO2iXygjyoWJlG7N1jAeg+Bt/mK8jB3YT
 Tz55JupqLpZ+HAgn6NWsjocvDeFUumCsV5gxkCn74O4hBSz/kkmPgL+fgIgu1L5nMJ5NEo/eaKmq
 PO7TIg4NrMjsQ2SFFNNd9/l7JlD9ITENni6dVKRQmBonIcEIGOSNgfdIpVGmQSezo1hfgyvmPSBZ
 jSkKPeibYW+TQOQK89AWRRjlzHHwMjtVtq9sdzTagsn+mJVvojSg4RGQbvdjzQ6YC7Heg3Xf7O1T
 Od7UqWlc9czPPRm9aw8osdsREcVp+XxAWYBXoWaWjSO68cE9Bouc+GoVz9SxFFaYf5N3S1M3IJWJ
 KOb6MbzZN6d24LNVdBS4HJKdw/12TH0eLGAljMHWoeZpvlvjvAEkZdNpRyzO0C1O0jEtHj7VIEV3
 /uXxzYoJ8a18Eh7RbX72ELoKEhIiCsKLUk6aZEAxE+C2eM9+SqlgTB1X1nm3G7nD1fY1k3iAejCg
 rmRccvYQrW9iWbb3ZaFSDItBiOciPLoRfFXunBd0agpCLXWztnUj
X-Report-Abuse-To: spam@se16.registrar-servers.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_090803_880547_92001716 
X-CRM114-Status: GOOD (  18.71  )
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
Cc: bbrezillon@kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Sean Paul <seanpaul@chromium.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTWF4aW1lLAoKT24gMTUvMDIvMTkgODoxMCBQTSwgSmFnYW4gVGVraSB3cm90ZToKPiAKPiAK
PiBPbiBGcmksIDE1IEZlYiwgMjAxOSwgNzo0MyBQTSBNYXhpbWUgUmlwYXJkLCA8bWF4aW1lLnJp
cGFyZEBib290bGluLmNvbSAKPiA8bWFpbHRvOm1heGltZS5yaXBhcmRAYm9vdGxpbi5jb20+PiB3
cm90ZToKPiAKPiAgICAgT24gTW9uLCBGZWIgMTEsIDIwMTkgYXQgMDM6NDE6MjFQTSArMDEwMCwg
TWF4aW1lIFJpcGFyZCB3cm90ZToKPiAgICAgID4gSGksCj4gICAgICA+Cj4gICAgICA+IEhlcmUg
aXMgYSBzZXJpZXMgaW1wbGVtZW50aW5nIHRoZSBidXJzdCBtb2RlIHN1cHBvcnQgZm9yIERTSS4K
PiAgICAgID4KPiAgICAgID4gSXQncyBiZWVuIHRlc3RlZCBvbiBhbiBBMzMgYm9hcmQgd2l0aCB0
aGUgcGFuZWwgc3VwcG9ydGVkIG9uIHRoZSBsYXN0Cj4gICAgICA+IHBhdGNoLCB3aGljaCBzaG91
bGQgcmVtb3ZlIGFsbCBxdWlya3MgZHVlIHRvIGEgZGlmZmVyZW50IFNvQyBmcm9tIHRoZQo+ICAg
ICAgPiBlcXVhdGlvbi4KPiAKPiAgICAgSSBzaG91bGQgaGF2ZSBzZW50IHRoYXQgbWFpbCB5ZXN0
ZXJkYXksIGJ1dCBwYXRjaGVzIDEtNCBhbmQgNi03IHdlcmUKPiAgICAgbWVyZ2VkLiBQYXRjaCA1
IHdhcyBkaXNjYXJkZWQgc2luY2UgaXQgd2FzIG5vdCBjb25zaXN0ZW50IHdpdGggdGhlCj4gICAg
IHJlc3Qgb2YgdGhlIGRyaXZlciwgYW5kIDggaGFkIHNvbWUgY29tbWVudHMuCj4gCj4gCj4gQXJl
IHRoZSBhcHBsaWVkIHBhdGNoZXMgZnJvbSB0aGlzIHNlcmllcyBvciBmcm9tIG15IHY3IHNlcmll
cz8KPiAKPiAgwqBXb3VsZCB5b3UgcGxlYXNlIHBvaW50IG1lIHRoZSBicmFuY2guCj4gCgpVbmZv
cnR1bmF0ZWx5IG15IGxhc3QgbWFpbCBkaWRuJ3QgcmVhY2ggYXJtIG1haWxpbmcgbGlzdC4KCkp1
c3Qgd2FudGVkIHRvIGtub3cgYXJlIHRoZSBhcHBsaWVkIHBhdGNoZXMgZnJvbSB0aGlzIHNlcmll
cyBvciBmcm9tIG15IAp2NyBzZXJpZXM/IFdvdWxkIHlvdSBwbGVhc2UgcG9pbnQgbWUgdGhlIHJl
cG8sIEkgY291bGRuJ3QgZmluZCBpdCBvbgpnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvc3VueGkvbGludXguZ2l0CgpKYWdhbi4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
