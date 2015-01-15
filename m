From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jan 2015 00:03:06 +0000
Subject: [PATCH 1/2] perf symbols: Ignore mapping symbols on aarch64
In-Reply-To: <CAA3XUr2KUyafcnUggN7=xGNGSeRkkRtYtxZmwm4UC8sRCGup3g@mail.gmail.com>
References: <1421168344-5363-1-git-send-email-victor.kamensky@linaro.org>
 <20150114112210.GF4050@arm.com>
 <CAA3XUr2KUyafcnUggN7=xGNGSeRkkRtYtxZmwm4UC8sRCGup3g@mail.gmail.com>
Message-ID: <20150115000305.GC12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 10:38:38AM -0800, Victor Kamensky wrote:
> >From fed6caab410ddcaf487ff23a3908eca129e50b89 Mon Sep 17 00:00:00 2001
> From: Victor Kamensky <victor.kamensky@linaro.org>
> Date: Wed, 14 Jan 2015 07:42:41 -0800
> Subject: [PATCH 3/3] perf symbols: improve abi compliance in arm mapping
>  symbols handling
> 
> Both Arm and Aarch64 ELF ABI allow mapping symbols be in from
> either "$d" or "$d.<any>". But current code that handles mapping
> symbols only deals with the first, dollar character and a single
> letter, case.
> 
> The patch adds handling of the second case with period
> followed by any characters.
> 
> Suggested-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>

I wonder if it would make more sense to re-use the "is_arm_mapping_symbol"
thing which we have in kernel/module.c and scripts/kallsyms.c - it
seems silly to re-invent code which we already have to detect these
symbols.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
