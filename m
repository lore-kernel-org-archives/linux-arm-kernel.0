Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8927CC282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:10:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE38214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cY38oKhf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fBbfxhS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE38214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rWODD2r/E55C7aqaxz/73ix4yBZ4+tmqKfCuxneow8w=; b=cY38oKhfOHfgR9
	UUIxOjmC/yQsJm5Ni8DGst6WHn5uK/XTrqkV2uigTKdZKdx18uSceaH/cuju+QYDIDr3NxYDiiKYf
	YsU3pPYq7EcCgYCl9VzDLQpuegh/qSti3v3hozEPFm6VEAVjYNXdNsdvRIjdu/6nFNK6o6M00pA5O
	ZGJ+sBlIfSAla0TcxhEYdmLI/dWxDMm5a2TyW2gKpa5zx9RwGK/f7abyZ9wvUiWYfx5AgE3Vcrz4O
	jMSHICnxmqHagM6ccROZlpdorUw18VZVDX1XgMKGuAUV74tZKrtA9HTIQMagFkr2X4tDf1/MFoC/x
	bUegR6adA4XcjwbKtzOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glVad-0001vb-FM; Mon, 21 Jan 2019 09:09:55 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glVaa-0001v9-3l
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 09:09:53 +0000
Received: by mail-oi1-x243.google.com with SMTP id v6so13987318oif.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 01:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MbxvX/AkJ3wQ59hS4IMAvv/9UKU2g7OluU2n+zsp7MY=;
 b=fBbfxhS1gG2iO5wnoOR9EILcuAAHPLx5n3A2TE+QsXVm8IBa9G3/m0Quez8GRWyvTf
 i6P07S59zzTO4kYQRZvU1B54rGyrUUzr83hYDW+tr2RfJKIMQRqgxaC20DybPwAYKcKM
 fKKnhcD8QoH2owgnU3q/r2vm5gpmbebQ7voDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MbxvX/AkJ3wQ59hS4IMAvv/9UKU2g7OluU2n+zsp7MY=;
 b=uE2q0WB0Qiy+GFg1fA99P+wMuNAdJ5oFIkgQ2qkU5/6YjYTbEAiCuQX6RQKd18WRcu
 bJJWdNX3qOddxsKAc5LbiwFwIyVCV1L4+e56ruUuNDuzs6ZsAnn40nN+Ps63OpAe2QjI
 DabKKtqNvm3RCCfBEQVSAyBtacYZuFiY0BIBQYkTlxSd0H3USEPqMmZGK0OTcpJshPL6
 5khQisWdY7rlH45cwuuUeMmNquNaDl48qtNIWXnL5YiSuSIRjrkPP5+PqgZ50RzTdbjt
 gGJqR7I+YufTcdJTfSgE839ah+5C5nJ7J2op4D1u2pbF7kaUhmmL0Nm45/WHQYKhMRUy
 NgJg==
X-Gm-Message-State: AJcUukeSw6tU+w7hMi4IiniE3m/TxJDvGSUwyNizVgi+QG2L4GZvCJQP
 oCOFy9LcFmw/EVFnrEZgh+pe8cg88BudZfHw0CV9QQ==
X-Google-Smtp-Source: ALg8bN7Tr+KGqknXoZpqS9FENJsQcfIG1Ng1e0aXG8CMYgJoLBE8RJywzzdx5f84zkVsOi0jqs4rswMITqp1+trPFWY=
X-Received: by 2002:aca:f103:: with SMTP id p3mr4949822oih.94.1548061790765;
 Mon, 21 Jan 2019 01:09:50 -0800 (PST)
MIME-Version: 1.0
References: <1538131180-34108-1-git-send-email-yuehaibing@huawei.com>
 <1548059241-148022-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1548059241-148022-1-git-send-email-yuehaibing@huawei.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Mon, 21 Jan 2019 10:09:39 +0100
Message-ID: <CA+M3ks6Q+hU9jjAbu6qkMqb0knALbBYonS0kRjyFQd_gcSgE=A@mail.gmail.com>
Subject: Re: [PATCH -next] drm/stm: ltdc: remove set but not used variable
 'src_h'
To: YueHaibing <yuehaibing@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_010952_202838_F1952052 
X-CRM114-Status: GOOD (  13.39  )
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
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
 kernel-janitors@vger.kernel.org, Philippe Cornu <philippe.cornu@st.com>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Yannick Fertre <yannick.fertre@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Vincent Abriou <vincent.abriou@st.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Alexandre Torgue <alexandre.torgue@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TGUgbHVuLiAyMSBqYW52LiAyMDE5IMOgIDA5OjIxLCBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1
YXdlaS5jb20+IGEgw6ljcml0IDoKPgo+IEZpeGVzIGdjYyAnLVd1bnVzZWQtYnV0LXNldC12YXJp
YWJsZScgd2FybmluZzoKPgo+IGRyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jOiBJbiBmdW5jdGlv
biAnbHRkY19wbGFuZV9hdG9taWNfY2hlY2snOgo+IGRyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5j
OjY5NDoxMzogd2FybmluZzoKPiAgdmFyaWFibGUgJ3NyY195JyBzZXQgYnV0IG5vdCB1c2VkIFst
V3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQo+ICAgdTMyIHNyY194LCBzcmNfeSwgc3JjX3csIHNy
Y19oOwo+ICAgICAgICAgICAgICBeCj4gICAgICAgICAgICAgIF4KPiBkcml2ZXJzL2dwdS9kcm0v
c3RtL2x0ZGMuYzo2OTQ6Njogd2FybmluZzoKPiAgdmFyaWFibGUgJ3NyY194JyBzZXQgYnV0IG5v
dCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQo+ICAgdTMyIHNyY194LCBzcmNfeSwg
c3JjX3csIHNyY19oOwo+ICAgICAgIF4KPgo+IFNpZ25lZC1vZmYtYnk6IFl1ZUhhaWJpbmcgPHl1
ZWhhaWJpbmdAaHVhd2VpLmNvbT4KCkFwcGxpZWQgb24gZHJtLW1pc2MtbmV4dCwKClRoYW5rcywK
QmVuamFtaW4KCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jIHwgNCArLS0tCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9zdG0v
bHRkYy5jCj4gaW5kZXggNjFkZDY2MS4uYTkxZTA0MSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vc3RtL2x0ZGMuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jCj4gQEAg
LTY5MSw3ICs2OTEsNyBAQCBzdGF0aWMgaW50IGx0ZGNfcGxhbmVfYXRvbWljX2NoZWNrKHN0cnVj
dCBkcm1fcGxhbmUgKnBsYW5lLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c3RydWN0IGRybV9wbGFuZV9zdGF0ZSAqc3RhdGUpCj4gIHsKPiAgICAgICAgIHN0cnVjdCBkcm1f
ZnJhbWVidWZmZXIgKmZiID0gc3RhdGUtPmZiOwo+IC0gICAgICAgdTMyIHNyY194LCBzcmNfeSwg
c3JjX3csIHNyY19oOwo+ICsgICAgICAgdTMyIHNyY193LCBzcmNfaDsKPgo+ICAgICAgICAgRFJN
X0RFQlVHX0RSSVZFUigiXG4iKTsKPgo+IEBAIC02OTksOCArNjk5LDYgQEAgc3RhdGljIGludCBs
dGRjX3BsYW5lX2F0b21pY19jaGVjayhzdHJ1Y3QgZHJtX3BsYW5lICpwbGFuZSwKPiAgICAgICAg
ICAgICAgICAgcmV0dXJuIDA7Cj4KPiAgICAgICAgIC8qIGNvbnZlcnQgc3JjXyBmcm9tIDE2OjE2
IGZvcm1hdCAqLwo+IC0gICAgICAgc3JjX3ggPSBzdGF0ZS0+c3JjX3ggPj4gMTY7Cj4gLSAgICAg
ICBzcmNfeSA9IHN0YXRlLT5zcmNfeSA+PiAxNjsKPiAgICAgICAgIHNyY193ID0gc3RhdGUtPnNy
Y193ID4+IDE2Owo+ICAgICAgICAgc3JjX2ggPSBzdGF0ZS0+c3JjX2ggPj4gMTY7Cj4KPgo+Cj4K
Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
