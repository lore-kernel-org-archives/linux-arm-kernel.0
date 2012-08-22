From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Aug 2012 14:44:42 +0000
Subject: [PATCH 2/4] ARM: allow PID_IN_CONTEXTIDR only for ARMv7
In-Reply-To: <20120822143946.GM9093@mudshark.cambridge.arm.com>
References: <1345645780-2749-1-git-send-email-arnd@arndb.de>
 <1345645780-2749-3-git-send-email-arnd@arndb.de>
 <20120822143946.GM9093@mudshark.cambridge.arm.com>
Message-ID: <201208221444.42668.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 August 2012, Will Deacon wrote:
> > @@ -398,6 +398,7 @@ config ARM_KPROBES_TEST
> >  config PID_IN_CONTEXTIDR
> >       bool "Write the current PID to the CONTEXTIDR register"
> >       depends on CPU_COPY_V6
> > +     depends on CPU_V7 && !CPU_V6
> >       help
> >         Enabling this option causes the kernel to write the current PID to
> >         the PROCID field of the CONTEXTIDR register, at the expense of some
> 
> Nah, I'll fix the contextidr_notifier instead. I forgot that this stuff gets
> used on non-SMP v6 platforms.
> 

Ok, thanks!

	Arnd
