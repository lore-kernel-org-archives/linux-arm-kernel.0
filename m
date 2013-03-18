From: will.deacon@arm.com (Will Deacon)
Date: Mon, 18 Mar 2013 18:34:36 +0000
Subject: [PATCHv2 3/3] ARM: Work around faulty ISAR0 register in some
 Krait CPUs
In-Reply-To: <1363631337-13816-4-git-send-email-sboyd@codeaurora.org>
References: <1363631337-13816-1-git-send-email-sboyd@codeaurora.org>
 <1363631337-13816-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130318183435.GD31193@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 06:28:57PM +0000, Stephen Boyd wrote:
> From: Stepan Moskovchenko <stepanm@codeaurora.org>
> 
> Some early versions of the Krait CPU design incorrectly indicate
> that they only support the UDIV and SDIV instructions in Thumb
> mode when they actually support them in ARM and Thumb mode. It
> seems that these CPUs follow the DDI0406B ARM ARM which has two
> possible values for the divide instructions field, instead of the
> DDI0406C document which has three possible values.
> 
> Work around this problem by checking the MIDR against Krait CPUs
> with this faulty ISAR0 register and force the hwcaps to indicate
> support in both modes.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
> [sboyd: Rewrote commit text to reflect real reasoning now that
> 	we autodetect udiv/sdiv]
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/mm/proc-v7.S | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
