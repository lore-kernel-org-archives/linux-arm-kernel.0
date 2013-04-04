From: geoff@infradead.org (Geoff Levand)
Date: Thu, 04 Apr 2013 15:10:53 -0700
Subject: [PATCH 6/7] ARM: KVM: switch to a dual-step HYP init code
In-Reply-To: <1364909115-3810-7-git-send-email-marc.zyngier@arm.com>
References: <1364909115-3810-1-git-send-email-marc.zyngier@arm.com>
 <1364909115-3810-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <1365113453.24496.26.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2013-04-02 at 14:25 +0100, Marc Zyngier wrote:
> +	@ Jump to the trampoline page
> +	ldr	r2, =#PAGE_MASK
> +	adr	r3, target
> +	bic	r3, r3, r2
> +	ldr	r2, =#TRAMPOLINE_VA
> +	add	r3, r3, r2
> +	mov	pc, r3

I guess you need 'ldr r2, =PAGE_MASK'.

  arch/arm/kvm/init.S:114: Error: bad expression -- `ldr r2,=#(~((1<<12)-1))'
  arch/arm/kvm/init.S:117: Error: bad expression -- `ldr r2,=#0xffff0000'

-Geoff
