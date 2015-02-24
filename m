From: mingo@kernel.org (Ingo Molnar)
Date: Tue, 24 Feb 2015 08:39:06 +0100
Subject: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
In-Reply-To: <20150223205436.15133mg1kpyojyik@webmail.upv.es>
References: <54EB735F.5030207@upv.es>
 <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
 <20150223205436.15133mg1kpyojyik@webmail.upv.es>
Message-ID: <20150224073906.GA16422@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Hector Marco Gisbert <hecmargi@upv.es> wrote:

> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +	unsigned long ret;
> +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +		!(current->flags & PF_RANDOMIZE))
> +		return base;
> +	ret = base + mmap_rnd();
> +	return (ret > base) ? ret : base;
> +}

> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +	unsigned long ret;
> +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +		!(current->flags & PF_RANDOMIZE))
> +		return base;
> +	ret = base + mmap_rnd();
> +	return (ret > base) ? ret : base;
> +}

> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +	unsigned long ret;
> +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +		!(current->flags & PF_RANDOMIZE))
> +		return base;
> +	ret = base + brk_rnd();
> +	return (ret > base) ? ret : base;
> +}

> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +	unsigned long ret;
> +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +		!(current->flags & PF_RANDOMIZE))
> +		return base;
> +	ret = base + mmap_rnd();
> +	return (ret > base) ? ret : base;
> +}

> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +	unsigned long ret;
> +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +		!(current->flags & PF_RANDOMIZE))
> +		return base;
> +	ret = base + mmap_rnd();
> +	return (ret > base) ? ret : base;
> +}

That pointless repetition should be avoided.

Thanks,

	Ingo
