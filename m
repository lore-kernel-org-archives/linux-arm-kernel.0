Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0EDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:04:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322BA20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oGnfRj3E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="udYO8WKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322BA20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZjJwGTWY5xvG5169oZAvngFBI9yRkRIdRHMp3c2pcZM=; b=oGnfRj3EoM/Ikf
	QvWAjwp8gHG7RpR/qW8oey472GMKyGhC4Gk8KNR4rdfug1HY6bp1e7Sg5fd+ssOlgqu2BVhys5Tzf
	ZJQo2fBo2yeDhqcKTzmfU9eJEOgy2Flf9PAR/1TggMRrWggrDR/ZWhcSjaCiZXEK4e9koisFUZY4y
	WUlwE2lDPrM725t8ik3aLIsc5ZIxTfAQbTuNGF8cCqX2gmKqYHszTrfoZcSyBI27G3jPdjJcNQLB2
	hE1mRU0ubGStvi25/T/0jD3M8DkGoSILeGWeBr95xCpKe6kuoQcJTMNs5SuORPC5K2BVOj7hxO14y
	5DsRxGdUZ7CAKj9+Y8kQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWGYU-0001ue-Rm; Mon, 10 Dec 2018 08:04:42 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWGYQ-0001sw-5W
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 08:04:40 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBA843Ii061422;
 Mon, 10 Dec 2018 02:04:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544429043;
 bh=YUaTvCEoGoQ9M/VI0rsqshq+eCmW3OAv+7vup59ErDI=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=udYO8WKM5MDXlSNpxfdpt6V1JIXBVzy54EBqiVDP0g6IdSeLIAH0vB4YLi6k7WW5H
 EoYHqBpu2ZGHl8FUnaQ7mRs9GvA6VJZsePLVVKD6L3Ko/FZVBdWBCX5ogKExB/5LMt
 LlN6WavWzN9BVFC/gRIwlIipo2HqR0CHhGUeIZ0k=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBA843d9045242
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 02:04:03 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 02:04:02 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 02:04:02 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBA83u76031129;
 Mon, 10 Dec 2018 02:03:59 -0600
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am654-base-board: Add MMC/SD
 support
To: Nishanth Menon <nm@ti.com>, Faiz Abbas <faiz_abbas@ti.com>
References: <20181207084233.13700-1-faiz_abbas@ti.com>
 <20181207084233.13700-3-faiz_abbas@ti.com>
 <20181208155427.jmidz4vsw4k4qj36@akan>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <c1dd9783-84dc-9dad-ea94-9a14a4ad814d@ti.com>
Date: Mon, 10 Dec 2018 13:33:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181208155427.jmidz4vsw4k4qj36@akan>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_000438_332358_FFB71AE2 
X-CRM114-Status: GOOD (  21.93  )
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
 Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
 linux-kernel@vger.kernel.org, kishon@ti.com, t-kristo@ti.com,
 robh+dt@kernel.org, adrian.hunter@intel.com, michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 08/12/18 9:24 PM, Nishanth Menon wrote:
> On 14:12-20181207, Faiz Abbas wrote:
> 
>> +
>> +&sdhci0 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&main_mmc0_pins_default>;
>> +	bus-width = <8>;
>> +	non-removable;
>> +	ti,driver-strength-ohm = <50>;
> 
> ^^
> 
>> +};
>> +
>> +&sdhci1 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&main_mmc1_pins_default>;
>> +	ti,driver-strength-ohm = <50>;
> 
> NAK.
> 
> $ git checkout next-20181207
> $ git grep ti,driver-strength-ohm Documentation
> $
> 
> Nada.. And.. I think "new phy binding" probably introduces this.
> [1] https://patchwork.kernel.org/project/linux-mmc/list/?series=53185
> 
> If your patches are'nt really ready, please send them as RFC, I am not
> really in a mood to track the status of every single driver subsystem.
> 
> If your binding is not in linux next at the baremin, as far as I am
> concerned, this is not ready, and should be RFC.

No, RFC does not say "do not merge" or "this has dependencies". RFC is
used to invite a stronger review when introducing a new concept. Its
fair game to apply patches marked RFC if maintainer is okay with the
content.

Dependencies are either noted in cover-letter or below the patch
tear-line. With what you are asking, looks like patches need to be
resubmitted once dependencies are cleared, even if there is no change in
the content itself. This will be additional work.

That said, if it makes life convenient for you, you can impose such a
rule for patches you need to handle. But I think it will take some
getting used for developers who send patches to you as I don't think
this is a norm elsewhere.

Adding Tony and Arnd as well, in case I have missed some recently
accepted convention.

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
