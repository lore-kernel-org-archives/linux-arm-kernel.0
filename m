Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36FCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:02:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8073A2173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j8jvKty1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZjKSfRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8073A2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8w1wvo50xyL8VIYLQ6DHAoQ+ejRocX9uiaQWcoSsAOM=; b=j8jvKty1QRI5np
	fWnr2ontxKa5vaB8goSmIRYllhPjbTzJqfqcrUpBnB2uXvm0ZgQS6xCLkU4JzNMfoBRDdBxGYBdYB
	3P4I/aOymsNQcZ4rd/zj11W8abKKavy/xP8x49/LawOy3oUAfcQy8PYnIx/2kxoNmr8HcutryWchc
	/eQ/U5FC6LKIXHC2sTFS60VZLeFITgF/D12k1GJnT9naGPBu0AUJOKo3qOsFAt8l98SEHzPCIKITH
	quY6CAXucAXa4TmBf7dewXAyyvNEILSaj0f8oKMwfjeF5NVcmB62LrKiwIrzwBOQcC+5q2+KQRdu6
	ApnkIm9zPR5LNokBgdWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghUM2-0007ha-MG; Thu, 10 Jan 2019 07:02:14 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghUM0-0007hC-5i
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 07:02:13 +0000
Received: by mail-pg1-x541.google.com with SMTP id d72so4443880pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 23:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=/SyfjbwGy/QygpYRjigRDd9BXY9IdRNQrb8Sp+1O7Y8=;
 b=UZjKSfRLRxgzPAj+oEH2DIYUMNrzymr9xCH0pZZmJq28w1qVfHTJgoI5HlEFedOhQi
 JxAzE/cl59lh+RX8u7jR3akEwyQRecEZYbUTdkP25a6buKS3KQTrN26HQ382ExU8qfbu
 /CuU5p9T7+RQW+Pk+M133x0vQbDlEAkpip420=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=/SyfjbwGy/QygpYRjigRDd9BXY9IdRNQrb8Sp+1O7Y8=;
 b=oiBnYbovLM85EpOSxJzAp44U3MQByVXll/Pwg2gmMotyFnoIBGJztz3C2H4xuic/vn
 iYajvAWr25+l12ijCbgDbWPnwPWiUKv8spCHbck/xRJLmleTNxJtZsN7hP8hcp2OrW+Y
 KnvTUdAVWC9YoZUwny3COrIl3Gig9vBjegIici7LsIgmLYrD1negALM940/kzPRp7FMb
 6iPBhyMFqhB/cEr8HKqGpuixUhbqpirMpBhCkiU6Dyuu5YmJzCaIAd99223lZDxtaoc6
 gF72Q+1bjXd/8P4ZHV5bfRG630rt1iRR/R0xtNAWArV02W9OW6DdqHdwqxgbbXTWy4h9
 7kmQ==
X-Gm-Message-State: AJcUukcuX5Ww5sxGt+nWiXdXxwPgY23noz+95GKusqRSCVJTovcI6UqJ
 V0e2o3pZwCn1iAfqhGCaKstf7Q==
X-Google-Smtp-Source: ALg8bN67gw99RMCWWtK05E04VP1vNKlzv8yiUt6z4sDNWLwtopNrU18MAbpbaewIOWG4qNBHZgqq0w==
X-Received: by 2002:a65:55ca:: with SMTP id k10mr8269770pgs.448.1547103731601; 
 Wed, 09 Jan 2019 23:02:11 -0800 (PST)
Received: from localhost ([122.166.131.155])
 by smtp.gmail.com with ESMTPSA id m19sm229740451pgn.35.2019.01.09.23.02.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 23:02:10 -0800 (PST)
Date: Thu, 10 Jan 2019 12:32:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH 4/4] ARM: defconfig: s5pv210: Add cpufreq support
Message-ID: <20190110070208.lvnrcd2nld3zthmk@vireshk-i7>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
 <20190108200509.30494-5-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190108200509.30494-5-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_230212_212154_BD3C4C44 
X-CRM114-Status: GOOD (  12.37  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 linux@armlinux.org.uk, krzk@kernel.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, kgene@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDgtMDEtMTksIDIxOjA1LCBQYXdlxYIgQ2htaWVsIHdyb3RlOgo+IFRoaXMgY29tbWl0IGVu
YWJsZXMgY3B1ZnJlcSBzdXBwb3J0IGZvciBhbGwgczVwdjIxMCBkZXZpY2VzLgo+IAo+IFNpZ25l
ZC1vZmYtYnk6IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4K
PiAtLS0KPiAgYXJjaC9hcm0vY29uZmlncy9zNXB2MjEwX2RlZmNvbmZpZyB8IDYgKysrKysrCj4g
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vY29uZmlncy9zNXB2MjEwX2RlZmNvbmZpZyBiL2FyY2gvYXJtL2NvbmZpZ3MvczVwdjIxMF9k
ZWZjb25maWcKPiBpbmRleCA5NTExOTZiZGYwMDguLmZkNGYyOGFhYmRhNiAxMDA2NDQKPiAtLS0g
YS9hcmNoL2FybS9jb25maWdzL3M1cHYyMTBfZGVmY29uZmlnCj4gKysrIGIvYXJjaC9hcm0vY29u
Zmlncy9zNXB2MjEwX2RlZmNvbmZpZwo+IEBAIC0xMSw2ICsxMSwxMiBAQCBDT05GSUdfQVJDSF9T
NVBWMjEwPXkKPiAgQ09ORklHX1ZNU1BMSVRfMkc9eQo+ICBDT05GSUdfQVJNX0FQUEVOREVEX0RU
Qj15Cj4gIENPTkZJR19DTURMSU5FPSJyb290PS9kZXYvcmFtMCBydyByYW1kaXNrPTgxOTIgaW5p
dHJkPTB4MjA4MDAwMDAsOE0gY29uc29sZT10dHlTQUMxLDExNTIwMCBpbml0PS9saW51eHJjIgo+
ICtDT05GSUdfQ1BVX0ZSRVE9eQo+ICtDT05GSUdfQ1BVX0ZSRVFfU1RBVD15Cj4gK0NPTkZJR19D
UFVfRlJFUV9ERUZBVUxUX0dPVl9PTkRFTUFORD15Cj4gK0NPTkZJR19DUFVfRlJFUV9HT1ZfUE9X
RVJTQVZFPW0KPiArQ09ORklHX0NQVV9GUkVRX0dPVl9VU0VSU1BBQ0U9bQo+ICtDT05GSUdfQ1BV
X0ZSRVFfR09WX0NPTlNFUlZBVElWRT1tCgpZb3UgZG9uJ3Qgd2FudCB0byB1c2Ugc2NoZWR1dGls
ID8gVGhhdCBpcyB0aGUgZGVmYXVsdCBnb3Zlcm5vciBmb3IKZXZlcnlvbmUgbm93IGEgZGF5cy4K
Ci0tIAp2aXJlc2gKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
