From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 May 2015 17:54:29 +0100
Subject: [PATCH v6 3/6] arm64: Kprobes with single stepping support
In-Reply-To: <555F5011.90808@redhat.com>
References: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
 <1429561187-3661-4-git-send-email-dave.long@linaro.org>
 <20150520163946.GC29424@e104818-lin.cambridge.arm.com>
 <555D62BD.5040403@linaro.org>
 <20150522110007.GV29424@e104818-lin.cambridge.arm.com>
 <555F5011.90808@redhat.com>
Message-ID: <20150522165428.GC29424@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 11:49:37AM -0400, William Cohen wrote:
> On 05/22/2015 07:00 AM, Catalin Marinas wrote:
> > Any plans to post an updated version with the "unexpected single-step
> > error" fixed?
> 
> The only place this issue with the "unexpected single-step error" has
> been observed is with the arm64 kretporbe handler code calling kprobed
> functions.  Experiments with kprobed functions being called in the
> kprobe handlers showed that situation was handled appropriately. 
> 
> There is proposed fix to address the issue with the trampoline, the
> attached patch.  This is modeled after the way that the x86 handles
> the kretprobe.  The trampoline directly save and restores the
> registers and uses a normal call to the kretprobe handler.  It
> operates similarly to what you are suggesting above, but just for the
> special case of the kretprobes.

Thanks. I guess David will post a v7 series with this patch included and
other comments addressed.

BTW, I'll be on holiday for a week, back on the 1st of June. Hopefully
this series gets some more reviews by then ;)

-- 
Catalin
