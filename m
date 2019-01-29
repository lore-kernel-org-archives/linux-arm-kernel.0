Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A769FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:47:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7679A20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aHW2m4tX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZT6K/fVj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UYKyJRnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7679A20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bRUs2X7qBh7UzIXhiNWYpDlaB1AwAOHHKKUE8sR4x8o=; b=aHW2m4tXexfW0jXSTuJs1qva8
	WJ3E264Gs7FA1dzhBF7zFvdQadrDkVFLVBkO6ymR5KXPszk4BSpLGUtE7jhPK1770PKt+gjIBSwep
	JKbCDxdlPhg8exS2Pi1vPRzbMfFiGc2mIOoLQDYegBxytm+lA6zsRkvVUPF9cAhHg5cN4RdO1kAi0
	QJVsvLxnp1+FQHYXikXgAg7doGDRdGNgavlwkY8oP5v01PWNGmJNVLYCKnMbc/JHjezl/Z7K+qpNW
	bBwjwV3yvN1TJmKvyVl/sRGM4a9Fe+/a+4Ok925xUFgOebLU2LPjoCV8SgzyFpvx8eIX3jPI+Iaoj
	+2ftQuc8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goUfR-0003U7-J4; Tue, 29 Jan 2019 14:47:13 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goUfI-0003TN-49
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 14:47:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 7D0CE60881; Tue, 29 Jan 2019 14:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548773223;
 bh=Zs3i6jD1okYi4Opv3xL3bXxvd/KZ5XgU/aG+dX1y8eU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ZT6K/fVjv48bzrip8pju8wNTWxr/imEJs0Ewhqb137Tf4NFBinHSy+8uIWUeYte0r
 dFUo29vx4L7tKYOdzg0gSRIquWmsWKALqmWEXH/HQAnu+0tRvJCFqaQ1d9mvdrpAJa
 /HBl+5+fK8gosLHOJ6Ck4g/72UIzPUiaAPikMdJk=
Received: from [192.168.1.100] (unknown [157.49.239.240])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id CB773601CF;
 Tue, 29 Jan 2019 14:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548773222;
 bh=Zs3i6jD1okYi4Opv3xL3bXxvd/KZ5XgU/aG+dX1y8eU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=UYKyJRnmkfkCG1+tSlxTnATluf1r7Yh+7cCFZDWYxmvVS2QSW2hbeHPB5LwGFnqwb
 6W/YIfDM1w3OTMS2JN3wpfEkW3bDNLX5iq/7jfjZgseCdQKQOvli9aqKYd+k+CkFAJ
 /2rkfsmWJN1Zq3Oahj7qNyXZaJAowDhinNgKZv8I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB773601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv5 4/7] coresight: etm4x: Add support to enable ETMv4.2
To: Suzuki K Poulose <suzuki.poulose@arm.com>, robh+dt@kernel.org,
 mathieu.poirier@linaro.org, mike.leach@linaro.org, leo.yan@linaro.org,
 alexander.shishkin@linux.intel.com, andy.gross@linaro.org,
 david.brown@linaro.org, vivek.gautam@codeaurora.org, jhugo@codeaurora.org,
 dianders@chromium.org, sboyd@kernel.org, bjorn.andersson@linaro.org,
 devicetree@vger.kernel.org, mark.rutland@arm.com, marc.w.gonzalez@free.fr
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <980aaf18c0fe92a667930e3a035394442af74869.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <342fa449-124e-7581-dfff-ef5d382f1f6b@arm.com>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <c243233a-96d3-ddde-1bff-f5ec5d0058e9@codeaurora.org>
Date: Tue, 29 Jan 2019 20:16:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <342fa449-124e-7581-dfff-ef5d382f1f6b@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_064704_192137_82747D9D 
X-CRM114-Status: GOOD (  10.59  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/29/2019 2:56 PM, Suzuki K Poulose wrote:
>
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> 

Thanks Suzuki.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
