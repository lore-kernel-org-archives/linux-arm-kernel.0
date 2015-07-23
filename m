From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Jul 2015 13:35:53 +0100
Subject: [PATCH 3/3] ARM: errata 430973: move !ARCH_MULTIPLATFORM to
 Kconfig
In-Reply-To: <1437612483-30160-4-git-send-email-sre@kernel.org>
References: <1437612483-30160-1-git-send-email-sre@kernel.org>
 <1437612483-30160-4-git-send-email-sre@kernel.org>
Message-ID: <20150723123553.GE7576@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 23, 2015 at 02:48:03AM +0200, Sebastian Reichel wrote:
> Having the !ARCH_MULTIPLATFORM dependency in the Kconfig file results
> in one option less to think about when configuring the kernel.

> -#if defined(CONFIG_ARM_ERRATA_430973) && !defined(CONFIG_ARCH_MULTIPLATFORM)
> +#ifdef CONFIG_ARM_ERRATA_430973
>  	teq	r3, #0x00100000			@ only present in r1p*
>  	mrceq	p15, 0, r0, c1, c0, 1		@ read aux control register
>  	orreq	r0, r0, #(1 << 6)		@ set IBE to 1

NAK.  Please read the mailing list history, I'm not repeating myself
again on this.  Thanks.

-- 
FTTC broadband for 0.8mile line: currently@10.5Mbps down 400kbps up
according to speedtest.net.
