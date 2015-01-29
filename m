From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 29 Jan 2015 17:24:57 +0000
Subject: [PATCH] arm64: Avoid breakage caused by .altmacro in fpsimd
 save/restore macros
In-Reply-To: <1422548683-25544-1-git-send-email-Dave.Martin@arm.com>
References: <1422548683-25544-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150129172457.GO8951@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 04:24:43PM +0000, Dave P Martin wrote:
> Alternate macro mode is not a property of a macro definition, but a
> gas runtime state that alters the way macros are expanded for ever
> after (until .noaltmacro is seen).
> 
> This means that subsequent assembly code that calls other macros can
> break if fpsimdmacros.h is included.
> 
> Since these instruction sequences are simple (if dull -- but in a
> good way), this patch solves the problem by simply expanding the
> .irp loops.  The pre-existing fpsimd_{save,restore} macros weren't
> rolled with .irp anyway and the sequences affected are short, so
> this change restores consistency at little cost.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Applied. Thanks.

-- 
Catalin
