From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Feb 2017 17:54:05 +0000
Subject: [PATCH v2 4/5] arm64: mmu: map .text as read-only from the outset
In-Reply-To: <42A48E4E-EF3C-4F28-A660-AFEBB238B698@linaro.org>
References: <1486844586-26135-1-git-send-email-ard.biesheuvel@linaro.org>
 <1486844586-26135-5-git-send-email-ard.biesheuvel@linaro.org>
 <20170214155704.GE23718@leverpostej>
 <651D9CBB-3E64-41CE-BF85-D2FF0CB927B7@linaro.org>
 <20170214174029.GJ23718@leverpostej>
 <42A48E4E-EF3C-4F28-A660-AFEBB238B698@linaro.org>
Message-ID: <20170214175405.GL23718@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 05:49:19PM +0000, Ard Biesheuvel wrote:
> 
> > On 14 Feb 2017, at 17:40, Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> >> On Tue, Feb 14, 2017 at 04:15:11PM +0000, Ard Biesheuvel wrote:

> >> Having trivial 'off' switches for security features makes me feel
> >> uneasy (although this is orthogonal to this patch)
> > 
> > From my PoV, external debuggers are the sole reason to allow rodata=off
> > for arm64, and we already allow rodata=off.
> > 
> > 
> 
> Indeed. If that is how it works currently, we shouldn't interfere with
> it. If we ever get anywhere with the lockdown patches, we should
> blacklist this parameter (or rather, not whitelist it, since
> blacklisting kernel params to enforce security is infeasible imo)

Agreed on all counts!

Mark.
