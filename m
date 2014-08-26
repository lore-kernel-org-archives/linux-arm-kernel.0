From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Aug 2014 11:14:14 +0100
Subject: [PATCH] ARM: errata: Workaround for Cortex-A12 erratum 818325
In-Reply-To: <1408355889-4176-1-git-send-email-kever.yang@rock-chips.com>
References: <1408355889-4176-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <20140826101414.GD23445@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 10:58:09AM +0100, Kever Yang wrote:
> From: Huang Tao <huangtao@rock-chips.com>
> 
> On Cortex-A12 (r0p0..r0p1-00lac0-rc11), when a CPU executes a sequence of
> two conditional store instructions with opposite condition code and
> updating the same register, the system might enter a deadlock if the
> second conditional instruction is an UNPREDICTABLE STR or STM
> instruction. This workaround setting bit[12] of the Feature Register
> prevents the erratum. This bit disables an optimisation applied to a
> sequence of 2 instructions that use opposing condition codes.
> 
> Signed-off-by: Huang Tao <huangtao@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---

The Rk3288 I have advertises itself as an r0p1 Cortex-A12 CPU, so isn't
affected by this issue. Until we have an SoC supported in mainline that
requires this workaround, I don't think we should merge it.

Also, please consider setting these bits in your firmware if possible.
The feature register isn't writable from the non-secure side, so if you
want to use virtualisation you'll need to do this differently.

Will
