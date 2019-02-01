Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B431FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:51:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7341E20B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EBHZJBfp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z2Copjvd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Is5gbo6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7341E20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QZCQWaWso0akGKU/3lne0HZiN+HS6ljktT1cMP/z2uw=; b=EBHZJBfpJn/n3PFDw07wmxjIX
	4mu/muUasBIO02fCGEPedooBRPcV75pusUsKE+MBIFERumUdW4jz87H8rWkp0n804vHOu7WCz+zqp
	bvE5Wksj1KzDygrY8FihyBnS2w4xCHGrfZaznU1hyhq9KsDWGPDMZwFRA337vwughL0O5nMiJx91/
	5cjyJX1BUTR6sy9Vse2qMugNh+qcnUm8XmW+nsjdcyIVdJiBoNHRR4J0H/vBPytMhywxOp77+63Cr
	idJKkw/10B/frc9UU+5nDN78IuN3ohm5C8RuOxIZckCOpka3mKIbd0MhV3JCRyS1wHjVzn8g0ubWa
	+Oaa+fp8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpN31-0004UK-79; Fri, 01 Feb 2019 00:51:11 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpN2x-0004Tk-Hx
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 00:51:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id C319660929; Fri,  1 Feb 2019 00:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548982266;
 bh=RV9CfmcwP8zRx8TUmRdbkhNyhGkS4YjCAsge9hdXd0k=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=Z2Copjvd+3B3an5wa9QJpcp7kWlTylBmI8Ia48aSSHpx3NW7/OvdEmqdIR57F80bd
 VP3hmQKqoDAb+X63+YH5/NaIC+MBP0v/YuH/V6iA2LZTfRIPgA3vimDAQ270dssoo+
 HoROuAtvPqGfGxcjEfa2QZ2jaWCuZx1SSJLiq8BA=
Received: from [192.168.43.47] (unknown [223.186.125.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 98CA960590;
 Fri,  1 Feb 2019 00:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548982263;
 bh=RV9CfmcwP8zRx8TUmRdbkhNyhGkS4YjCAsge9hdXd0k=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=Is5gbo6DnMh/w9Mj4NS5cPerYfuXPB3ONJOrcOQY9P4RNWOcyHq/5fAmc69s9ItMQ
 Z25Qm9PTocOXw4DV/xk/XXK8em5vRGCuks2A4f+nhn2n1b0pLe25vG7ooP1d4aujd6
 LY5TuMrSzvZRQQO0lEXIR7OKaQbSQsEmX5AKqNVU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98CA960590
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv6 6/6] coresight: debug: Add Unique Component Identifier
 (UCI) table
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, robh+dt@kernel.org,
 mathieu.poirier@linaro.org, mike.leach@linaro.org, leo.yan@linaro.org,
 alexander.shishkin@linux.intel.com, andy.gross@linaro.org,
 david.brown@linaro.org, vivek.gautam@codeaurora.org, jhugo@codeaurora.org,
 dianders@chromium.org, sboyd@kernel.org, bjorn.andersson@linaro.org,
 devicetree@vger.kernel.org, mark.rutland@arm.com, marc.w.gonzalez@free.fr
References: <cover.1548943727.git.saiprakash.ranjan@codeaurora.org>
 <f724b28e5bfd7bca062aa5380cfd9328289559bf.1548943727.git.saiprakash.ranjan@codeaurora.org>
 <304febd7-da9a-92d6-47bb-d9983d4bc5d4@arm.com>
 <2801964a-ba35-9393-593b-c5108a8825e4@codeaurora.org>
Message-ID: <0896a3f6-e2c3-49a0-8420-5127972b410b@codeaurora.org>
Date: Fri, 1 Feb 2019 06:20:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2801964a-ba35-9393-593b-c5108a8825e4@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_165107_633927_EF32837F 
X-CRM114-Status: GOOD (  14.92  )
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
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, sibis@codeaurora.org, tingwei@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMi8xLzIwMTkgNjoxNyBBTSwgU2FpIFByYWthc2ggUmFuamFuIHdyb3RlOgo+IE9uIDEvMzEv
MjAxOSAxMTozMSBQTSwgU3V6dWtpIEsgUG91bG9zZSB3cm90ZToKPj4KPj4KPj4gT24gMzEvMDEv
MjAxOSAxNDoyMiwgU2FpIFByYWthc2ggUmFuamFuIHdyb3RlOgo+Pj4gQWRkIFVDSSB0YWJsZSBm
b3IgY29yZXNpZ2h0IENQVSBkZWJ1ZyBtb2R1bGUuIFRoaXMgcGF0Y2ggYWRkcwo+Pj4gdGhlIFVD
SSBlbnRyaWVzIGZvciBLcnlvIENQVXMgZm91bmQgb24gTVNNODk5NiB3aGljaCBzaGFyZXMKPj4+
IHRoZSBzYW1lIFBJRHMgYXMgRVRNcy4KPj4+Cj4+PiBXaXRob3V0IHRoaXMsIGJlbG93IGVycm9y
IGlzIG9ic2VydmVkIG9uIE1TTTg5OTY6Cj4+Cj4+IG5pdDogU3ViamVjdCBkb2Vzbid0IG1hdGNo
IHRoZSBwYXRjaCBjb250ZW50cy4gWW91IGNvdWxkIHNpbXBseSBzYXkgOgo+Pgo+PiBjb3Jlc2ln
aHQ6IGNwdS1kZWJ1ZzogQWRkIHN1cHBvcnQgZm9yIFF1YWxjb21tIEtyeW8KPj4KPiAKPiBEb25l
Lgo+IAo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29y
ZXNpZ2h0LWNwdS1kZWJ1Zy5jIAo+Pj4gYi9kcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29y
ZXNpZ2h0LWNwdS1kZWJ1Zy5jCj4+PiBpbmRleCBlODgxOWQ3NTA5MzguLjkxNWQ4NmEzOWNlZSAx
MDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaHd0cmFjaW5nL2NvcmVzaWdodC9jb3Jlc2lnaHQtY3B1
LWRlYnVnLmMKPj4+ICsrKyBiL2RyaXZlcnMvaHd0cmFjaW5nL2NvcmVzaWdodC9jb3Jlc2lnaHQt
Y3B1LWRlYnVnLmMKPj4+IEBAIC02NTUsMjQgKzY1NSwyMyBAQCBzdGF0aWMgaW50IGRlYnVnX3Jl
bW92ZShzdHJ1Y3QgYW1iYV9kZXZpY2UgKmFkZXYpCj4+PiDCoMKgwqDCoMKgIHJldHVybiAwOwo+
Pj4gwqAgfQo+Pj4gK3N0YXRpYyBzdHJ1Y3QgYW1iYV9jc191Y2lfaWQgdWNpX2lkX2RlYnVnW10g
PSB7Cj4+Cj4+IEFzIFN0ZXBoZW4gbWVudGlvbmVkLCB0aGlzIG11c3QgYmUgImNvbnN0Ii4KPj4K
Pj4gUmVzdCBsb29rcyBmaW5lLgo+IAo+IERvbmUuCj4gCgpBbHNvIGl0IHNob3VsZCBiZSBjaGFu
Z2VkIGluIE1pa2UncyBwYXRjaCBJIHN1cHBvc2Ugb3IgZWxzZToKCkluIGZpbGUgaW5jbHVkZWQg
ZnJvbSAKZHJpdmVycy9od3RyYWNpbmcvY29yZXNpZ2h0L2NvcmVzaWdodC1jcHUtZGVidWcuYzoy
NjowOgpkcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29yZXNpZ2h0LWNwdS1kZWJ1Zy5jOjY3
MjoyOTogd2FybmluZzogCmluaXRpYWxpemF0aW9uIGRpc2NhcmRzIOKAmGNvbnN04oCZIHF1YWxp
ZmllciBmcm9tIHBvaW50ZXIgdGFyZ2V0IHR5cGUgClstV2Rpc2NhcmRlZC1xdWFsaWZpZXJzXQog
ICBDU19BTUJBX1VDSV9JRCgweDAwMGYwMjA1LCB1Y2lfaWRfZGVidWcpLCAvKiBRdWFsY29tbSBL
cnlvICovCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KZHJpdmVycy9od3RyYWNpbmcv
Y29yZXNpZ2h0L2NvcmVzaWdodC1wcml2Lmg6MTkyOjExOiBub3RlOiBpbiBkZWZpbml0aW9uIApv
ZiBtYWNybyDigJhDU19BTUJBX1VDSV9JROKAmQogICAgLmRhdGEgPSB1Y2lfcHRyIFwKICAgICAg
ICAgICAgXn5+fn5+fgpkcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29yZXNpZ2h0LWNwdS1k
ZWJ1Zy5jOjY3MzoyOTogd2FybmluZzogCmluaXRpYWxpemF0aW9uIGRpc2NhcmRzIOKAmGNvbnN0
4oCZIHF1YWxpZmllciBmcm9tIHBvaW50ZXIgdGFyZ2V0IHR5cGUgClstV2Rpc2NhcmRlZC1xdWFs
aWZpZXJzXQogICBDU19BTUJBX1VDSV9JRCgweDAwMGYwMjExLCB1Y2lfaWRfZGVidWcpLCAvKiBR
dWFsY29tbSBLcnlvICovCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KZHJpdmVycy9o
d3RyYWNpbmcvY29yZXNpZ2h0L2NvcmVzaWdodC1wcml2Lmg6MTkyOjExOiBub3RlOiBpbiBkZWZp
bml0aW9uIApvZiBtYWNybyDigJhDU19BTUJBX1VDSV9JROKAmQogICAgLmRhdGEgPSB1Y2lfcHRy
IFwKICAgICAgICAgICAgXn5+fn5+fgoKLS0gClFVQUxDT01NIElORElBLCBvbiBiZWhhbGYgb2Yg
UXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gaXMgYSBtZW1iZXIKb2YgQ29kZSBBdXJv
cmEgRm9ydW0sIGhvc3RlZCBieSBUaGUgTGludXggRm91bmRhdGlvbgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
