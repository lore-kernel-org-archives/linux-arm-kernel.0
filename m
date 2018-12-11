Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25877C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:40:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA76620849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GzNPPoL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA76620849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pvSMlK8ELTUOBEr7zaRGLRGAyohy8ut2dOxy4t+XzcY=; b=GzNPPoL1hyUMfe
	TWgnHJxfsh83NIe88qJ5ObRoWajgW308OCchugduIj5TEe5CxlZX1IlN7XUqBhuwBNO75MR4lIxqe
	vom2nbDk1B5ZVAeklC+FW/+KWhkH9sJjziW/0SBjupYn3VBluw0okujKlKFFjk60Wn4AxDg/sSydY
	IdYEjJQJEK98OnlHjWbBm2UzOslBA58RoWecwwid5Xy77I02NGVV8qXnf/qHnOHfHWNSAz5Km3m8F
	XGdGMzuNOvdrztfP0lL97OSZCEFxW88z3G9VUg9o+XSu0eOZR6DADxMrKat6kl0FPc58g+vpNd/mu
	lSEHS+x7WFkDrmTji57Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWiH9-00079y-N0; Tue, 11 Dec 2018 13:40:39 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWiGq-00068I-GH
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 13:40:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C9BB1596;
 Tue, 11 Dec 2018 05:40:09 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAF573F59C;
 Tue, 11 Dec 2018 05:40:08 -0800 (PST)
Date: Tue, 11 Dec 2018 14:40:07 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v7 2/5] arm64: KVM: encapsulate kvm_cpu_context in
 kvm_host_data
Message-ID: <20181211134007.GZ30263@e113682-lin.lund.arm.com>
References: <1544530420-1477-1-git-send-email-andrew.murray@arm.com>
 <1544530420-1477-3-git-send-email-andrew.murray@arm.com>
 <20181211122951.GY30263@e113682-lin.lund.arm.com>
 <20181211131127.GE13393@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211131127.GE13393@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_054020_976998_2D18F69C 
X-CRM114-Status: GOOD (  25.71  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Julien Thierry <julien.thierry@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 01:11:33PM +0000, Andrew Murray wrote:
> On Tue, Dec 11, 2018 at 01:29:51PM +0100, Christoffer Dall wrote:
> > On Tue, Dec 11, 2018 at 12:13:37PM +0000, Andrew Murray wrote:
> > > The virt/arm core allocates a percpu structure as per the kvm_cpu_context_t
> > > type, at present this is typedef'd to kvm_cpu_context and used to store
> > > host cpu context. The kvm_cpu_context structure is also used elsewhere to
> > > hold vcpu context. In order to use the percpu to hold additional future
> > > host information we encapsulate kvm_cpu_context in a new structure.
> > > 
> > > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > > ---
> > >  arch/arm64/include/asm/kvm_host.h | 8 ++++++--
> > >  arch/arm64/kernel/asm-offsets.c   | 3 ++-
> > >  virt/kvm/arm/arm.c                | 4 +++-
> > >  3 files changed, 11 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > > index 1550192..bcf9d60 100644
> > > --- a/arch/arm64/include/asm/kvm_host.h
> > > +++ b/arch/arm64/include/asm/kvm_host.h
> > > @@ -205,7 +205,11 @@ struct kvm_cpu_context {
> > >  	struct kvm_vcpu *__hyp_running_vcpu;
> > >  };
> > >  
> > > -typedef struct kvm_cpu_context kvm_cpu_context_t;
> > > +struct kvm_host_data {
> > > +	struct kvm_cpu_context __kvm_cpu_state;
> > > +};
> > > +
> > > +typedef struct kvm_host_data kvm_cpu_context_t;
> > 
> > Now I'm confused based on the conversation on the last version.
> > 
> > I think it's bizarre to use the typedef to rename things in this way.
> > 
> > Can you please make this:
> > 
> >    struct kvm_cpu_context;
> >    typedef struct kvm_cpu_context kvm_cpu_context_t;
> > 
> >    struct kvm_host_data;
> >    typedef struct kvm_host_data kvm_host_data_t;
> > 
> > And change the code with the fallout from that.
> 
> I guess I was trying to avoid similar naming issues on arm32. If we
> make the above changes (and thus the DEFINE_PER_CPU in virt/kvm/arm/arm.c)
> then we need to change arm (arch/arm/include/asm/kvm_host.h) such that:
> 
> typedef struct kvm_cpu_context kvm_cpu_context_t;
> 
> becomes:
> 
> typedef struct kvm_cpu_context kvm_host_data_t;
> 
> though I guess this may be acceptable?

I'd prefer it if you just introduce a struct kvm_host_data on the 32-bit
side only containing a struct kvm_cpu_context (if you wanted to support
perf on the 32-bit side you would also add additional fields to it,
similar to arm64).  That avoids the confusing typedef and you get the
symmmetry on both architectures allowing you to use shared code, which
is what we want at the end of the day.

So, on the 32-bit side, change this to:

struct kvm_host_data {
	struct kvm_cpu_context *host_ctxt;
};
typedef struct kvm_host_data kvm_host_data_t;


And use the same naming on both 32-bit and 64-bit arm, consistently.


Thanks,

    Christoffer

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
