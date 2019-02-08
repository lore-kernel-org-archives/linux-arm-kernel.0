Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB6DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:13:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC4321916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fMr+5mNZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ABPU29/E";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ABPU29/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC4321916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wX3y7nZXuS7/rD9FYgdJarxVXHi/2MJGoClDu2A9ExQ=; b=fMr+5mNZi72lffAn+OST/tTTX
	xngbdXLLD+DleeNg7fWWtYrkQTz9HJJgO+uEcihQTUbuJvaMDYJkT8vhC5jBLDuFy+rYpoC1nGsv3
	J3hHskb+NAdhdjIPyNJ/IVaA/YgUHWX+pPLZHyxVnvel8dnHkBe4qaGr04P1vMbZNk8YigohIzplr
	k5jmdIn4xa4Ss0Y7OXo2dz8uGXYS3nEPHNDYDdoS0UMVelvmuUtXZEsY6b/AIZvWy3Gcn5oKAsNF9
	pnL/vYC3HsCdK9DZwp5uq6V9/8YM8D/46XdHgfBk6esQqKEbfXrA2iLq8D586nGFuhrOjvbTwMlTM
	z+A9MPixQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gryU4-0000A3-7C; Fri, 08 Feb 2019 05:13:52 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gryU1-00009L-7C
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 05:13:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id CA4F960860; Fri,  8 Feb 2019 05:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1549602824;
 bh=Epxg5oMx7p948rTTtVmM7t1VQNKZYq/qvGPZ3nQFngg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ABPU29/EKhMnBUJ6mC7vcDB/24Umg1D9FGQPfGz9AdPl0AnYCSKHBmsLMp4m8HPVp
 n3Wobc83C/IJS2jccVpFFLl7Cfdn7OpT91EGzftM/sSHS3OGqMGVZW7+r9h+ERonxd
 NCTGbnljOtBmOO02VdAAotW/NNq8VB/ue0Ge34I8=
Received: from [192.168.43.47] (unknown [106.206.90.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BF7560791;
 Fri,  8 Feb 2019 05:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1549602824;
 bh=Epxg5oMx7p948rTTtVmM7t1VQNKZYq/qvGPZ3nQFngg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ABPU29/EKhMnBUJ6mC7vcDB/24Umg1D9FGQPfGz9AdPl0AnYCSKHBmsLMp4m8HPVp
 n3Wobc83C/IJS2jccVpFFLl7Cfdn7OpT91EGzftM/sSHS3OGqMGVZW7+r9h+ERonxd
 NCTGbnljOtBmOO02VdAAotW/NNq8VB/ue0Ge34I8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BF7560791
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv7 5/6] coresight: etm4x: Add ETM PIDs for SDM845 and
 MSM8996
To: Mathieu Poirier <mathieu.poirier@linaro.org>
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <c050252dc8eb3fea03119cd5efc422ed6e48834e.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <CANLsYkwoqOhtENkhhSY5Tv23-vgUst4oakWrmQsB97=gDTVQLA@mail.gmail.com>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <cdef693d-1e8b-304d-cd62-d2fad3256580@codeaurora.org>
Date: Fri, 8 Feb 2019 10:43:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CANLsYkwoqOhtENkhhSY5Tv23-vgUst4oakWrmQsB97=gDTVQLA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_211349_281517_D54D8789 
X-CRM114-Status: GOOD (  13.18  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Jeffrey Hugo <jhugo@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, Tingwei Zhang <tingwei@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>, Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Leo Yan <leo.yan@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Mike Leach <mike.leach@linaro.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/8/2019 1:56 AM, Mathieu Poirier wrote:
> On Thu, 31 Jan 2019 at 17:54, Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>>
> 
> I am good with this patch but there isn't much I can do with it until
> Mike's patchset has been merged.  Please submit again when that has
> been done.
> 

Sure, thanks.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
