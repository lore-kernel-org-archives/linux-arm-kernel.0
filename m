Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E940BC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:23:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A6420851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mI0ehSl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A6420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ewj/d3Na1l2eYxuAcSlJ/63Bs2Te8mOpsauHFyTcn+I=; b=mI0ehSl0wVpmm2
	JHAedJLYgJ+Ly7efe2bEsG106mI2cDyI07f6HZGL/mbg6WQNkLD6dBNv3idwkSOy9Y8VqGGBwCI32
	V5dy8zCq7QyOE2jIJHcA7V5TygAEwTK00c7Cr2u6SJN2ysmBIdUlSFvCk2UitpgZpDk3OHC2SpHub
	SEwFu9mN88vfsojLh+Jvhft8ECJHOt2+sbfbwWu8YcZo05FiZoCmd9J/u0UzPNmYaiQWfBcy/Rl7Y
	V4UIJYcPTM1Y3OXpOXgUaoOzuaOW2kfsSrOO0utnhcRYzOpNH/CdjRRTdfYlaQkFsR30g68abn6h5
	ufdyQ6Afq/CHZQTldODQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlkj-0001cL-GD; Tue, 11 Dec 2018 17:23:25 +0000
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWlkg-0001c2-La
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 17:23:24 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: gtucker) with ESMTPSA id 82F4C263B43
Subject: Re: next/master boot: 175 boots: 18 failed, 143 passed with 10
 offline, 1 untried/unknown, 3 conflicts (next-20181211)
To: Mark Brown <broonie@kernel.org>, John Garry <john.garry@huawei.com>
References: <5c0fb738.1c69fb81.f62ad.3f45@mx.google.com>
 <20181211152311.GK6686@sirena.org.uk>
 <e6995b4a-184a-d8d4-f4d4-9ce75d8f47c0@huawei.com>
 <20181211165031.GN6686@sirena.org.uk>
From: Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <438f8690-f961-453f-e98b-7b93bf55d1c6@collabora.com>
Date: Tue, 11 Dec 2018 17:23:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181211165031.GN6686@sirena.org.uk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_092322_832316_F0C3EBD3 
X-CRM114-Status: GOOD (  12.32  )
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
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 kernel-build-reports@lists.linaro.org, catalin.marinas@arm.com,
 will.deacon@arm.com, Wei Xu <xuwei5@hisilicon.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11/12/2018 16:50, Mark Brown wrote:
> On Tue, Dec 11, 2018 at 04:24:10PM +0000, John Garry wrote:
>> On 11/12/2018 15:23, Mark Brown wrote:
>>> On Tue, Dec 11, 2018 at 05:10:16AM -0800, kernelci.org bot wrote:
> 
>>>>     defconfig:
>>>>         hip07-d05:
>>>>             lab-collabora: new failure (last pass: next-20181210)
> 
>>> It takes an oops during IPMI initialization:
> 
>> I have seen this issue previously. It would be specific to D05. I think that
>> there is an issue with the FW in this board, in that DMI reports IPMI
>> support incorrectly.
> 
>> Could we add a kernel command-line to avoid IPMI detection from DMI,
>> ipmi_si.trydmi=0

Sure, I'll add this extra command line option to the device
config now.  Please let me know if a new firmware becomes
available with a fix and we'll upgrade.

> Copying in Guillaume who can hopefully help with that (and who I
> should've copied in originally, sorry).

No worries.  Actually there was also an automated bisection
submitted for this regression, but the d05 has some intermittent
firmware errors so it didn't land on a valid commit.  There might
be another issue separate from the one with IPMI, I'm improving
the bisection to deal with infrastructure errors that happen
before the kernel starts so we might get some news if the d05
still fails even with the ipmi work-around.

Guillaume

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
