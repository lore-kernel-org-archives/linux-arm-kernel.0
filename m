Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEBDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:38:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14252146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a5U+K0MG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFgIH9NI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14252146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=19kXTwvmceUZFPqmc5qfHLZNEVACsOCjM+n5Q6qi6ag=; b=a5U+K0MG5Fb3aV
	X/vmQc4KhuBFbJOkahaNBR7+p9Cx5WFgM2VeYSSkoudbalG+tfxY/nbxtplp8olUtBng0Vt6oFI7u
	6VFUP2bsY3OyWFuoy2XqRU0i4E4ExEJQ34s6ma9nYiuKMsTiYLcjR3iuYIOyEf1lV38kiZs9KVFW8
	uLLonHr0f5e/2QoNhPVgd73R2BFghuCcWwaTq6pKovpBYMNL3m6xcXdmJOiGOVx+JzhAJEFOdpOdb
	+z9AJxb1ZqNe9fYgbIdlnEWwNtgDGjbK4Ex0QVZbrwJ/ZycHOZ18M37lgXLkK8BCdLjeZ6gGJH7NC
	Wj3rq5i43QFMNsAo+OKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSgBt-0007sV-1y; Fri, 30 Nov 2018 10:38:33 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSgBp-0007rb-DJ
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 10:38:30 +0000
Received: by mail-wr1-x441.google.com with SMTP id x10so4767919wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 02:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YuAYie91ImB2WqhzRLQtsGktOjfWDck7ib2uKUhKWk8=;
 b=gFgIH9NIsrKPu4CrMlRZghehBrZiMOZqhSxt0ewudz67pV2cQrV+ZQ4Mw8Yepi+g/o
 fVkYbA++JZDEnMW0waks60/09pkLS11rSVbemb+Mh/0B89v4yqFykAGnNkf6iI3cf5vg
 aAuLRASyxYpPfqMZ8z1G2+pOEczd6VtBG0UzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YuAYie91ImB2WqhzRLQtsGktOjfWDck7ib2uKUhKWk8=;
 b=sW/F2p8xQo8Pln/jNA4oNXi1BKq4z1FU++Gre45pSUaKO4sVvMB72RL0XfPjlx5Fcf
 uKyXb9HhH1nRuObVPsUneRyv6erYhndb9dZJznQzJYyWhppmZXao4Nnxx09TAZQOIoYl
 H3QMisPyULCQCjwEcixeZD9X06LD6JT1sQNh4mawT89WhKadtHhfGN48BhK7dnQlehmT
 84qzQFWsAVu/6fD2lyGTncPomwhyleTun2pSqkLncOV0Ee6J3BtBRt3hXNmH3Fsd4zLm
 Ndh1BrBXBS4GaHkBCzUmRs42AhZNjScn3XzaHKuGtRsiawDZfI0nQQoKjwYuSugcmd4r
 n7ZA==
X-Gm-Message-State: AA+aEWadIobGvCZPzsmQ/LouVu1lwn3la6XNYYtGVoEj1Mvsl6GCmlaZ
 4vRvru2yz0CVisvc6526ye5IoA==
X-Google-Smtp-Source: AFSGD/WkUKNxAatJkQjgvBh3Ku3X41HHm4y2x6cmb45ldwyYqz1xSLV4l/+L1kYXNA1dAO0+JHOz3Q==
X-Received: by 2002:adf:80a9:: with SMTP id 38mr4173858wrl.137.1543574294290; 
 Fri, 30 Nov 2018 02:38:14 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id t5sm4639724wmg.43.2018.11.30.02.38.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 02:38:13 -0800 (PST)
Date: Fri, 30 Nov 2018 10:38:11 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v6 06/24] arm64: ptrace: Provide definitions for PMR values
Message-ID: <20181130103811.lushdja552xevghm@holly.lan>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-7-git-send-email-julien.thierry@arm.com>
 <20181129164013.qmmwhbygjkh5lwx5@lakrids.cambridge.arm.com>
 <79145359-3594-3dac-1123-cec552c2b13e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <79145359-3594-3dac-1123-cec552c2b13e@arm.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_023829_451995_05392FD0 
X-CRM114-Status: GOOD (  29.10  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, christoffer.dall@arm.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com,
 Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 08:53:47AM +0000, Julien Thierry wrote:
> 
> 
> On 29/11/18 16:40, Mark Rutland wrote:
> > On Mon, Nov 12, 2018 at 11:56:57AM +0000, Julien Thierry wrote:
> >> Introduce fixed values for PMR that are going to be used to mask and
> >> unmask interrupts by priority. These values are chosent in such a way
> > 
> > Nit: s/chosent/chosen/
> > 
> >> that a single bit (GIC_PMR_UNMASKED_BIT) encodes the information whether
> >> interrupts are masked or not.
> > 
> > There's no GIC_PMR_UNMASKED_BIT in this patch. Should that be
> > GIC_PRIO_STATUS_BIT?
> > 
> 
> Yep, forgot to update the commit message when renaming, thanks.
> 
> >> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> >> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> >> Cc: Oleg Nesterov <oleg@redhat.com>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> ---
> >>  arch/arm64/include/asm/ptrace.h | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> >> index fce22c4..ce6998c 100644
> >> --- a/arch/arm64/include/asm/ptrace.h
> >> +++ b/arch/arm64/include/asm/ptrace.h
> >> @@ -25,6 +25,12 @@
> >>  #define CurrentEL_EL1		(1 << 2)
> >>  #define CurrentEL_EL2		(2 << 2)
> >>  
> >> +/* PMR values used to mask/unmask interrupts */
> >> +#define GIC_PRIO_IRQON		0xf0
> >> +#define GIC_PRIO_STATUS_SHIFT	6
> >> +#define GIC_PRIO_STATUS_BIT	(1 << GIC_PRIO_STATUS_SHIFT)
> >> +#define GIC_PRIO_IRQOFF		(GIC_PRIO_IRQON ^ GIC_PRIO_STATUS_BIT)
> > 
> > Could you elaborate on the GIC priority logic a bit?
> > 
> 
> Yes, I'll give details below.
> 
> > Are lower numbers higher priority?
> > 
> 
> Yes, that is the case.
> 
> > Are there restrictions on valid PMR values?
> > 
> 
> Yes, there are at most 8 priority bits but implementations are free to
> implement a number of priority bits:
> - between 5 and 8 when GIC runs two security states (bits [7:3] always
> being implemented and [2:0] being optional), but non-secure side is
> always deprived or the lowest implemented bit
> - between 4 and 8 when GIC runs only one security state (bits [7:4]
> implemented, bits [3:0] optional)
> 
> This is detailed in section 4.8 "Interrupt prioritization" of the GICv3
> architecture specification.
> 
> So Linux should always be able to see bits [7:4].
> 
> > IIUC GIC_PRIO_IRQOFF is 0xb0 (aka 0b10110000), which seems a little
> > surprising. I'd have expected that we'd use the most signficant bit.
> > 
> 
> So, re-reading the GICv3 spec, I believe this sparked from a confusion...
> 
> The idea was that the GICv3 specification would recommend to keep
> non-secure group-1 interrupts at a lower priority that group-0 (and
> secure group-1 interrupts) interrupts, and to do so the idea was to
> always keep bit[7] == 1 for non-secure group-1.
> 
> So, we would need to have priority bit[7] == 1 for both normal
> interrupts and pseudo-NMIs, and using the most significant bit to mask
> would mean masking pseudo-NMIs as well.
> 
> However, I only find mention of this in the notes of section 4.8.6
> "Software accesses of interrupt priority". The section only applies to
> GIC with two security states, and the recommendation of writing
> non-secure group-1 priorities with bit[7] == 1 is only directed at
> writes from the secure side. From the non-secure side, the GIC already
> does some magic to enforce that the value kept in the distributor has
> bit[7] == 1.
> 
> So, I believe that from the non-secure point of view, we could define
> pseudo-NMI priority as e.g. 0x40 (which the GIC will convert to 0xa0)
> and use the most significant bit of PMR to mask normal interrupts which
> would be more intuitive.
> 
> Marc, as GIC expert do you agree with this? Or is there a reason we
> should keep bit[7] == 1 for non-secure group-1 priorities?

I think selecting bit 6 dates back to when I was working on this.

I originally used bit 7 but switched due to problems on the FVP at the
time (my memory is a little hazy here but it felt like it wasn't
doing the magic shift properly when running in non-secure mode).

Once the patchset was running on real hardware I kept on with bit 6 
figuring that, given the magic shift from non-secure mode is a little
odd, it would remain furtile soil for future silicon bugs (I was
watching a lot of patches go past on the ML working round bugs in
non-Arm GIC implementations and ended up feeling rather paranoid
about things like that).


Daniel.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
