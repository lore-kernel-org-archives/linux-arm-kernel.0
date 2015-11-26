From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 26 Nov 2015 11:59:59 +0000
Subject: [PATCH v4 1/6] ARM: shmobile: r8a7740 dtsi: Add L2
 cache-controller node
In-Reply-To: <CAMuHMdWv4iDxmyPCG26sTMZAnHd3AO7h8nTcxbPryW-d3zzjFw@mail.gmail.com>
References: <1438765090-823-1-git-send-email-geert+renesas@glider.be>
 <1438765090-823-2-git-send-email-geert+renesas@glider.be>
 <55C1D894.8070302@arm.com>
 <CAMuHMdXdEV+41mH338bDbazzqOErDLQkBUAj2+uVX4Wupn1ABQ@mail.gmail.com>
 <55C1EC3C.9000407@arm.com>
 <CAMuHMdVAOba0ofmoy8OH2DdY1m3XaD8iOXvXBE035=C4yK58VQ@mail.gmail.com>
 <55C47E32.6070400@arm.com>
 <CAMuHMdWv4iDxmyPCG26sTMZAnHd3AO7h8nTcxbPryW-d3zzjFw@mail.gmail.com>
Message-ID: <5656F43F.9050501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/11/15 16:14, Geert Uytterhoeven wrote:
> Hi Sudeep,
>

[...]

> AFAIK, there's nothing to be overridden. The cache seems to be configured in
> the exact same way with and without cache-size, cache-sets, cache-block-size,
> and cache-line-size.
>
> With:
>
>      L2C OF: override cache size: 262144 bytes (256KB)
>      L2C OF: override line size: 32 bytes
>      L2C OF: override way size: 32768 bytes (32KB)
>      L2C OF: override associativity: 8
>      L2C: DT/platform modifies aux control register: 0x02040000 -> 0x02440000
>      L2C: DT/platform tries to modify or specify cache size
>      L2C-310 erratum 769419 enabled
>      L2C-310 enabling early BRESP for Cortex-A9
>      L2C-310 full line of zeros enabled for Cortex-A9
>      L2C-310 dynamic clock gating enabled, standby mode enabled
>      L2C-310 cache controller enabled, 8 ways, 256 kB
>      L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x46440001
>
> Without:
>
>      L2C: DT/platform modifies aux control register: 0x02040000 -> 0x02440000
>      L2C-310 erratum 769419 enabled
>      L2C-310 enabling early BRESP for Cortex-A9
>      L2C-310 full line of zeros enabled for Cortex-A9
>      L2C-310 dynamic clock gating enabled, standby mode enabled
>      L2C-310 cache controller enabled, 8 ways, 256 kB
>      L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x46440001
>
> Hence I'll drop cache-size, cache-sets, cache-block-size, and cache-line-size,
> for both unified L2 and L1 I/D caches.
>

Sorry for the delay, was on vacation. Looks fine for me.

-- 
Regards,
Sudeep
