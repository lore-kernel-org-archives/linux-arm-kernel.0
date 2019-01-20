Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F043CC282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 21:50:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D65214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 21:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VlWkn50u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OyNOrfXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D65214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Npb9ozqCVucNO0HZJB2OQUq72N71d9Yl+nUU9Aoz8fc=; b=VlWkn50un00T3E
	GQ4Dq6emetc6j5cmw+eQIGgXHDuQ5L1YwfQy6X63nMm/23IB9MEC1tCZzrYpBgVAT/zUE/9M8uRce
	/mR0kq/34cd2gcQZx4wPWZ954hu68pYcz+fxMIiu03SLBsAsrqsQp7BYO5fDZgaQeJPTjLZ69fBc5
	LONzFY4WZvtIbiEg6koCprzvbm92YDm3DQUD5SVebz2AlITgHuvEaq5+MtXBOPY2nJHNC7PBaosqo
	36/F95/1npsRfO/ktoOC5EAUW/9+C9Vge6LYASlJwSpvRWGTRNXQj9okbA04WvrI9gEzmMfINziI3
	bVA566YZbprjCaGNZVCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glKyr-0005Jp-Ai; Sun, 20 Jan 2019 21:50:13 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glKym-0004mH-3N
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 21:50:12 +0000
Received: by mail-ed1-x543.google.com with SMTP id b3so15209170ede.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 13:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dazpabB+cJDgmqjbKILU5ER9btyscoPtFMMvH2bA99g=;
 b=OyNOrfXFu6ry9Lez7TQ5UiEsSfwhFV+YoYZfixvZszu/L8O7JARXPS7rVyRp48mHgf
 abJfhN0SmF/+I4YWobukc/kUNT9Y3l3WA8Nr6h7+B9YKYergeesdasqllGl9bLKL3Wio
 Zme5pHiDVbIcr2i5E2ABFeApwXbgn/WN3JjOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dazpabB+cJDgmqjbKILU5ER9btyscoPtFMMvH2bA99g=;
 b=GLUfx7AX4PINbgUydox4jOkJTPwunhZgomyBj+dxpsWtq7qKo/UPbLGl6r6az1iZNA
 A5+TPSVX0mVeTdL+DTg1q8zoFvv3+1n/WVlsYhsMqpzwyaayizgQlwlYBQn2O0rvHP6S
 QmzKkVf7u65N19YjYb6u0yDsL0U8AW94jR8Qk3aUWHl59XnLhmPWlxIduQpCwtHTmMT8
 qfpZNwU+rpuFtUpFKQCpxUWc9g7oHrmH7NFLRjlx2i4E1H/SU3kL/GkBZz+ODwpM0n3+
 NXx6zHPUBIn/09YlUn3Il0YCqIfaaYqBJI3ZYI/bAM70X3ATLEijY+tGvRgu7R7gDVUr
 g0Eg==
X-Gm-Message-State: AJcUukdrVJ8Qe9WIORBQuQ5XsgLeAFd6rIRFuuPsbNV+YJPKwVgB5x/V
 yZV1ssbiJRiululttLamGq7iew==
X-Google-Smtp-Source: ALg8bN6hFhMXNCMUuNlpXn35GQLk2gZ4gtCbJuM0QHJbLPj/uMlbNy+MXRrw03OW38VIhkiL+D/7vA==
X-Received: by 2002:a17:906:33d9:: with SMTP id
 w25-v6mr22327320eja.190.1548021006089; 
 Sun, 20 Jan 2019 13:50:06 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id p16-v6sm4730867eju.73.2019.01.20.13.49.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Jan 2019 13:50:04 -0800 (PST)
Subject: Re: [PATCH v3 0/8] Add IPROC I2C slave mode and NIC I2C support
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, rjui@broadcom.com
References: <1547791464-3540-1-git-send-email-rayagonda.kokatanur@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <e658ce66-98e3-3ca6-5786-56bfea6d176e@broadcom.com>
Date: Sun, 20 Jan 2019 13:49:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547791464-3540-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_135008_149325_7A77AFB2 
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
Cc: mark.rutland@arm.com, heikki.krogerus@linux.intel.com, vigneshr@ti.com,
 ajayg@nvidia.com, wsa@the-dreams.de, rayagonoda.kokatanur@braodcom.com,
 aaron.wu@analog.com, pierre-yves.mordret@st.com, kramasub@codeaurora.org,
 linux-i2c@vger.kernel.org, manivannan.sadhasivam@linaro.org, jdelvare@suse.de,
 f.fainelli@gmail.com, eajames@linux.vnet.ibm.com,
 shreesha.rajashekar@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 geert@linux-m68k.org, devicetree@vger.kernel.org, arnd@arndb.de,
 robh+dt@kernel.org, ccheng@broadcom.com, andriy.shevchenko@linux.intel.com,
 mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org,
 sbranden@broadcom.com, ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
 jarkko.nikula@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rayagonda/Wolfram,

I reviewed the entire patch series and added my Reviewed-by tag on 1/8
and 2/8. The rest of the patches in this series already had my
Signed-off-by tag.

Thanks,

Ray

On 1/17/2019 10:04 PM, Rayagonda Kokatanur wrote:
> Hi,
> This patchset contains support for IPROC I2C slave and NIC I2C support.
> Following are the brief changes done inorder to support both IPROC I2C
> slave mode and NIC I2C,
> 
> a. Add support to allow I2C rx transfer upto 255 bytes
> b. Add polling mode support to the iProc I2C driver. Polling mode is used
>    in certain SoCs where interrupt is not connected from the I2C block.
> c. Add warpper read/write access for register to support indirect register
>    access. This is required in certain SoCs with this iProc I2C
>    block registered.
> d. Remove the set RESET bit to LOW right after setting it to HIGH so that
>    wait duration can be met.
> 
> This patch series is based on kernel v5.0.0-rc2.
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
>   i2c: iproc: I2C read up to 255 bytes support
>   i2c: iproc: Add Slave mode support
> 
>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt     |  14 +-
>  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  18 +
>  drivers/i2c/busses/Kconfig                         |   1 +
>  drivers/i2c/busses/i2c-bcm-iproc.c                 | 757 +++++++++++++++++----
>  4 files changed, 659 insertions(+), 131 deletions(-)
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
