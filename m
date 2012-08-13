From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 13 Aug 2012 15:09:56 -0700
Subject: [PATCH] ARM: formalize an IPI for CPU wake-ups
In-Reply-To: <CANqRtoQ9BCPhQPi38vK__61G2yAY=g9s17NG3LhSnrxdOYnkDg@mail.gmail.com>
References: <alpine.LFD.2.02.1206111152190.23555@xanadu.home>
 <20120611155716.GA18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111241470.23555@xanadu.home>
 <20120611165115.GB18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111307550.23555@xanadu.home>
 <4FD62DBB.8070407@codeaurora.org>
 <20120611192519.GF18267@n2100.arm.linux.org.uk>
 <4FE1FB15.3090305@codeaurora.org>
 <0e0201cd5f2f$2c2f6e60$848e4b20$%kim@samsung.com>
 <5016D03D.8010607@codeaurora.org>
 <CANqRtoQ9BCPhQPi38vK__61G2yAY=g9s17NG3LhSnrxdOYnkDg@mail.gmail.com>
Message-ID: <50297B34.5090504@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/12 23:52, Magnus Damm wrote:
> So I finally managed to try this out on my KZM9D board. The SMP bring
> up code continues to work as expected, so it seems that SGI0 can be
> used instead of SGI1 on EMEV2. Let's just say that the boot protocol
> implemented by the mask ROM is rather poorly documented. Anyway, to
> test I used the following patch on top of linux git 42a579a.
>
> --- 0001/arch/arm/mach-shmobile/smp-emev2.c
> +++ work/arch/arm/mach-shmobile/smp-emev2.c	2012-08-08 15:42:54.000000000 +0900
> @@ -82,7 +82,7 @@ int __cpuinit emev2_boot_secondary(unsig
>  	/* Tell ROM loader about our vector (in headsmp.S) */
>  	emev2_set_boot_vector(__pa(shmobile_secondary_vector));
>
> -	gic_raise_softirq(cpumask_of(cpu), 1);
> +	gic_raise_softirq(cpumask_of(cpu), 0);
>  	return 0;
>  }
>
> So if/where needed, please add my:
>
> Acked-by: Magnus Damm <damm@opensource.se>
>

Thanks Magnus, would you be able to merge this through the shmobile
tree? Otherwise I can put it in the patch tracker.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
