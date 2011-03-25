From: Ulrich.Weigand@de.ibm.com (Ulrich Weigand)
Date: Fri, 25 Mar 2011 14:40:24 +0100
Subject: RFC: ARM: Support for VFP/NEON registers in coredumps
In-Reply-To: <AANLkTi=zrf-_S3fFFb69SXPvGhZawwEY94kt74CVC8-n@mail.gmail.com>
References: <20110324141826.GA3810@arm.com>	<OF1A9833E7.A620B0FF-ONC125785D.004F4BC3-C125785D.0052255A@de.ibm.com>
	<AANLkTin+X7BNBE9ZuDQhHVeNQqeNPjqj16pZDLTag_n+@mail.gmail.com>	<OFAB8D9B91.5F6DE70D-ONC125785D.0059E446-C125785D.005B916C@de.ibm.com>
	<AANLkTinzxmULwhgXHbAUw0zveYXYj8zxRgZkoPYdOPhc@mail.gmail.com>	<OF17449AB0.36DF06DD-ONC125785D.00635CD3-C125785D.0063E8BB@de.ibm.com>
	<AANLkTi=VtCy9MrY5+wGYfh9+otWy87WmFZkmGN-PqMPo@mail.gmail.com>	<OF13B038E5.B9DFA4EA-ONC125785E.0047A984-C125785E.004871A1@de.ibm.com>
	<AANLkTi=zrf-_S3fFFb69SXPvGhZawwEY94kt74CVC8-n@mail.gmail.com>
Message-ID: <OFD0474D33.663BAB94-ONC125785E.004ABB86-C125785E.004B1C72@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Martin <dave.martin@linaro.org> wrote:

> I was indeed thinking that it might be a good idea to take this
> opportunity to migrate to using regsets; though for simplicity, I'll
> probably avoid this for the first iteration.
>
> Will this have any impact on the ptrace interface?

Well, once you support regsets, the PTRACE_GETREGSET/PTRACE_SETREGSET
commands will start working.  However, on platforms that already had
commands to access registers, platform-specific code will of course
need to continue to support those.

See e.g. arch/powerpc/kernel/ptrace.c, which by now implements all
of its legacy ptrace register commands in terms of regset functions.


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand | Phone: +49-7031/16-3727
  STSM, GNU compiler and toolchain for Linux on System z and Cell/B.E.
  IBM Deutschland Research & Development GmbH
  Vorsitzender des Aufsichtsrats: Martin Jetter | Gesch?ftsf?hrung: Dirk
Wittkopp
  Sitz der Gesellschaft: B?blingen | Registergericht: Amtsgericht
Stuttgart, HRB 243294
