Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBB0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:04:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678C7206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AoYAD/1v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JhmsGrB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678C7206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jL72X6vkZ+sHjzg0Fk7oJiN1qg3ufT+iaBUy8gG06ig=; b=AoYAD/1vJb1nRm
	tWhiQWytvGLQHZV5gg5Ye/ICj9l0NgJ2Xu2ADj64PPdGimrAlXrHW4npFwo+kzAhNwu3NZRVCIt1c
	kcUz6W9a/zGzbhLbYbnPQbAttThHGThi80a3SMCGp6QYIIr47tH75Foz7zrQkrJNlvwBITO3gykU6
	WfAOPWOmuv/wxfE43Y2VqOs+e+V16bGaQ6cQ3AwE5EF9wL3u5hi+1aTxQWHIRNPHJbgLQtnBX4d3G
	6w7rB0ypQlc6PR7/fqQq6qilbLpUfr1fUCzGcTqkVNH4SjP1oEcEqzYtE+uMrfbTQGiXPcRlkNYua
	sCEfODc0KC2D+eUHmBjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxH3c-00010k-Ub; Fri, 22 Feb 2019 20:04:28 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxH3Z-00010G-WA
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 20:04:27 +0000
Received: by mail-pl1-x643.google.com with SMTP id s1so1549233plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 12:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A5Zzp3PsBc3z3BPM6HhQqIQiRkTNg4Jv6/4olyOrBIk=;
 b=JhmsGrB6gc3sCymrEivdhcFd0QDU98+TOGTgk+kAzrZHjR7t6TiQNPswnLMlGI0qln
 U0fS55+sgKV20VnPtX0kWM3F6LElGgOpIYXmGfrPRN3xEduOrtyB1XLiQ0P8AszO8KEB
 FACCBlP7JKJD31dtvhBMzOB/fCZLpCNcyJmaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A5Zzp3PsBc3z3BPM6HhQqIQiRkTNg4Jv6/4olyOrBIk=;
 b=OwoOvVx6NzL1NX8YxyBr3Z/X6+hNqXJg74mD4kKF5vVUpMSJGmzxpEaACtcTqKlz//
 s7Pgs1QD2Vwg9TO7A1elOsR1HOmQCuxvg+Zszkp3/mDgdgl39HwuXT0oaclZU4wraZlo
 1odJIbrqMmWEMB7/PTVHs2mYE5vSWS18izWVRL0HKy0npnCnxmP/LBqQVFs40oVd5IrP
 LtiL/i6xtRa3yXtSH0YHVCtPeD+mqLcR+gUU/eR2U+t99Sl9jBEitwGsPnLWMjcXYxAO
 VFl1uAnr56/uu/Qvs5nT1DNFOv6E16I23YMOLaRwdR6vh14D3QPCnjaEsw2P+ePSQGkt
 FA1Q==
X-Gm-Message-State: AHQUAubDDYqvEq/CLc6loAoTCsFdDg5pv8XY+YBJnFHqHSYiEByLzI+i
 hD4hJZot2EonolYGK8O5ctCsNw==
X-Google-Smtp-Source: AHgI3IaioMA/PqujokcGC/yCsW/lZjzS2fRRhWJfvQxbVFeUNA5V55Sj/yDL9tZwiI0wBQ+pZnNhEQ==
X-Received: by 2002:a17:902:1027:: with SMTP id
 b36mr5944622pla.339.1550865864862; 
 Fri, 22 Feb 2019 12:04:24 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id p6sm3596621pfp.15.2019.02.22.12.04.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 12:04:24 -0800 (PST)
Subject: Re: [PATCH v5 0/8] iProc I2C slave mode and NIC mode
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <5c5ed177-0e9e-6271-518c-6956a7a6c554@broadcom.com>
Date: Fri, 22 Feb 2019 12:04:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_120426_043960_1D876802 
X-CRM114-Status: GOOD (  16.89  )
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
Cc: devicetree@vger.kernel.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Wolfram,

Rob has reviewed all DT binding related changes from this patch series.
Could you please help to review the I2C driver related changes when you
have time?

Thanks,

Ray

On 2/14/2019 9:57 AM, Ray Jui wrote:
> This patch series adds the following support to the iProc I2C driver:
> - Increase maximum read transfer size to 255 bytes
> - I2C slave mode
> - Polling mode
> - NIC I2C mode
> 
> This patch series is based on kernel v5.0-rc3 and available at:
> https://github.com/Broadcom/arm64-linux.git
> branch: i2c-slave-v5
> 
> Changes from v4:
>  - Add more detailed explanations in the device tree binding document
>    changes, to address Rob's review comments
> 
> Changes from v3:
>  - Various minor fixes on commit messages and commits
>  - Rebased to v5.0-rc3
> 
> Changes from v2:
>  - Address Ray's review comments.
> 
> Changes from v1:
>  - Rebased to Linux v5.0.0-rc2
> 
> Ray Jui (1):
>   dt-bindings: i2c: iproc: make 'interrupts' optional
> 
> Rayagonda Kokatanur (5):
>   i2c: iproc: add polling support
>   i2c: iproc: use wrapper for read/write access
>   dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
>   i2c: iproc: add NIC I2C support
>   arm64: dts: Stingray: Add NIC i2c device node
> 
> Shreesha Rajashekar (2):
>   i2c: iproc: Extend I2C read up to 255 bytes
>   i2c: iproc: Add slave mode support
> 
>  .../bindings/i2c/brcm,iproc-i2c.txt           |  17 +-
>  .../boot/dts/broadcom/stingray/stingray.dtsi  |  18 +
>  drivers/i2c/busses/Kconfig                    |   1 +
>  drivers/i2c/busses/i2c-bcm-iproc.c            | 758 +++++++++++++++---
>  4 files changed, 663 insertions(+), 131 deletions(-)
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
