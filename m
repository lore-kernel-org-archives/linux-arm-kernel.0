Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5889C31D63
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 06:06:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15FE21841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 06:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ehERc27i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R7n5C9wP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15FE21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gTpo+zo4trci21mZO3VzNAVZIl2mzjrrV9ycoBezlco=; b=ehERc27ihKshKw
	DVb/LJ09ziAtfEjHlGKWYidZ6Kvzh7H5ikX/cvnfrCQ5EiyVTEtI8d50acXzCCvsHlnuiyNLmAyGc
	jYM/y5QcFW4JGw82DnmHjaXT2iSYIwMoJG+xfoE8oyiNyv9QGcurbJzRiHbyFgQ6zixE22x+p8JYN
	7oJxK/C+/yH6rfOZDdutCjxE42wbqeIh36BiwJvIVzTbuc884V7ZpKoduU1E1ceawF0B9D5FQwPz1
	vHJOjAIlr9q3DoaemZDECUuaa359BquRpuySk8M3rrDPIiEzzJqyBQ3wKMG17Daigx0Tjk3rUKiD6
	dFSIsJO+GF7KGTbKVzUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glSjA-00074h-GI; Mon, 21 Jan 2019 06:06:32 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glSj4-00074B-KL
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 06:06:30 +0000
Received: by mail-oi1-x243.google.com with SMTP id y23so13652114oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 22:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vg4RDLLwAO/ZYWTbu5ufyFQvbdsjKMMEhcfj2Et8fZw=;
 b=R7n5C9wPJqcRHAH58fdUkrMLVF2BQlTrO6/tHDAen3PH27aklixcldVhKCPIuIt3Hv
 O44AdDiI+usunEUzUfM/KEz6Ewc6iXQadlOUBD0RuMEQ2iO3R6RU/N7qZlGjqmcb3Uzd
 FvSi0ZgFKt0XW1Z+nsZJ1uq+Lj7LI1IWCOJYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vg4RDLLwAO/ZYWTbu5ufyFQvbdsjKMMEhcfj2Et8fZw=;
 b=es8bwWa59RCABC9zJcZ6jauA1JyZIfMGdslEa+Fvm4Lp6Alp2RPVJ2bNYJRjoCw7L5
 Wj+LobQlaUTUUPlNhdxtgAxyIO5Y04Hz1uzpOM2z+JAG7JM6vbTDddlkaBNuqSwEJ3Z2
 DyGmGLq3GtC+xaSuigpA4DMbwaY2ERAkQ2it/uTxKjeg7gdxmv3HB4ygi1BEML0sg18X
 s035WoX8xcq8fNNRKF+MiIWOE6o2LHnd+DVXSd0jmYzKoOLzIRdKPOo8D8pdeUI1Hn8J
 gMSZSsjlKuUIfchb1mBd3ubFQBsbB3EtlNHUyisE0VVeiymTgjJzNo/FpWa/3q+uj+Ui
 b+Gw==
X-Gm-Message-State: AJcUukcHyhp20n4jnftOpgZQl9En6uih8iK7VcpbM4jDLBjbB20ObBCf
 OV/UWLPe7DRiejwKAz64hp1mD5RShTyovl/YZr85Cg==
X-Google-Smtp-Source: ALg8bN4F0pcfbFggIJYSTWnvxuYe2BGog1pCpni1CMPuW/uWqLyLdGrlNPCPje7GYXrCe4zu6FjFeKHz6rxdHfh7KRA=
X-Received: by 2002:aca:2116:: with SMTP id 22mr4977922oiz.42.1548050785511;
 Sun, 20 Jan 2019 22:06:25 -0800 (PST)
MIME-Version: 1.0
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin>
 <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
 <CAJ+tv6KqynSf5t_VwLqpdM4BF+wLWcJ0wPTD4nWqL4ej1Yih4g@mail.gmail.com>
In-Reply-To: <CAJ+tv6KqynSf5t_VwLqpdM4BF+wLWcJ0wPTD4nWqL4ej1Yih4g@mail.gmail.com>
From: Pramod Kumar <pramod.kumar@broadcom.com>
Date: Mon, 21 Jan 2019 11:36:14 +0530
Message-ID: <CAJ+tv6+q+GzBXyv3DH=vX+bc+62YMUCfH7vYLNssyRzBzx6zFA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
To: Sudeep Holla <sudeep.holla@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_220627_109775_F56D0429 
X-CRM114-Status: GOOD (  15.60  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Steve Capper <steve.capper@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 11:30 AM Pramod Kumar <pramod.kumar@broadcom.com> wrote:
>
>
>
> On Mon, Jan 21, 2019 at 11:28 AM Pramod Kumar <pramod.kumar@broadcom.com> wrote:
>>
>> Hi Sudeep,
>>
>> Thanks for having a glance on the patch. Please see my reply in line.
>>
>> Regards,
>> Pramod
>>
>> On Fri, Jan 18, 2019 at 5:02 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>> On Fri, Jan 18, 2019 at 11:16:20AM +0530, Pramod Kumar wrote:
>>> > If CPU hotplug is supported, ipi_cpu_stop should use PSCI cpudie
>>> > call to stop the CPU. This call ensures L1/L2 cache flush,
>>> > CPUs cache-cohenrecy setting w.r.to interconnect.
>>> >
>>>
>>> Firstly, this is not specific to PSCI and I don't see any PSCI calls as
>>> $subject claims.
>>
>>
>> I had seen all the other cpu ops methods where only PSCI supports only cpu_die features hence
>> used PSCI reference in my subject line to be more clear where this die gets converted in last.
>>
>>>
>>> Next, you fail to explain why do you have to ensure
>>> caches are cleaned and why do you need that in ipi_cpu_stop ?
>>> What's the use case ?
>>>
>>
>> Need comes from a specific use case where one Accelerator card(SoC) is plugged in a sever over a PCIe interface.  This Card gets supply from a battery, which could provide very less power for a very small time, in case of any power loss. Once Card switches to battery, this has to reduce its power consumption to its lowest point and back-up the DDR contents asap before battery gets fully drained off.
>>
>> Since battery can provide limited power for a very short time hence need to transition to lowest power. As per the transition process , CPUs power domain has to be off but before that it needs to flush out its content to system memory(L3) so that content could be backed-up by a MCU, a controller consuming very less power. Since we can not afford plugging-out every individual CPUs in sequence hence uses  ipi_cpu_stop for all other CPUs which ultimately switch to ATF to flush out all the CPUs caches and comes out of coherency domain so that its power rails could be switched-off.
>>
>>>
>>> > Apart from this, this gives control to f/w to reduce power consumption
>>> > by take appropriate decesion on power rails for plugging-out core.
>>> >
>>>
>>> May be, but ipi_cpu_stop is used is machine reboot/poweroff/halt which
>>> may restart or poweroff the system, powering down individual CPUs is not
>>> necessary and may consume lot of time in systems with large number of CPUs.
>>> It would be good to know the use-case in case I am missing to consider
>>> that.
>>
>>
>> Use case as explained above.
>>
>>>
>>> --
>>> Regards,
>>> Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
