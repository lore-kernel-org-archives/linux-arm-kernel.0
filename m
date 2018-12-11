Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E648EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:33:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F012082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hh48J4Yq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Tb7KyShu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F012082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WyMpFTKdm2B0KUQRoCj2r3GDaPMa64wNUZ6h+0SsPnc=; b=Hh48J4Yq5EpRpo
	Ioz7SY2wTtzt7vPf6vY0Qp4JQSqSKo1v94vkezIEH12UbFPBeXPBluHsqjQ6fUkUgejsO/2v74uPw
	7RG/6RIFDBcn5rZCathG+eiYtYZe6m0WAUryAF1gLhtShQr6yjICBBsaH60ZqPdH9+EueFWXYsiDM
	J//SLQI5RPZkgru+2WDFBy7jxm+7u1Y9+crypXz8srvouFXR075cFLpoqKQIacEIIcUxzng9BH0y3
	6Q07PSiQ1kT4Rs67bMKZf0JPs+ZWiM2ASjEu+xaQKY1b0figqiQQBC7g0sIVuBCKr2NkYrILeseDL
	oEo7cZf5CXFOwQ2U9Y4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWi9v-0002RB-Kq; Tue, 11 Dec 2018 13:33:11 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWi9r-0002QZ-BK
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 13:33:10 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBBDWdDA086348;
 Tue, 11 Dec 2018 07:32:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544535159;
 bh=Y+yfj3rJdcOxf0IL9jSvKQdzDMJM+vVEZXfNt4j07Uc=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=Tb7KyShu+CJ1Sr/oQVgZ9B3QFWgEzskbta27jwI/5VLuU33+JalBvQEk8i6d6p9gV
 ADZ7gewfuw4pgfKaYXMe9mZjd7LVofLGnQtOCwAy3dtt6hT+nmb7ca2rJivBi51Sjq
 OQuS+9W7TJhWnI/GTEVaTXvkmkfVldM9MQ69Ukeg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBBDWdua082186
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Dec 2018 07:32:39 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 07:32:39 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 07:32:39 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBBDWZLB030930;
 Tue, 11 Dec 2018 07:32:35 -0600
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am654-base-board: Add MMC/SD
 support
To: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
References: <20181207084233.13700-1-faiz_abbas@ti.com>
 <20181207084233.13700-3-faiz_abbas@ti.com>
 <20181208155427.jmidz4vsw4k4qj36@akan>
 <c1dd9783-84dc-9dad-ea94-9a14a4ad814d@ti.com>
 <20181210120647.i3ply3p7umvedb3u@akan> <20181210234730.GH6707@atomide.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <f2f31347-3aa3-8dda-84a3-bd112aa3ff9d@ti.com>
Date: Tue, 11 Dec 2018 19:02:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210234730.GH6707@atomide.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_053307_485375_F5452B9B 
X-CRM114-Status: GOOD (  18.63  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, kishon@ti.com, t-kristo@ti.com,
 Faiz Abbas <faiz_abbas@ti.com>, adrian.hunter@intel.com,
 michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Tony,

On 11/12/18 5:17 AM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [181210 12:07]:
>> I really am curious how Arnd / Tony actually pull this one off.. If they
>> have continous cron job for checking if your patch is ready... I doubt
>> it..
> 
> The only way that works in a distributed manner is for the patch
> authors to resend after the dependencies have cleared.
> 
> As some people don't know this, at least I try to reply with
> something about tagging patch as read and assuming it will get
> resent after dependencies have cleard.
> 
> Otherwise the todo list just keeps growing eternally :)

Alright, if the preference is to resend patches after dependencies are
cleared, I think it will also be better to mark the initial review-only
version as "RFC" (as Nishanth requested).

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
