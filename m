Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED342C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:01:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF21E20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mqtyjw0b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DD8nKNbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF21E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j7jgt0dHHV6mx49lLhncNOXYl37uS8R6x82MPsXcJfI=; b=mqtyjw0bLoeIT2
	6IlgROUMGHMncVkOpK691Fwr6hwpdZWmngWJ3NPa5kefeMUxzpsMEE8pOwHyfC58aSNOEDL1oLoto
	vEAa2vSv8OG41D7vaw/crQ+aMFrId92UWeJBnKg6kwhfZbGqh3JTCaBMy/6GL+GvgUsTmZq1HudWo
	s7NblQE1YemNiyvlfU6klY7a4wMhot2OsWRgyJJXKzHKfBFpJGtlpQsTajN1yJNMZquFrsRl/jy6q
	NVDED5wEj9W41u5ZxKeKksg0CRih/EDvY6puIG/1yqBaDAAFPV1yj3tXUKwx1zxKGfxU/3607Xdz2
	5rKqO/8YguFnrYWvvn0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVEoy-000208-Ty; Fri, 07 Dec 2018 12:01:28 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVEow-0001zf-5P
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 12:01:27 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB7C14xC056580;
 Fri, 7 Dec 2018 06:01:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544184064;
 bh=VSMvpKLfH3TKVA/6yssghydHO3ivTEwuOEklbF4SlwQ=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=DD8nKNbfBUEkfEUGJgfMAIXxYlSaYL+psa1KHTJ3eLr2eAEvsR1e6g/xNNcoKyuoq
 sd2KUntKruDxNPWszQsJQB+QRGMHys6nSzBFMlnL/Rw9z1WlpeF4yFU4SFOq3xMoup
 TcHIpfTtMdjJz6J1wLkQhzLpigS8EgyrhJM60WkQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB7C14Ww087929
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Dec 2018 06:01:04 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 7
 Dec 2018 06:01:03 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 7 Dec 2018 06:01:03 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB7C0xxE010591;
 Fri, 7 Dec 2018 06:01:00 -0600
Subject: Re: [RFC PATCH 4/6] dt-bindings: update mvneta binding document
To: Russell King - ARM Linux <linux@armlinux.org.uk>
References: <20181112122933.GD30658@n2100.armlinux.org.uk>
 <E1gMBMs-00089t-Fd@rmk-PC.armlinux.org.uk> <20181203235455.GA5851@bogus>
 <20181205110009.GQ30658@n2100.armlinux.org.uk>
 <CAL_JsqJXMDqQVQJoq0sXn0VEA1iFpcsK+Hjsxwt-7aWNreAkPw@mail.gmail.com>
 <2b832258-0b8f-a8f9-2907-878d0e4d6ee7@ti.com>
 <20181207104142.GY30658@n2100.armlinux.org.uk>
 <2ac6488c-a060-6875-bc92-c14fe2dbf8af@ti.com>
 <20181207113301.GZ30658@n2100.armlinux.org.uk>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <0dc0916f-2654-53fe-226d-f75c9498bb39@ti.com>
Date: Fri, 7 Dec 2018 17:30:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207113301.GZ30658@n2100.armlinux.org.uk>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_040126_286779_7A7F3113 
X-CRM114-Status: GOOD (  17.34  )
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

Hi,

On 07/12/18 5:03 PM, Russell King - ARM Linux wrote:
> On Fri, Dec 07, 2018 at 04:43:27PM +0530, Kishon Vijay Abraham I wrote:
>> Russell,
>>
>> No, I haven't merged patches from this series. That would have failed
>> compilation since Grygorii modified enum phy_mode which is used in this series.
>> You have also noted this in your cover letter.
> 
> Ok, but in any case, given the complexities of modifying the patch
> and properly testing it, I think I'll wait until those changes have
> hit mainline before re-spinning this series.  Alternatively, if
> you're happy to take just build-tested version, I could re-spin
> with that so at least we can get the phy bits queued for the merge
> window.

I'd prefer we test it before merging.
> 
> In any case, I'm busy trying to get to the bottom of several OMAP4
> bugs while ill, so this isn't something I want to do at the moment.

Take care!

Thanks
Kishon
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
