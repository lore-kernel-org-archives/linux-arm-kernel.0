Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AE4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 01:54:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6067F206E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 01:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jdALAbdC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="O4lVycTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6067F206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OOwsRP+fkiqlcGX27bHoqq9kzQgmCKBH3eDdTPMJ/wI=; b=jdALAbdCTfZakD
	AC5yrBtFRctjq4CNCftGTe//dkD8pKrS3eJsY6TbHtrShQe7QBBlX581zBHx221hLqIC3IunFWrAb
	ho9BAphzVZKyMfBCoWsvmK7mqiNS3disKtGE7hAlxHdmWE6k/7EwzAjnF2OPX4RXcGP9CLbgjrmQv
	Io1k+dXn288K644aXvcMgKXclukwEflHfXa9H6m78pzp9i0vhf9yfOs8ajwEfB1XJLM3ij2xQrbFP
	IXrBnUj45Q1XXZIY8Y0ELrh5/8A0Iz5d/C9GnUdajuz0yJIM6b0r3+QRH/P8aFWdV8tEDWep3xKMu
	msWtpYSYoQpTSwfuaU6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXz9a-0001ES-Op; Sat, 15 Dec 2018 01:54:06 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXz9V-0001Cn-Ft
 for linux-arm-kernel@lists.infradead.org; Sat, 15 Dec 2018 01:54:03 +0000
Received: by mail-qt1-x843.google.com with SMTP id e5so8314146qtr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 17:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5fLN/04WiJj7PmtbOE2x1OBSl08T5I2Ie0RV1VKgEUE=;
 b=O4lVycTGef9WbcDjIsKfE3bJhLwq67YI4yLwUOWamvak6Uiw8KPHpqQ+dhDX/c3J9R
 Nqb2iriXc3X/rmKaP9ORc4a+ixfnc9Z1V0RLEvJmWJDO2WpB83WPNHPTK5kzL59ugbnK
 aUWi73JGF9hYhNlR9osQuDe7aduYqIW0zBTHvxOcMGaaTopr7eCZ1B3vNjc/VmG5dhZn
 ZXtDtAYCLN4luInbAMA8axm3ounsd2CEXjPZ4l/JbKMXECpxPVvqYrueln3WZ2kwZ1TS
 3+OJHQX6nXbGoGQSpG1RvBbGmqlPZVAHhdYy+mdF5kRM3SFgm0LVF9jvbrWg5Dogh/Yl
 nF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5fLN/04WiJj7PmtbOE2x1OBSl08T5I2Ie0RV1VKgEUE=;
 b=Z/t84vA860vv5P41bAaKRPHehdwWRVXNIeWo6KdQEi5xCxyHNbHqw8gp55LB8QbKSb
 LG5UNqFJ1xUVvdbjreCvvxw9XQsil1v3JM6K3D3K6Iuv80ydcbrMSThRuh7jeiQUy4eo
 QRyimh/O8B/TPsQ8vdgLIYAmSJhpZrMv1aTDzF8rkMjPhswRXgovTWS3aOfABY8u7aBY
 lQdbQqH0GtJaxcRVxbqAHoNB58DE/Z4HrFaSOMYQKRLtmjfAYWvmxzVwA0VGBQb1Sltb
 FAmYBRUDHf+iOBz3XbJ5PBWpnr5Bf+DDEnMYeN5QwAON/VwyEGYIYlt9WzrgF4KaSndm
 UanA==
X-Gm-Message-State: AA+aEWbTxn1T6esaIvwfJ1vz4n07P18lG9ewkQCrBSw+EhOY6KjtfWaR
 PGg8TKEstCjTkcwdyNhmgEbRGQ==
X-Google-Smtp-Source: AFSGD/VCujxlpKTzIYUw7Q8DIO29P5UGCS9zMFKfbPXpQ3hwDbOqLJsd90b5eSTwIWSVaEV0c/R2tQ==
X-Received: by 2002:ac8:498c:: with SMTP id f12mr5147743qtq.130.1544838829975; 
 Fri, 14 Dec 2018 17:53:49 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id j36sm4097194qtk.15.2018.12.14.17.53.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 17:53:49 -0800 (PST)
Subject: Re: [PATCH v2] arm64: invalidate TLB just before turning MMU on
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20181213052259.56352-1-cai@lca.pw>
 <20181214040819.58625-1-cai@lca.pw>
 <CAKv+Gu80cxx6L3KYyYnsyjbrWN6iTp76jcdBio27b_h+dAzaHw@mail.gmail.com>
From: Qian Cai <cai@lca.pw>
Message-ID: <bea04814-25d2-7bb2-0f74-0530fcd54210@lca.pw>
Date: Fri, 14 Dec 2018 20:53:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu80cxx6L3KYyYnsyjbrWN6iTp76jcdBio27b_h+dAzaHw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_175401_622618_FB579537 
X-CRM114-Status: GOOD (  17.18  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>,
 Kexec Mailing List <kexec@lists.infradead.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/14/18 2:23 AM, Ard Biesheuvel wrote:
> On Fri, 14 Dec 2018 at 05:08, Qian Cai <cai@lca.pw> wrote:
>> Also tried to move the local TLB flush part around a bit inside
>> __cpu_setup(), although it did complete kdump some times, it did trigger
>> "Synchronous Exception" in EFI after a cold-reboot fairly often that
>> seems no way to recover remotely without reinstalling the OS.
> 
> This doesn't make any sense to me. If the system gets into a weird
> state out of cold reboot, how could this code be the culprit? Please
> check your firmware, and try to reproduce the issue on a system that
> doesn't have such defects.
> 

I'll continue investigating those "Synchronous Exception" although it is kind of
hard due to I don't have any source code of the firmware to confirm it is buggy
or not.

I did manage to reproduce this kdump issue on around 5 of those server running a
fairly recent version of the firmware (07/01/2018). I don't have access to other
large CPU machines.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
