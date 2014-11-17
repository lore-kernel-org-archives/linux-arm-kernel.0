From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Nov 2014 12:29:44 +0100
Subject: [PATCH 08/25] ARM: shmobile: r8a7790: sound enables Audio DMAC
 peri peri entry on DTSI
In-Reply-To: <cbfc0b77b0c5ac11282882bfd734716e47d20b45.1415755881.git.horms+renesas@verge.net.au>
References: <cover.1415755881.git.horms+renesas@verge.net.au>
 <cbfc0b77b0c5ac11282882bfd734716e47d20b45.1415755881.git.horms+renesas@verge.net.au>
Message-ID: <1877842.49FtTfL2eK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 November 2014 10:19:59 Simon Horman wrote:
>                                 "mem_src6",     "src6_mem",
>                                 "mem_src7",     "src7_mem",
>                                 "mem_src8",     "src8_mem",
> -                               "mem_src9",     "src9_mem";
> +                               "mem_src9",     "src9_mem",
> +
> +                               "src0_ssiu0",           "src1_ssiu0",           "src2_ssiu0",           "src3_ssiu0",           "src4_ssiu0",
> +                               "src0_ssiu1",           "src1_ssiu1",           "src2_ssiu1",           "src3_ssiu1",           "src4_ssiu1",
> +                               "src0_ssiu2",           "src1_ssiu2",           "src2_ssiu2",           "src3_ssiu2",           "src4_ssiu2",
> 

I have to note that this looks rather weird and that none of the names
are documented in the binding.

Can you explain why this device uses over 100 DMA channels and put the
exact naming rules into the binding?
Do you expect all channels to be in use simultaneously?

	Arnd
