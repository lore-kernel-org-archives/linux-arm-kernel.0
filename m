Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E87C65BB3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:07:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19FB2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jJfzWzlD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kj+il6zE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19FB2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/5tlozTF/hKDDe6oMOyCylNK53zpruCQhHklyy6WEs0=; b=jJfzWzlDRkj/io
	H51bPyQAtczA55RmBRNDRbFnUXauLQujv4LRKYES8WLKIpokQcKOLjqbSSwRsIAezY1lhgR0Bdzn/
	WRmq5irt/CKwRU8oAhAbG1qEsJbik196n+klBWsM6em+EzdE/KuMj5jUQf8n4KeDczFPDNUBeAHCv
	rtIzJY5ZkFAfhWenJMgvr6y+Ubj6H2I3KQ37GcMJfRENjsOdTyxQqplKD3dRP3oHMBaMnWx6c/qby
	eyaYIm5DBFjKamBKnri2FBASXxfLlkAvGIcupJEw2lWNbaMF9RHaERTFekrygtpnD57Ts1hDjtDda
	2VYkN7Ej+JVc9N0p1AMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWKLH-0007yY-Fq; Mon, 10 Dec 2018 12:07:19 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWKLD-0007y6-Kv
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:07:17 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBAC6klv060754;
 Mon, 10 Dec 2018 06:06:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544443607;
 bh=SoIHMtUTNlfSVDIq9B3xkSQBtFVNdE1rVVqkyNUwkbY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Kj+il6zEk3LprbloS0GylZFl7IlYxPosj43YMYau3UDWeaJCa4d7/5sbzgBDXJ1SC
 A/tPzsk0cU6ab3ciGAA8U3vlHKfwFFoawA68DKvR3u9BS7xhKG0ZhZO6S8RmNHxYxa
 bUALwwsiz+51xzUt6+yuMqf4zwEDapQrMXBEy6ik=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBAC6kgf081800
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 06:06:46 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 06:06:46 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 06:06:46 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBAC6kT9008560;
 Mon, 10 Dec 2018 06:06:46 -0600
Date: Mon, 10 Dec 2018 06:06:48 -0600
From: Nishanth Menon <nm@ti.com>
To: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am654-base-board: Add MMC/SD
 support
Message-ID: <20181210120647.i3ply3p7umvedb3u@akan>
References: <20181207084233.13700-1-faiz_abbas@ti.com>
 <20181207084233.13700-3-faiz_abbas@ti.com>
 <20181208155427.jmidz4vsw4k4qj36@akan>
 <c1dd9783-84dc-9dad-ea94-9a14a4ad814d@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c1dd9783-84dc-9dad-ea94-9a14a4ad814d@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_040715_759769_DAF5E452 
X-CRM114-Status: GOOD (  23.24  )
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
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, kishon@ti.com,
 t-kristo@ti.com, Faiz Abbas <faiz_abbas@ti.com>, adrian.hunter@intel.com,
 michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13:33-20181210, Sekhar Nori wrote:
> On 08/12/18 9:24 PM, Nishanth Menon wrote:
> > On 14:12-20181207, Faiz Abbas wrote:
> > 
> >> +
> >> +&sdhci0 {
> >> +	status = "okay";
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&main_mmc0_pins_default>;
> >> +	bus-width = <8>;
> >> +	non-removable;
> >> +	ti,driver-strength-ohm = <50>;
> > 
> > ^^
> > 
> >> +};
> >> +
> >> +&sdhci1 {
> >> +	status = "okay";
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&main_mmc1_pins_default>;
> >> +	ti,driver-strength-ohm = <50>;
> > 
> > NAK.
> > 
> > $ git checkout next-20181207
> > $ git grep ti,driver-strength-ohm Documentation
> > $
> > 
> > Nada.. And.. I think "new phy binding" probably introduces this.
> > [1] https://patchwork.kernel.org/project/linux-mmc/list/?series=53185
> > 
> > If your patches are'nt really ready, please send them as RFC, I am not
> > really in a mood to track the status of every single driver subsystem.
> > 
> > If your binding is not in linux next at the baremin, as far as I am
> > concerned, this is not ready, and should be RFC.
> 
> No, RFC does not say "do not merge" or "this has dependencies". RFC is
> used to invite a stronger review when introducing a new concept. Its
> fair game to apply patches marked RFC if maintainer is okay with the
> content.

True, fair enough.. RFC is request for comments. Anyways, that is
besides the point.
> 
> Dependencies are either noted in cover-letter or below the patch
> tear-line. With what you are asking, looks like patches need to be
> resubmitted once dependencies are cleared, even if there is no change in
> the content itself. This will be additional work.

Yes please. There would be other dts changes that are probably ready and
I really wont be tracking everything happening on other drivers. If the
binding is present at least in next, it is a good indication of things
clean and ready to go.

> 
> That said, if it makes life convenient for you, you can impose such a
> rule for patches you need to handle. But I think it will take some
> getting used for developers who send patches to you as I don't think
> this is a norm elsewhere.
> 
> Adding Tony and Arnd as well, in case I have missed some recently
> accepted convention.


I have'nt looked at any conventions, The style I prefer to follow when I do
submissions: It is my job to get the bindings in, until then my actual
dts is just "request for comments". Only after the bindings are merged
do I formally submit dts - simply because I dont expect dts maintainer
to track what happened to my driver's binding and discussions there of.

Seriously, is'nt it really reasonable for dts maintainer to check every
single driver's development status in 15 different mailing lists?
Because, it sounds like what you are asking. At least I wont have time
for it..


I really am curious how Arnd / Tony actually pull this one off.. If they
have continous cron job for checking if your patch is ready... I doubt
it..

-- 
Regards,
Nishanth Menon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
