From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 5 Apr 2011 10:07:38 +0100
Subject: [PATCH v3 2/2] ARM: ptrace: Migrate to regsets framework
In-Reply-To: <OFD28DD924.B2142DA2-ONC1257868.006781E8-C1257868.00679E79@de.ibm.com>
References: <1301935406-10591-1-git-send-email-dave.martin@linaro.org>
	<1301935406-10591-3-git-send-email-dave.martin@linaro.org>
	<OFD28DD924.B2142DA2-ONC1257868.006781E8-C1257868.00679E79@de.ibm.com>
Message-ID: <BANLkTi=vCAt6nk1hyEbJGodPwpysLYmPcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 4, 2011 at 7:51 PM, Ulrich Weigand
<Ulrich.Weigand@de.ibm.com> wrote:
> Dave Martin <dave.martin@linaro.org> wrote on 04/04/2011 06:43:26 PM:
>
>> +/*
>> + * The size of the user-visible VFP state as seen by
> PTRACE_GET/SETVFPREGS
>> + * and core dumps.
>> + */
>> +#define ARM_VFPREGS_SIZE ( 32 * 4 /*fpregs*/ + 4 /*fpscr*/ )
>
> This should be 32 * 8 + 4, not 32 * 4 + 4, shouldn't it?

Umm, yeah -- dumb mistake

I've reposted with this fixed.

Ideally, I'd have liked to defined that in terms of struct user_vfp,
but that results in a cascade of header dependencies I prefer to
avoid.  Also, since this definition is describing a binary protocol,
using the type definition to define it could be undesirable.

Cheers
---Dave
