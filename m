From: per.fransson.ml@gmail.com (Per Fransson)
Date: Mon, 22 Nov 2010 10:53:00 +0100
Subject: [PATCH] Add call to non-crashing cores through IPI
In-Reply-To: <20101122072420.GC14080@gw.healthdatacare.com>
References: <1290161310-22808-1-git-send-email-per.xx.fransson@stericsson.com>
	<20101122072420.GC14080@gw.healthdatacare.com>
Message-ID: <AANLkTikJiXFG_kGV4=wTKOzViy-h9VtGRHKVBuh76fE2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> I wonder whether it is good idea to enable interrupts here? What
> if we came here from an interrupt handler with interrupts already
> disabled?
>
> I guess you did this because smp_call_function() needs to have
> interrupts enabled, right?
>

Yup, that's why I did it.

> As we still need to make sure that all the secondary CPUs are
> stopped, should we do just something like:
>
> ? ? ? ?smp_send_stop();
>
> and then in ipi_cpu_stop() we check whether oops_in_progress is set
> and save the cpu state before entering that never-ending loop?

But we still need to wait for it to complete, right? Will smp_send_stop()
handle the requirements of the underlying ipi regardless of the initial state?

Regards,
Per
