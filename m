Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF77C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:10:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF6D2080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fvVEQS1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF6D2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A3mnT3RT55Q8tW5pHZoyxzo65G2xx6IFJDYq70blhr8=; b=fvVEQS1ycDBrum
	SDmd+ZtW0SwUSTOKACB2lvd5BCEKBHsoUrjC2XPSszezl3RnkARCO6e+jwFUBwYnc/PXeXc1PC+lK
	loFsQYdjJD6q2dlAtOllDdLGsBXugBTN/15oC6WMH4qNBEHkTb3ZNCFuG920sgkymye7dhDWHEAA7
	2G1CApcHNJxzFCLNTt7HFy/QBP7Fqyaq2e3DQjIswOFscZpHsL4JD3aTOxCbBkRFOe/9okMXPG/FS
	7fa2cGGO3RD8VHBY46NLr7G1vTqndA7XBG9DMEQSgEEjgf4uuyGzWSZb1DxOrMCzvKcduLq3TYTCY
	tirq00kCpti/aXlPsLvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs36w-0004T2-UB; Fri, 08 Feb 2019 10:10:18 +0000
Received: from imap1.codethink.co.uk ([176.9.8.82])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs36t-0003pi-6f
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 10:10:17 +0000
Received: from [167.98.27.226] (helo=aijekuh.office.codethink.co.uk)
 by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
 id 1gs36o-0002Ci-9c; Fri, 08 Feb 2019 10:10:10 +0000
Message-ID: <1549620609.19850.1.camel@codethink.co.uk>
Subject: Re: [PATCH 5/5] clk: tegra: add tegra20 automotive init
From: Kejia Hu <kejia.hu@codethink.co.uk>
To: Dmitry Osipenko <digetx@gmail.com>, linux-tegra@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
Date: Fri, 08 Feb 2019 10:10:09 +0000
In-Reply-To: <7f300cd5-2b97-17fb-da06-b212a8fae647@gmail.com>
References: <20190207125408.8776-1-kejia.hu@codethink.co.uk>
 <20190207125408.8776-6-kejia.hu@codethink.co.uk>
 <7f300cd5-2b97-17fb-da06-b212a8fae647@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_021015_601366_0ED6CD1C 
X-CRM114-Status: UNSURE (   7.23  )
X-CRM114-Notice: Please train this message.
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
Cc: Thomas Preston <thomas.preston@codethink.co.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCAyMDE5LTAyLTA3IGF0IDE2OjIzICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6
Cj4gdGhpcyBhbGwgbG9va3MgdmVyeSBnZW5lcmljIGFuZCBtdWNoIG1vcmUgYm9hcmQtc3BlY2lm
aWMgdGhhbiBhdXRvbW90aXZlCgpIaSwKClRoYW5rcyBmb3IgeW91ciByZXBseS4KCldlIGdvdCB0
aGUgY2xvY2sgZGF0YSBmcm9tIG52aWRpYSBwZGsgZm9yIHRoZSBhdXRvbW90aXZlIHdoaWNoIGRp
ZG4ndApzZXQgdGhlIGNsb2NrcyB1cCBpbiB0aGUgc2FtZSB3YXkgYXMgY29tbWVyY2lhbCBwYXJ0
cywgYW5kIHdlIHdlcmUgdG9sZAp0aGF0IHRoZXJlIGFyZSBjZXJ0YWluIGNsb2NrIHJlc3RyaWN0
aW9ucyBmb3IgdGhlIGF1dG9tb3RpdmUgcGFydHMgdGhhdAp0aGUgY29tbWVyY2lhbCBvbmVzIGRv
IG5vdCBoYXZlLgoKQXBwbHlpbmcgZGlmZmVyZW50IGNsb2NrIGNvbmZpZ3MgZm9yIGVhY2ggbm9k
ZXMgZG9lc24ndCBzZWVtcyB0byBiZSBhCmdvb2Qgd2F5LCBhcyB0aGV5IHdpbGwgYmUgdG9vIHNj
YXR0ZXJlZCBpbiB0aGUgZGV2aWNlIHRyZWUuIFdlIHByb3Bvc2VkCnRvIGFkZCBhIG5ldyByb290
IG5vZGUgZm9yIHRoZSBjbG9jayBvcmlnaW5hbGx5WzFdLCBhbmQgZnVydGhlcgpkaXNjdXNzaW9u
IHN1Z2dlc3RlZCB1cyB0byBkaXN0aW5ndWlzaCB0aGUgdmFyaWF0aW9uIGJ5IHJlYWRpbmcgdGhl
IFNLVQppbmZvLCB0aHVzIGNhbWUgdGhpcyBwYXRjaC4gV2UgY2FuIGRpc2N1c3MgZnVydGhlciB0
aG91Z2guCgpSZWdhcmRzCgpbMV0gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvYXJtLWtl
cm5lbC9tc2c2NjUzNDQuaHRtbAotLSAKS2VqaWEgSHUKU29mdHdhcmUgRGV2ZWxvcGVyCgpDb2Rl
dGhpbmsgTHRkCjNyZCBGbG9vciBEYWxlIEhvdXNlCjM1IERhbGUgU3RyZWV0Ck1hbmNoZXN0ZXIK
TTEgMkhGClVuaXRlZCBLaW5nZG9tCgpDb2RldGhpbmsgZGVsaXZlcnMgY3V0dGluZyBlZGdlIG9w
ZW4gc291cmNlIGRlc2lnbiwgZGV2ZWxvcG1lbnQgYW5kCmludGVncmF0aW9uIHNlcnZpY2VzLgoK
aHR0cDovL2NvZGV0aGluay5jby51awpPZmZpY2U6ICs0NCAxNjEgMjM2IDU1NzUKaHR0cHM6Ly93
d3cuY29kZXRoaW5rLmNvLnVrL3ByaXZhY3kuaHRtbMKgCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
