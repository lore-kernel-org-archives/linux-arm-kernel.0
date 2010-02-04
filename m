From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 4 Feb 2010 10:45:04 -0800
Subject: [PATCH] ARM: Correct the FPSCR bits setting when raising
	exceptions
In-Reply-To: <20100128101809.7752.76832.stgit@pc1117.cambridge.arm.com>
References: <20100128101809.7752.76832.stgit@pc1117.cambridge.arm.com>
Message-ID: <f17812d71002041045h5f6cbbe8vdf40dad11a693a5e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 2:18 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> Commit c98929c07a removed the clearing of the FPSCR[31:28] bits from the
> vfp_raise_exceptions() function and the new bits are or'ed with the old
> FPSCR bits leading to unexpected results (the original commit was
> referring to the cumulative bits - FPSCR[4:0]).
>

What's the status of this patch? Looks like a sane fix to me and apparently
it seems Marvell cores are confused without this already.
