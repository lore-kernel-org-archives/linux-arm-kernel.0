Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957DAC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:14:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65BCC20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lgn9ejml";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nBU1qhRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BCC20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/5A4WyB0vmXQ1Wklb1x5lJUEoEretiaWmWbL1b/a41E=; b=lgn9ejmlWwXjHg
	lyyW5jimtDjsknXxrt0sg1U3bR+smLpwVM8ZTVjiNDnk3JR6rUnILyPri7BC0/yRamNL9DJEyddiG
	GHV1yi5kj7Y1cBAklKl6F9R2ROHL+BqWvYaRDfKVD/8+0/BmpANj3hT9uxD86s+QvaRfAkfuMQkiS
	PtI2NoV5g2e8zWoFKHvzWucreIbNFoSH4kgdOuUCvc2FiyCcGk12GnMsPthIierpwLthDnRHF7NOB
	7GjXBZySpEU73/825vV6lm4QEXGe2tzs89x9FGx0jevUM5pNQCSKbfFX2aNHSF+2/nysb9UZ5JT0n
	R7OiiOQ5n7vhytj4elRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVE5B-0007w7-SB; Fri, 07 Dec 2018 11:14:09 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVE59-0007l3-2C
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 11:14:08 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB7BDddk105451;
 Fri, 7 Dec 2018 05:13:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544181219;
 bh=I0eaLhe2z6Px2LoXO/1YyEzt8N7Ox/rk6lBfjVybSGE=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=nBU1qhRsUdQgpuP71NtQSguWl0RDWGZnOZlIHJWrBsjPkJAn/EW9ZBJ7XmkMLL878
 IgwEioeNJgmQ6uVChxguzg9wkUiHCzERUMlISGtdDXn+fv6qmBmyF5Gvf9EY22CVrS
 crQoWvGc4VorSLGwNyb3gUsgeJpSYakCPuSjHtcw=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB7BDdEW041750
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Dec 2018 05:13:39 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 7
 Dec 2018 05:13:38 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 7 Dec 2018 05:13:38 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB7BDZcD021831;
 Fri, 7 Dec 2018 05:13:35 -0600
Subject: Re: [RFC PATCH 4/6] dt-bindings: update mvneta binding document
To: Russell King - ARM Linux <linux@armlinux.org.uk>
References: <20181112122933.GD30658@n2100.armlinux.org.uk>
 <E1gMBMs-00089t-Fd@rmk-PC.armlinux.org.uk> <20181203235455.GA5851@bogus>
 <20181205110009.GQ30658@n2100.armlinux.org.uk>
 <CAL_JsqJXMDqQVQJoq0sXn0VEA1iFpcsK+Hjsxwt-7aWNreAkPw@mail.gmail.com>
 <2b832258-0b8f-a8f9-2907-878d0e4d6ee7@ti.com>
 <20181207104142.GY30658@n2100.armlinux.org.uk>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <2ac6488c-a060-6875-bc92-c14fe2dbf8af@ti.com>
Date: Fri, 7 Dec 2018 16:43:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207104142.GY30658@n2100.armlinux.org.uk>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_031407_253945_0BA4720A 
X-CRM114-Status: GOOD (  18.12  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 netdev <netdev@vger.kernel.org>, Gregory CLEMENT <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "moderated
 list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Russell,

On 07/12/18 4:11 PM, Russell King - ARM Linux wrote:
> On Fri, Dec 07, 2018 at 09:37:54AM +0530, Kishon Vijay Abraham I wrote:
>> Hi Russell,
>>
>> On 05/12/18 9:00 PM, Rob Herring wrote:
>>> On Wed, Dec 5, 2018 at 5:00 AM Russell King - ARM Linux
>>> <linux@armlinux.org.uk> wrote:
>>>>
>>>> On Mon, Dec 03, 2018 at 05:54:55PM -0600, Rob Herring wrote:
>>>>> On Mon, Nov 12, 2018 at 12:31:02PM +0000, Russell King wrote:
>>>>>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>>>>>
>>>>> Needs a better subject and a commit msg.
>>>>
>>>> Hmm, not sure why it didn't contain:
>>>>
>>>> "dt-bindings: net: mvneta: add phys property
>>>>
>>>> Add an optional phys property to the mvneta binding documentation for
>>>> the common phy.
>>>>
>>>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>"
>>>>
>>>> as the commit message.  With the correct commit message, are you happy
>>>> with it?
>>>
>>> Yes.
>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>
>> Are you planning to resend this series?
> 
> I'm not - you said previously that you had merged the first three
> patches into the phy tree, which are fine.  The next two could be

No, I haven't merged patches from this series. That would have failed
compilation since Grygorii modified enum phy_mode which is used in this series.
You have also noted this in your cover letter.

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
