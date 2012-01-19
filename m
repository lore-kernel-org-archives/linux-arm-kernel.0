From: olof@lixom.net (Olof Johansson)
Date: Thu, 19 Jan 2012 11:31:09 -0800
Subject: [RFC v3 PATCH 1/3] dt: device tree bindings for DDR memories
In-Reply-To: <1326983521-373-2-git-send-email-aneesh@ti.com>
References: <1326983521-373-1-git-send-email-aneesh@ti.com>
 <1326983521-373-2-git-send-email-aneesh@ti.com>
Message-ID: <CAOesGMikm8szKR_yyeV-4NbnknCLG3z9N_sj+zydyu+cosj-Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry for the delay in responding, I know you pinged me about it yesterday.

On Thu, Jan 19, 2012 at 6:31 AM, Aneesh V <aneesh@ti.com> wrote:
> device tree bindings for LPDDR2 SDRAM memories compliant
> to JESD209-2 standard.
>
> The 'lpddr2' binding in-turn uses another binding 'lpddr2-timings'
> for specifying the AC timing parameters of the memory device at
> different speed-bins.

As I just commented on the thread with Mike, I think we would be
better off sticking to embedding a standard JEDEC SPD structure in the
device tree. It's not large (128-256 bytes depending on memory type),
and it's clearly defined and used all over the industry.

It also has the benefit of reusing parsing code if you ever end up
with a system that uses DIMMs for memory, thus needing to parse the
SPD on said modules.


-Olof
