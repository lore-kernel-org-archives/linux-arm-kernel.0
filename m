From: olof@lixom.net (Olof Johansson)
Date: Mon, 2 Jul 2018 10:15:59 -0700
Subject: [GIT PULL] Renesas ARM Based SoC Arm SoC Updates for v4.19
In-Reply-To: <cover.1529934908.git.horms+renesas@verge.net.au>
References: <cover.1529934908.git.horms+renesas@verge.net.au>
Message-ID: <CAOesGMjunEcbcPj3fw=VktkNdkO9UNWPXo+t6L=xf+HR3gVyvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,


On Mon, Jun 25, 2018 at 7:05 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these Renesas ARM based SoC arm SoC updates for v4.19.
>
>
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-soc-for-v4.19
>
> for you to fetch changes up to c44e182e537492baaa37303fc0ee299222fce921:
>
>   ARM: shmobile: convert to SPDX identifier (2018-06-18 12:00:29 +0200)

I've merged this into next/soc but wanted to give a bit of feedback on
the tag description for future consideration:

> ----------------------------------------------------------------
> Renesas ARM Based SoC Arm SoC Updates for v4.19
>
> * Convert to SPDX identifier
>
> * Remove legacy SMP fallback code
>
>   Geert Uytterhoeven says "R-Car H2 and M2-W have been supporting SMP
>   enablement from DT using the "renesas,apmu" enable-method since v4.8.
>   A legacy fallback was left in place for backwards compatibility with old
>   DTBs.
>
>   This patch series removes the legacy SMP fallbacks for R-Car H2 and
>   M2-W, and consolidates their support in the common R-Car Gen2 machine
>   definition.2

Can you please edit a little more when you write these pull requests?
Distilling the information into a higher concentration.

This could have been something like:

 - Remove legacy SMP fallback code for R-Car H2 and M2-W
    DT enablement has been in since 4.8 and it's no longer needed.

> * APMU cleanups after legacy SMP fallback removal
>   - Move cpu_leave_lowpower() from HOTPLUG_CPU || SUSPEND section to the
>     SUSPEND section as it is only used for suspend
>   - Remove shmobile_smp_apmu_prepare_cpus() as it is no longer used
>   - Remove platsmp-apmu.h

These are typical "what" descriptions, not "why". Just as with patch
descriptions, it's usually more important to describe why something is
changed than exactly what (since what can be derived from looking at
the diff).

It's a bit different for cleanups, of course, but general rule of
thumb still applies.

>
> * Drop legacy SYSC fallbacks
>
>   Geert Uytterhoeven says "When DT SYSC support was introduced in v4.7,
>   legacy fallbacks were kept to keep secondary CPUs working on R-Car H1,
>   H2, and M2-W using old DTBs.  However, the time has come to drop these
>   fallbacks, and clean up the resulting code"

Again, this could have a single-sentence description similar to SMP
fallback removal.


Thanks,


-Olof
