From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 3 Jun 2011 00:18:37 +0200
Subject: [linux-pm] [RFC PATCH v3] ARM hibernation/suspend-to-disk support
In-Reply-To: <alpine.DEB.2.00.1105251251330.4319@localhost6.localdomain6>
References: <alpine.DEB.2.00.1105251251330.4319@localhost6.localdomain6>
Message-ID: <20110602221837.GB14328@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Please let me know what you think,
> Thanks in advance,

> +void save_processor_state(void)
> +{
> +	flush_thread();
> +	local_fiq_disable();
> +#ifdef CONFIG_ARM_MACH_HIBERNATION_HOOK
> +	mach_save_state();
> +#endif
> +}

Could we always define mach_save_state, and get rid of ifdef?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
