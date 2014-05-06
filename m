From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 May 2014 18:00:39 +0100
Subject: [PATCH 3/3] perf tools: Add libdw DWARF post unwind support for
 ARM64
In-Reply-To: <1399391733-11927-4-git-send-email-jean.pihet@linaro.org>
References: <1399391733-11927-1-git-send-email-jean.pihet@linaro.org>
 <1399391733-11927-4-git-send-email-jean.pihet@linaro.org>
Message-ID: <20140506170039.GB13677@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

On Tue, May 06, 2014 at 04:55:33PM +0100, Jean Pihet wrote:
> Adding libdw DWARF post unwind support, which is part
> of elfutils-devel/libdw-dev package from version 0.158.
> 
> Note: the libdw code needs some support for dwarf unwinding
> on ARM64, this code is submitted seperately on the elfutils
> ML.
> 
> The new code is contained in unwin-libdw.c object, and
> implements unwind__get_entries unwind interface function.

Are you planning to implement support for 32-bit ARM too? If so, we'll need
compat handling here again (your favourite!).

> +bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +{
> +	struct unwind_info *ui = arg;
> +	struct regs_dump *user_regs = &ui->sample->user_regs;
> +	Dwarf_Word dwarf_regs[PERF_REG_ARM64_MAX];

Shouldn't this be PERF_REG_ARM64_MAX - 1?

Will
