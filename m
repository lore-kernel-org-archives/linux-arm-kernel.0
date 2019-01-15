Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB69C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:12:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C75020657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d1viaEQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C75020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QF/ZFiv7EcrwqHoayVAEOvxxiMwd1ZSNXGPO7RoV278=; b=d1viaEQjhNfwNL
	VXu49LBrtCQ+/l10u/AJtNuVmrNjdzwPUrPahpn8imxlbXsbQaQ/DNfwi8cCnGqLIhYq7gSetvKtK
	8CoPNgZe5eBpg8bhNBkjCCwi3PuWYIxbQxgIv6B3eceXe+dKA+UlVdJa7T9SG5ynczU6kh3sgSCn9
	vg6mDhrL57WiPuiJHrdUTF1PQWd9zPw0Dd4/AZA7mOtCOfT9GSnnZAMM/fpKuMHhg8I3Slq+eB/YU
	ty44dNLkzsy3DB/6k2ndykAMFR/WoEvNYVSYaFYcb15rUcUV8rf539IlK8GuqdB4OWY8YE+TcncLz
	Y/2oGiUuIGlHBWXPZ6Dg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjV4P-0007yK-DC; Tue, 15 Jan 2019 20:12:21 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjV4L-0007xt-Ng
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 20:12:19 +0000
Received: by mail-oi1-f196.google.com with SMTP id x202so3123520oif.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 12:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Oo0yDiKlwDpBMxgdXBAyphrmV6UFJofSxQQoWi6bsMo=;
 b=ISrvd2iSsp2D75jGE/kHDcoR7J63z/1AnT5TF/S4iuhtHzAwCiVZ9iqxGwYwBYv6/B
 hJ2u0j4qbTjA8L0S0kLku8JYGzUHddFCJu1LHlNBiUnmKCGX5DkX6fNi2M2pwEK58nfp
 OD847JojkMcfwMV+Pyzf/RSxjeQN8LQETIIZ7eCba9VMnUGZDx6AyXXMA/g8jjA70gSX
 DZtQfVm9ymw+EWj/Oce4wq13R7eB9DoSpi1ahaRoClSWUoxeYoyeAoJnK1i1mNTB3+Ci
 DINYjoy3musBVqIFyiGr7knSqdfqj/FXan5L+trMXXs++Tmrn/WMDu+Qn32qK+2fFLRD
 Rvag==
X-Gm-Message-State: AJcUukd8KGewO81PTswoCZRBaqJ4iGrodZMA3+rcJ79wOvbdjpos7DYb
 /D0ohY5UeRdtCLGPG7cKxg==
X-Google-Smtp-Source: ALg8bN4Fd70PWZsf7kOAXtOqt/WAeoM01C2gZjvvv0bphBoEttFMAKWCwxUFFuS2Z7VErYbwYQTDYw==
X-Received: by 2002:aca:b184:: with SMTP id a126mr2940293oif.187.1547583136717; 
 Tue, 15 Jan 2019 12:12:16 -0800 (PST)
Received: from localhost ([70.231.7.113])
 by smtp.gmail.com with ESMTPSA id c9sm1730816otp.24.2019.01.15.12.12.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 15 Jan 2019 12:12:15 -0800 (PST)
Date: Tue, 15 Jan 2019 14:12:15 -0600
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Subject: Re: [PATCH shawn/for-next v4 2/2] ARM: dts: imx: Add Y Soft IOTA
 Draco,  Hydra and Ursa boards
Message-ID: <20190115201215.GA32682@bogus>
References: <1547562139-64730-1-git-send-email-michal.vokac@ysoft.com>
 <1547562139-64730-2-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547562139-64730-2-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_121217_779285_704933B3 
X-CRM114-Status: GOOD (  15.92  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>,
 Andrew Lunn <andrew@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAxNSBKYW4gMjAxOSAxNDoyMjo0NSArMDAwMCwgPT91dGYtOD9CP1ZtOXJ3NkhFalNC
TmFXTm9ZV3c9Pz0gd3JvdGU6Cj4gVGhlc2UgYXJlIGkuTVg2Uy9ETCBiYXNlZCBTQkNzIGVtYmVk
ZGVkIGluIHZhcmlvdXMgWSBTb2Z0IHByb2R1Y3RzLgo+IEFsbCBzaGFyZSB0aGUgc2FtZSBib2Fy
ZCBkZXNpZ24gYnV0IGhhdmUgc2xpZ2h0bHkgZGlmZmVyZW50IEhXCj4gY29uZmlndXJhdGlvbi4K
PiAKPiBVcnNhCj4gLSBpLk1YNlMgU29DLCA1MTJNQiBSQU0gRERSMywgNEdCIGVNTUMsIG1pY3Jv
U0QKPiAtIHBhcmFsbGVsIFdWR0EgNyIgTENEIHdpdGggdG91Y2ggcGFuZWwKPiAtIDF4IEV0aCAo
UUNBODMzNCBzd2l0Y2gpCj4gLSBVU0IgT1RHCj4gLSBVU0IgaG9zdCAobWljcm8tQikKPiAKPiBE
cmFjbwo+IC0gaS5NWDZTIFNvQywgNTEyTUIgUkFNIEREUjMsIDRHQiBlTU1DLCBtaWNyb1NECj4g
LSBwYXJhbGxlbCBXVkdBIDciIExDRCB3aXRoIHRvdWNoIHBhbmVsCj4gLSAyeCBFdGggKFFDQTgz
MzQgc3dpdGNoKQo+IC0gVVNCIE9URwo+IC0gVVNCIGhvc3QgKG1pY3JvLUIpCj4gLSBSR0IgTEVE
IChJMkMgTFA1NTYyKQo+IC0gMy41bW0gYXVkaW8gamFjayArIGNvZGVjIChMTTQ5MzUwKQo+IAo+
IEh5ZHJhCj4gLSBpLk1YNkRMIFNvQywgMkdCIFJBTSBERFIzLCA0R0IgZU1NQywgbWljcm9TRAo+
IC0gSTJDIE9MRUQgZGlzcGxheSwgY2FwYWNpdGl2ZSBtYXRyaXgga2V5cwo+IC0gMnggRXRoIChR
Q0E4MzM0IHN3aXRjaCkKPiAtIFVTQiBPVEcKPiAtIFJHQiBMRUQgKEkyQyBMUDU1NjIpCj4gLSAz
LjVtbSBhdWRpbyBqYWNrICsgY29kZWMgKExNNDkzNTApCj4gLSBIRE1JCj4gLSBtaW5pUENJZSBz
bG90Cj4gCj4gQ2M6IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4KPiBTaWduZWQtb2ZmLWJ5
OiBNaWNoYWwgVm9rw6HEjSA8bWljaGFsLnZva2FjQHlzb2Z0LmNvbT4KPiAtLS0KPiBDaGFuZ2Vz
IHNpbmNlIHYzOgo+ICAtIERvIG5vdCBhYmJyZXZpYXRlIHJlZ3VsYXRvciB3b3JkIGluIG5vZGUg
bmFtZXMuIChTaGF3bikKPiAgLSBTb3J0IGZpeGVkIHJlZ3VsYXRvciBub2RlcyBhbHBoYWJldGlj
YWxseS4KPiAgLSBTb3J0IHBtaWMgcmVndWxhdG9yIGNoaWxkZSBub2RlcyBhbHBoYWJldGljYWxs
eS4KPiAgLSBVc2UgbmV3bGluZSBiZXR3ZWVuIHByb3BlcnRpZXMgYW5kIGNoaWxkIG5vZGUgaW4g
c3dpdGNoIG5vZGUuIChTaGF3bikKPiAgLSBTb3J0IGkyYyBidXMgY2hpbGQgbm9kZXMgaW4gb3Jk
ZXIgb2YgdW5pdC1hZGRyZXNzLiAoU2hhd24pCj4gIC0gUmVuYW1lIFBXTSBwaW5jdGwgbGFiZWwg
dG8gYmUgY29uc2lzdGVudCB3aXRoIG5vZGUgbmFtZS4gKFNoYXduKQo+IAo+IENoYW5nZXMgc2lu
Y2UgdjI6Cj4gIC0gUmVtb3ZlIGNwdXMgey9kZWxldGUtbm9kZS8gY3B1QDE7fTsgbm9kZSBmcm9t
IGkuTVg2U29sbyBiYXNlZCBib2FyZC4gKEZhYmlvKQo+ICAtIFVzZSAiZGV2aWNlX3R5cGUgPSAi
bWVtb3J5IjsiIGluIG1lbW9yeSBub2Rlcy4gKEZhYmlvKQo+ICAtIFVzZSBHUElPX0FDVElWRV9M
T1cgZm9yIGZlYyBwaHktcmVzZXQtZ3Bpb3MuIChGYWJpbykKPiAgLSBVc2UgIi0iIGluIG5vZGUg
bmFtZXMuIChSb2IpCj4gIC0gUmVtb3ZlIGxhYmVsIGZyb20gbGVkLWNvbnRyb2xsZXIgbm9kZS4g
KFJvYikKPiAgCj4gQ2hhbmdlcyBzaW5jZSB2MToKPiAgLSBFbmFibGUgSERNSSBvbiBIeWRyYSBi
b2FyZC4KPiAgLSBNb3ZlIHJlZ3VsYXRvcnMgdG8gdGhlIHJvb3Qgbm9kZSBhbmQgcmVtb3ZlIHNp
bXBsZS1idXMgcHJvcGVydHkuIChSb2IpCj4gIC0gUmVtb3ZlIHJlZyBhbmQgdW5pdC1hZGRyZXNz
IHByb3BlcnR5IGZyb20gcmVndWxhdG9ycy4gKFJvYikKPiAgLSBVc2UgY29ycmVjdCBuYW1lcyBm
b3IgbGVkLWNvbnRyb2xsZXIgYW5kIHBtaWMgbm9kZS4gKFJvYikKPiAgLSBVc2Ugd2FrZXVwLXNv
dXJjZSBpbnN0ZWFkIG9mIGRlcHJlY2F0ZWQgZW5hYmxlLXNkaW8td2FrZXVwLiAoU2hhd24pCj4g
Cj4gIGFyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICAgMyArCj4g
IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZkbC15YXBwNC1jb21tb24uZHRzaSB8IDU5NSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwo+ICBhcmNoL2FybS9ib290L2R0cy9pbXg2ZGwteWFwcDQt
ZHJhY28uZHRzICAgfCAgNTggKysrCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZkbC15YXBwNC1o
eWRyYS5kdHMgICB8ICA1MCArKysKPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NmRsLXlhcHA0LXVy
c2EuZHRzICAgIHwgIDU0ICsrKwo+ICA1IGZpbGVzIGNoYW5nZWQsIDc2MCBpbnNlcnRpb25zKCsp
Cj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9pbXg2ZGwteWFwcDQtY29t
bW9uLmR0c2kKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZkbC15
YXBwNC1kcmFjby5kdHMKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZkbC15YXBwNC1oeWRyYS5kdHMKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3Qv
ZHRzL2lteDZkbC15YXBwNC11cnNhLmR0cwo+IAoKUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxy
b2JoQGtlcm5lbC5vcmc+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
