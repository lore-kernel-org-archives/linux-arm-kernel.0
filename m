Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC5DC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:25:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C5D9207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CbU2VCXx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tgbRU++P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5D9207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Vp/yDLfJ5worU3eBKYgsQTbDQJlykA5b+IggqnJVZMY=; b=CbU2VCXxoILpKbwN6WfcfvdD8
	c5BDLl81JKJagDLFC9REuAe4aUtIDNPuhDCo5cdnzvnYNyiBE9wIq7rvG8bbJpBBEqQhwbl5+PFKB
	BfXi6kj1AdkmX41OVdviniCP3KNtjfHP/P4hDBIy2+D8GNK5KRzz8Zq6s/BKpmGSZkG6VYGShCCUs
	h7J9XU3YCu7KnhPbhu8LHio54VVRnrk9a4euuYMuVVsh0FxkxWyvS3XAYkrAIbUbds56+KFg/J0iT
	9u4gBQ7DL4PEMFeGF6DWD6WXrRBBWRxOewRvyVBxeDDLUjoSsDg5zdWnDvOTEepjZxnFhohIh9rD+
	NApEFG/gw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqyqf-0006YA-UA; Tue, 05 Feb 2019 11:25:05 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqyqb-0006Hz-5T
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 11:25:02 +0000
Received: by mail-wm1-x343.google.com with SMTP id z5so3195907wmf.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 03:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=lp4C64vaQeuPBNDxASUIsDnoG31EkUl0CanDE2WESiY=;
 b=tgbRU++P6WVvG8WrpVZX9BFuQ4QnjTsDMaM7kCUBAy3jJvIGn9ZHH4pD2UIW1VJkMT
 ayM6aRe9zznGyphHcQMlHZbYkaOnYaVD971FdSc0pU/GeVnFLCfmHjbXXs3ULsQNFCO/
 BhvXKt78SSbUFhcAksWoQDkPkQFectFCrFs9mCV4ZgwI8YBNcRlkmyhjHWmCP/ZrkNO4
 y04m/mujkpOzVR3W/zkkQisL8tNeL224GrKByuxUdelXKphBM9XUhv7po8UE/kQywdmj
 vTlQyLikLFBetYYUT6cuorv0QCpcoIFnKk4dsFa3oxAswqr4giImLeYJPxp4xle6cKJQ
 BzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lp4C64vaQeuPBNDxASUIsDnoG31EkUl0CanDE2WESiY=;
 b=QV30jHQcnELLSsznteldH0Ud4JrsgXZHCnO8eGaGTMhTHl8bUNAIpSrDcIbF5ycTEo
 dfrCl4FzOxshEttgiZG15VQGKigj2lpRFl73uSQhZzMh+dNfeI81ALuMZ+PptczQdGnf
 3MOvd9D2At/kqn+MTSP8hlM4D339l2vYAERoIP7tQdZtHoEmhEo4XarTLwToWjj3exHA
 +53YJCuVx0RR27RKF8Sn2QP2vjFXjWjuk0Mc4K5va6aGKXBHnttyg0eHozizcyXc8PSJ
 DEIu5ZPsi+Ore0OLzh0fWAzPbSYa7R7WfGWSPlIUrKxYbIzwapIf9qO2/1e+v7CwAlqn
 IcoA==
X-Gm-Message-State: AHQUAuavphbv/EHpzgDPaxHZWfR0dxDaPyLEw5NfZHRZMfEMLEd+Vpd3
 Cg8OPjn3MnBRZq7uWgou39X0hg==
X-Google-Smtp-Source: AHgI3IaXLJcsciPEpFpNR8zdKi3pNMebIpqhCiqt4gHpqLeBZRN3ajVegbiORDjgnhiwi+YMzIcxyQ==
X-Received: by 2002:a1c:4681:: with SMTP id t123mr3331944wma.24.1549365899304; 
 Tue, 05 Feb 2019 03:24:59 -0800 (PST)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id c14sm14669526wme.13.2019.02.05.03.24.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 03:24:58 -0800 (PST)
Subject: Re: [PATCH v3 3/3] nvmem: zynqmp: Added zynqmp nvmem firmware driver
To: Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
 mark.rutland@arm.com, michal.simek@xilinx.com, jollys@xilinx.com,
 rajanv@xilinx.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 chinnikishore369@gmail.com
References: <20190206110721.27765-1-nava.manne@xilinx.com>
 <20190206110721.27765-4-nava.manne@xilinx.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <faa21f65-e5ab-52d4-a9be-bee1b2f931ad@linaro.org>
Date: Tue, 5 Feb 2019 11:24:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206110721.27765-4-nava.manne@xilinx.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_032501_327227_5497475A 
X-CRM114-Status: GOOD (  12.62  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 06/02/2019 11:07, Nava kishore Manne wrote:
> This patch adds zynqmp nvmem firmware driver to access the
> SoC revision information from the hardware register.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>

Patch itself looks good to me!

Due to dependency on the "[PATCH v3 1/3] firmware: xilinx: Add 
zynqmp_pm_get_chipid() API" Its better to take this patch from the same 
tree!

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thanks,
srini

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
