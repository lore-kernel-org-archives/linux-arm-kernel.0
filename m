From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 30 Oct 2016 14:24:46 +0000
Subject: [PATCH] arm64/kprobes: Tidy up sign-extension usage
In-Reply-To: <f25b75bf250827113d4269614ba7936e870b0646.1476794661.git.robin.murphy@arm.com>
References: <f25b75bf250827113d4269614ba7936e870b0646.1476794661.git.robin.murphy@arm.com>
Message-ID: <20161030142446.zwttspvrzapnjax5@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 01:46:27PM +0100, Robin Murphy wrote:
> Kprobes does not need its own homebrewed (and frankly inscrutable) sign
> extension macro; just use the standard kernel functions instead. Since
> the compiler actually recognises the sign-extension idiom of the latter,
> we also get the small bonus of some nicer codegen, as each displacement
> calculation helper then compiles to a single optimal SBFX instruction.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Queued for 4.10. Thanks.

-- 
Catalin
