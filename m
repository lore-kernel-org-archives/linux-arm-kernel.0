From: will.deacon@arm.com (Will Deacon)
Date: Thu, 5 Jul 2012 13:56:22 +0100
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay
 implementation to be selected
In-Reply-To: <4FF5849E.6060301@renesas.com>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-3-git-send-email-will.deacon@arm.com>
 <4FF2E0FB.4040008@renesas.com>
 <20120704153624.GI15104@mudshark.cambridge.arm.com>
 <4FF5849E.6060301@renesas.com>
Message-ID: <20120705125622.GF3399@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 01:12:14PM +0100, Shinya Kuribayashi wrote:
> Ok, I gave your patch a try (including above), and confirmed that:
> 
> * It works fine with non-arch_timer counter.  I'm using SH/R-Mobile
>   devices, with a memory mapped I/O, 32-bit free-run up-counter
>   running at 13MHz.
> 
> * Secondary CPU calibration gets skipped as expected.
> 
> * Your new timer-based delay works as before (loop-based one).  I've
>   verified 10..1999-microsecond busy-wait with a reasonable accuracy
>   (and confirmed that 2000+ usec gets rejected as intended).

Great, thanks! Can I add your tested-by please?

> By the way,
> 
> > +       return lpj_fine ?: 0;
> 
> Is there any difference with just
> 
>         return lpj_fine;

Of course, I'll make that change, cheers.

Stephen -- can I keep your reviewed-by with the additional function please?

Will
