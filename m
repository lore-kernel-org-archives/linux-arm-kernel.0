Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF60C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:27:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E222721871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D3CI8fVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E222721871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sqx/hyCavQ/01qBnOMmTqeERH78qr35IK0ZYP+UyOFU=; b=D3CI8fVxnAIUuL
	U8bPevpldr/l/hkPsl8A0TmufU+pNYVBRgy3WiVfRNcEby0EEv2kjIYE6HMjaRCAwJMcDxAnDH4ho
	SD40PC6GFrt9O6Lrbm1u7YsnOD8SFBbqCpKqxSpTAOfQTMB3vFM+BD6gv8OmcbF/F6SCCNEB11IYG
	1YI++lN1nuD5dA523Bs5yLRfpyQAnxAfsGXN6cX7S1bfnkWcyBZk7lcJ6Aq81K/gtMXLm6b/L7B2P
	2LO6ODGVmJKVOxir5UDVLWrXaQDZv08kUe9Y+ithMwb8OwB8us8j4RTl3IOD/mZVsx6qB1DbUssvV
	UsP6fiomqUe05cMOclOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goVIp-0007as-2N; Tue, 29 Jan 2019 15:27:55 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goVIl-0007Wd-4r
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:27:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F574A78;
 Tue, 29 Jan 2019 07:27:48 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 913D23F557;
 Tue, 29 Jan 2019 07:27:45 -0800 (PST)
Date: Tue, 29 Jan 2019 15:27:35 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH 6/7] arm64: dts: juno: Add cpu dynamic-power-coefficient
 information
Message-ID: <20190129152735.GA24772@e107155-lin>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-7-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190128165522.31749-7-quentin.perret@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_072751_204493_681E2041 
X-CRM114-Status: GOOD (  14.05  )
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
Cc: mark.rutland@arm.com, rjw@rjwysocki.net, nm@ti.com,
 lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org, sboyd@kernel.org,
 viresh.kumar@linaro.org, mka@chromium.org, linux-pm@vger.kernel.org,
 liviu.dudau@arm.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, dietmar.eggemann@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 04:55:21PM +0000, Quentin Perret wrote:
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> A CPUfreq driver, like the scpi driver used on Juno boards, which
> provide the Energy Model with power cost information via the PM_OPP
> of_dev_pm_opp_get_cpu_power() function, do need the
> dynamic-power-coefficient (C) in the device tree.
>
> Method used to obtain the C value:
> C is computed by measuring energy (E) consumption of a frequency domain
> (FD) over a 10s runtime (t) sysbench workload running at each Operating
> Performance Point (OPP) affine to 1 or 2 CPUs of that FD while the other
> CPUs of the system are hotplugged out.
> By definition all CPUs of a FD have the the same micro-architecture. An
> OPP is characterized by a certain frequency (f) and voltage (V) value.
> The corresponding power values (P) are calculated by dividing the delta
> of the E values between the runs with 2 and 1 CPUs by t.
>
> With n data tuples (P, f, V), n equal to number of OPPs for this
> frequency domain, we can solve C by:
>
> P =3D Pstat + Pdyn
>
> P =3D Pstat + CV=B2f
>
> Cx =3D (Px - P1)/(Vx=B2fx - V1=B2f1) with x =3D {2, ..., n}
>
> The C value is the arithmetic mean out of {C2, ..., Cn}.
>
> Since DVFS is broken on Juno r1, no dynamic-power-coefficient
> information has been added to its dts file.
>

Since the binding for "dynamic-power-coefficient" property already exist,
and I don't see any dependency for this and the next patch(TC2) on this
series, I will apply them. Please shout if for any reason that's not true.

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
