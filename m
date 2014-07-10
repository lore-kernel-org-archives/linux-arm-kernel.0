From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Thu, 10 Jul 2014 17:15:21 +0400
Subject: [RFC/PATCH RESEND -next 05/21] x86: cpu: don't sanitize early
 stages of a secondary CPU boot
In-Reply-To: <87egxunx8j.fsf@tassilo.jf.intel.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-6-git-send-email-a.ryabinin@samsung.com>
 <87egxunx8j.fsf@tassilo.jf.intel.com>
Message-ID: <53BE91E9.9090408@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/14 23:33, Andi Kleen wrote:
> Andrey Ryabinin <a.ryabinin@samsung.com> writes:
> 
>> Instrumentation of this files may result in unbootable machine.
> 
> This doesn't make sense. Is the code not NMI safe? 
> If yes that would need to be fixed because
> 
> Please debug more.
> 

Sure.
It turns out that  KASAN_SANITIZE_perf_event.o := n is not needed here.
The problem only with common.c

> perf is a common source of bugs (see Vice Weaver's fuzzer results),
> so it would be good to have this functionality for it.
> 
> -Andi
> 
