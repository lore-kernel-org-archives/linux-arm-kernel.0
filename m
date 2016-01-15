From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Jan 2016 17:08:53 +0000
Subject: [PATCH 1/2] arm64: insn: remove BUG_ON from codegen
In-Reply-To: <1452756802-16511-1-git-send-email-zlim.lnx@gmail.com>
References: <1452756802-16511-1-git-send-email-zlim.lnx@gmail.com>
Message-ID: <20160115170852.GB1641@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 11:33:21PM -0800, Zi Shen Lim wrote:
> During code generation, we used to BUG_ON unknown/unsupported encoding
> or invalid parameters.
> 
> Instead, now we report these as errors and simply return the
> instruction AARCH64_BREAK_FAULT. Users of these codegen helpers should
> check for and handle this failure condition as appropriate.
> 
> Otherwise, unhandled codegen failure will result in trapping at
> run-time due to AARCH64_BREAK_FAULT, which is arguably better than a
> BUG_ON.
> 
> Signed-off-by: Zi Shen Lim <zlim.lnx@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
> Per discussion here: http://www.spinics.net/lists/arm-kernel/msg474179.html

Thanks, this looks good to me. Given that Rabin fixes the shift issue
in the core, I'm assuming this can wait until 4.6 and Catalin can queue
it after -rc1?

  Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
