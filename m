Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E98C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:32:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D82D52184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V14z2QXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82D52184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YK/EKPi3SoogRPsjd+uahaf161C4u7cLtMHLO7ubrLI=; b=V14z2QXzmq5mQh
	WfPetBbwPMPOhpSVc/kh1Oxj5X58X0gdTa32w4UMzoL2NwaNVdEz9Bdtsos/3WXLYq+i/hswBlwsP
	erE7cPc94MrhSNR8fXrnxJsfEabcxcEYm+T6yaYKAgZx7OccbI4UBWlBPzuvYISX6Yk20yMUnN33P
	nKMP06Mvxn96cG4RomcdMtEAFchn64jpUFVchl2fOSLZ2wu8v0uI4ljwZLpaJmO+eiQYytRnQyNv6
	iGz82B6VHVqXf4ZYsm3xQDgwAs+GoQE+NmJuo3+DQDEor3Ue0ga2DiuTwTrKV7hzNVHu5gTPrSjlN
	UsKcjtFnZkF8KFv/XebQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtOoC-00028n-3V; Tue, 12 Feb 2019 03:32:32 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtOo8-00027x-Eg; Tue, 12 Feb 2019 03:32:29 +0000
X-UUID: 46e22817486d40cb99717415b4aa6ec2-20190211
X-UUID: 46e22817486d40cb99717415b4aa6ec2-20190211
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 307154985; Mon, 11 Feb 2019 19:32:19 -0800
Received: from MTKMBS31DR.mediatek.inc (172.27.6.102) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Feb 2019 19:32:18 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Feb 2019 11:32:15 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Feb 2019 11:32:15 +0800
Message-ID: <1549942335.15284.1.camel@mtkswgap22>
Subject: Re: [SPAM][PATCH v3 0/2] PCI: mediatek: enable whole MMIO range and
 enlarge the PCIe2AHB window size
From: Ryder Lee <ryder.lee@mediatek.com>
To: Honghui Zhang =?UTF-8?Q?=28=E5=BC=A0=E6=B4=AA=E8=BE=89=29?=
 <Honghui.Zhang@mediatek.com>
Date: Tue, 12 Feb 2019 11:32:15 +0800
In-Reply-To: <1548999367-11733-1-git-send-email-honghui.zhang@mediatek.com>
References: <1548999367-11733-1-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_193228_500037_55CBE777 
X-CRM114-Status: GOOD (  10.40  )
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
Cc: Youlin Pei =?UTF-8?Q?=28=E8=A3=B4=E5=8F=8B=E6=9E=97=29?=
 <youlin.pei@mediatek.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "poza@codeaurora.org" <poza@codeaurora.org>,
 "fred@fredlawl.com" <fred@fredlawl.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jianjun Wang =?UTF-8?Q?=28=E7=8E=8B=E5=BB=BA=E5=86=9B=29?=
 <Jianjun.Wang@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyMDE5LTAyLTAxIGF0IDEzOjM2ICswODAwLCBIb25naHVpIFpoYW5nICjlvKDmtKro
vokpIHdyb3RlOgo+IEZyb206IEhvbmdodWkgWmhhbmcgPGhvbmdodWkuemhhbmdAbWVkaWF0ZWsu
Y29tPgo+IAo+IFR3byBwYXRjaGVzOgo+IHBhdGNoIDEgZW5hYmxlIHdob2xlIE1NSU8gcmFuZ2Ug
d2hpY2ggYWxzbyBmaXggdGhlIGNvbXBsYWluIG9mIHNjcmlwdHMvY29jY2luZWxsZS9hcGkvcmVz
b3VyY2Vfc2l6ZS5jb2NjaQo+IHBhdGNoIDIgZW5sYXJnZSB0aGUgUENJZTJBSEIgd2luZG93IHNp
emUgdG8gc3VwcG9ydCBmdWxseSBhY2Nlc3Mgb2YgNEdCIERSQU0gZnJvbSBFUCBETUEuCj4gCj4g
djM6Cj4gIC0gdXBkYXRlIHRoZSBjaGFuZ2xvZyB0aXRsZSBmb3IgcGF0Y2gxIGFuZCB1cGRhdGUg
Y29tbWl0IG1lc3NhZ2UgZm9sbG93aW5nIEJqb3JuJ3Mgc3VnZ2VzdGlvbgo+ICAtIG1vdmUgdGhl
ICJ8IiBpbnRvIHRoZSBwcmV2aW91cyBsaW5lLgo+IAo+IHYyOgo+ICAtIEZpeCB0aGUgY2hlY2tw
YXRjaCBjb21wbGFpbnMgZm9yIHBhdGNoIDEuCj4gIC0gdXBkYXRlIHRoZSBjb21taXQgbWVzc2Fn
ZSBhbmQgY2hhbmdlIHRpdGxlIG9mIHBhdGNoIDEgZm9yIGNoYW5nZWxvZyBjb252ZW50aW9ucy4K
PiAgLSBBZGQgcGF0Y2ggMi4KPiAKPiBIb25naHVpIFpoYW5nICgyKToKPiAgIFBDSTogbWVkaWF0
ZWs6IEVuYWJsZSB0aGUgd2hvbGUgbWVtb3J5IG1hcHBlZCBJTyByYW5nZQo+ICAgUENJOiBtZWRp
YXRlazogRW5sYXJnZSBQQ0llMkFIQiB3aW5kb3cgc2l6ZSB0byBzdXBwb3J0IDRHQiBEUkFNCj4g
Cj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jIHwgMTMgKysrKysrKysr
LS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+
IAoKRm9yIHRoZSBzZXJpZXM6CgpBY2tlZC1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0
ZWsuY29tPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
