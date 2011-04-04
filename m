From: Ulrich.Weigand@de.ibm.com (Ulrich Weigand)
Date: Mon, 4 Apr 2011 20:51:47 +0200
Subject: [PATCH v3 2/2] ARM: ptrace: Migrate to regsets framework
In-Reply-To: <1301935406-10591-3-git-send-email-dave.martin@linaro.org>
References: <1301935406-10591-1-git-send-email-dave.martin@linaro.org>
	<1301935406-10591-3-git-send-email-dave.martin@linaro.org>
Message-ID: <OFD28DD924.B2142DA2-ONC1257868.006781E8-C1257868.00679E79@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Martin <dave.martin@linaro.org> wrote on 04/04/2011 06:43:26 PM:

> +/*
> + * The size of the user-visible VFP state as seen by
PTRACE_GET/SETVFPREGS
> + * and core dumps.
> + */
> +#define ARM_VFPREGS_SIZE ( 32 * 4 /*fpregs*/ + 4 /*fpscr*/ )

This should be 32 * 8 + 4, not 32 * 4 + 4, shouldn't it?


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
