Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248F1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:00:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0542081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AKEd4s4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0542081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XRnCjiX3oFQeuuKrzI6jYxrEV6UkttjaDJ0VwWwWIsE=; b=AKEd4s4VFy8Iir
	JG48Unnel5582EHOXfCYAagq+UovUTt0VGfo4ifHiYKp7k/phgLs7e6Owd+BffGm66qezUQDyNozq
	X1GVBSQFbkeWEcERsEzPBCrWYqI/j7+TyBvYfQCI/HgSWPXrf9QtjHXuNOHTytMSDhqA+nlQVFtWK
	nGZKdfnqE5vbMIlRCLq1GO202ZBJr6iQfKp/IRjsSueSpD6p33HRx3eV6C99/YubWGr/yavEjbJvi
	GfAPfXy5It5CTKmsjXQXWI2nYGcHMy1sSZkmm9wZkutCkq6zcCSL7hHS/bwkSo5QPtgzAXTmpC+VR
	ZniSFsKFNqRhaMBxQrdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUFvi-0000dK-K5; Tue, 04 Dec 2018 19:00:22 +0000
Received: from mailgate1.rohmeurope.com ([178.15.145.194])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFv8-0007Jp-1Y
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:00:16 +0000
X-AuditID: c0a8fbf4-519ff700000014c1-75-5c06ce8ef48f
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com
 [192.168.251.177])
 by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id
 FA.57.05313.E8EC60C5; Tue,  4 Dec 2018 19:59:26 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0415.000; Tue, 4 Dec 2018 19:59:25 +0100
From: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH v4 1/8] clk: clkdev/of_clk - add managed lookup and
 provider registrations
Thread-Topic: [PATCH v4 1/8] clk: clkdev/of_clk - add managed lookup and
 provider registrations
Thread-Index: AQHUe0fdW8Mz1FW0uUqQ8Q7xdFN+k6VoDTEAgAW97maAATqoh4AACBHE
Date: Tue, 4 Dec 2018 18:59:24 +0000
Message-ID: <042F8805D2046347BB8420BEAE397A4066F2E07D@WILL-MAIL001.REu.RohmEu.com>
References: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <ec0d6ee7ea79f0e05041ed3e564b0aadb297ef5f.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <154356805035.88331.16867826308376667832@swboyd.mtv.corp.google.com>
 <20181130105022.GA15388@localhost.localdomain>
 <154388011043.88331.6461709079501929390@swboyd.mtv.corp.google.com>
 <20181204071315.GA31204@localhost.localdomain>,
 <154394767367.88331.17679291261207728780@swboyd.mtv.corp.google.com>
In-Reply-To: <154394767367.88331.17679291261207728780@swboyd.mtv.corp.google.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [109.240.170.137]
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxTVxzGPfe9wDWXCukR3Uwq2QdRNoMxJ44t+zJyF7dkaswWQgKX9UIJ
 bSH3tip+mEVljGYyFHxZQaEKBEkmtBoD2EUsRoWCiMQqikrSZlvBlzgxmBVk9/ZO5dN5znnO
 73nuSf6XwfV/U2lMic0uSjbBYqQSiP6OmHdD7U0q75PLnkw0dNBPowM/f4YWB7OQ90QXiSL9
 1QDdnf2LRDMthwCqPNFMotHRbhr5wiESHb48QqMXvzwikeenVgKN9zVRaLo9DFDg6B8ARTzD
 GGpqu0GgsaEvUbjjKY0W/T00ehPyEmiirhFHwUv2LyBfdXuB4sdDYzj//F4VzTc6xwi+1/2Q
 5kfablP8GX8U432dNRQ/GfJT/PnWffyZ2nqS751z0nzthU7Av/R9+O3y3MTsQsG+a0dJse3j
 zwsSzdfcDVT5ILHnVVOUdoJbuAvoGMhtgi/65jEXSGD03B0Au38P4trmOoBTZ88pDsNQXDZ0
 TdAqkMKthVdOheMAzgUZeDPWQKjGCq4AnvXPYNolAfpmD+GazoGxriOkqgkuHQ50Xo0Hsdx2
 eO9pG6WVhXA4dL8+fknHbYOTlU/iQYD7ANY4n8U1zhng/Ugzpn02B1v9o/8/IRVGw29ITa+F
 c9VaAc6thy2X/qE0nQHbPTO4VpwMB3+LEHUg1b0k1r0EcS9B3EuQFkB0AmgVSizFgl3cmCmJ
 jkypzGxVlh/KrD6gTc9sD1gMfBUAHAOMSSwdpPL0pLBLrrAGwEoGM6ay3R8pR8sLy0wVZkE2
 50sOiygHAGRwYwo7qXqsSajYK0plb61VDGE0sLmj/+bqObW5VBTLRemtu5phjJC1DStgsiQW
 i3uKSiz29zbG6NTwhLQUWbSZRElw2M356mDky8pkqFaS0qsfUXvlcsGqnGroEFiZZmDn3WSe
 nlMNs8P2LnYaGJTXrWB3qliS8vu8o6aVQEwJtFzA1EC78N5KcwKmeoovXb2s4cHX/RMu57qc
 K4EH9TrPAN31aODP01PfN3sfe9dkXa/aqoude57xzYbsyv1inWH4Rr0j9unV6d7oWPBx8dyW
 4e8eNjrlI1v7jkdNletf5/568mC6Cx4uivBVC019NZHNCyeR6eLLVcd25+xlYwM/iu6Za6WF
 R/OL2rONhGwWNq7DJVn4DzunlFH7AwAA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_105946_679020_EDDAD51A 
X-CRM114-Status: UNSURE (   9.50  )
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
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Daniel Kurtz <djkurtz@chromium.org>, Sebastian Reichel <sre@kernel.org>,
 David Brown <david.brown@linaro.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Andy Gross <andy.gross@linaro.org>,
 Huang Shijie <sjhuang@iluvatar.ai>, Guenter Roeck <linux@roeck-us.net>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "linux-soc@vger.kernel.org" <linux-soc@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Akshu Agrawal <akshu.agrawal@amd.com>,
 "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Stephen,
.
> > I think we should use parent device's node, not the paren node in DT,
> > right? But I agree, we should only look "one level up in the chain".

> Are these two things different? I'm suggesting looking at
> device_node::parent and trying to find a #clock-cells property.

I thought that MFD sub-devices may completely lack the DT node but I will verify this tomorrow. BTW, I already did the patch version 6 which checks the dev->parent->of_node if #clock-cells is not found from device's own node or if own node is NULL.

Br. Matti Vaittinen 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
