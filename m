From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Tue, 14 Jun 2011 09:00:12 +0100 (BST)
Subject: [linux-pm] [RFC PATCH v3] ARM hibernation/suspend-to-disk support
In-Reply-To: <20110602221837.GB14328@ucw.cz>
References: <alpine.DEB.2.00.1105251251330.4319@localhost6.localdomain6>
	<20110602221837.GB14328@ucw.cz>
Message-ID: <alpine.DEB.2.00.1106140854460.19778@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Fri, 3 Jun 2011, Pavel Machek wrote:

> Hi!
>
>> Please let me know what you think,
>> Thanks in advance,
>
>> +void save_processor_state(void)
>> +{
>> +	flush_thread();
>> +	local_fiq_disable();
>> +#ifdef CONFIG_ARM_MACH_HIBERNATION_HOOK
>> +	mach_save_state();
>> +#endif
>> +}
>
> Could we always define mach_save_state, and get rid of ifdef?

Yes ... but it addresses only part of the issue(s). There's some state 
which cannot be saved / restored separately from the core state that's 
dealt with inside swsusp_arch_suspend/resume. This hook couldn't deal with 
that.

Also, if having mach-specific hooks everywhere, wouldn't it be better to 
simply use a platform ops based approach ?

FrankH.



>
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
