From: tom.leiming@gmail.com (Ming Lei)
Date: Fri, 14 May 2010 10:09:36 +0800
Subject: RMK closing tree to patches *this* weekend
In-Reply-To: <20100513230201.GA26822@n2100.arm.linux.org.uk>
References: <20100513230201.GA26822@n2100.arm.linux.org.uk>
Message-ID: <AANLkTile3zyNe8KaR-TystcZmaNznV2H9WlAWNpddnx_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/14 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> As of the end of this coming weekend, I'll stop taking patches for the
> next merge window. ?I want to tidy up the lose ends which need sorting
> out and give it a decent outing in linux-next for about a week before
> the merge window opens.
>
> So if there's any patches I've missed, please follow up to this email.

If possible, please take the patch:

           [PATCH] ARM: fix 'unannotated irqs-on' lockdep warning

which not only fixes the warning and make lockdep available,
but also is more efficient than before if lockdep is enabled:

          - remove one calling for asm_trace_hardirqs_on before returning
to user-space
          - convert asm_trace_hardirqs_on to trace_hardirqs_on in the
path of returning to kernel space from exception and only call it if
harirqs will be enabled before returning.


Thanks,
-- 
Lei Ming
