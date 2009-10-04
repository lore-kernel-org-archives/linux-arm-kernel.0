From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Oct 2009 21:02:23 +0200
Subject: [PATCH] FCSE: pid life cycle.
In-Reply-To: <1254432860-11511-2-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <1254432860-11511-1-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-2-git-send-email-gilles.chanteperdrix@xenomai.org>
Message-ID: <20091004190223.GH1378@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2009-10-01 23:34:11, Gilles Chanteperdrix wrote:
> Add a pid member to the mm_context_t structure, allocate this pid in
> the init_new_context, free it in the destroy_context, switch it in
> switch_mm.
> 
> A bitfield is maintained to know what pids are currently in use.
> 
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
> Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
...
> --- /dev/null
> +++ b/arch/arm/include/asm/fcse.h
> @@ -0,0 +1,44 @@
> +/*
> + * Filename:    arch/arm/include/asm/fcse.h
> + * Description: ARM Process ID (PID) includes for Fast Address Space Switching
> + *              (FASS) in ARM Linux.
> + * Created:     14/10/2001
> + * Changes:     19/02/2002 - Macros added.
> + *              03/08/2007 - Adapted to kernel 2.6.21 (ssm)
> + *              Feb 2008   - Simplified a bit (rco)

We normally avoid changelogs in sources.

> +/* Sets the CPU's PID Register */
> +static inline void fcse_pid_set(unsigned long pid)
> +{
> +	__asm__ __volatile__ ("mcr p15, 0, %0, c13, c0, 0"
> +			      : /* */: "r" (pid) : "memory");
> +}

Calling this 'pid' is extremely confusing. PID already means process
id...



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
