From: bp@alien8.de (Borislav Petkov)
Date: Tue, 20 Feb 2018 20:28:52 +0100
Subject: [PATCH 01/11] ACPI / APEI: Move the estatus queue code up, and
 under its own ifdef
In-Reply-To: <20180215185606.26736-2-james.morse@arm.com>
References: <20180215185606.26736-1-james.morse@arm.com>
 <20180215185606.26736-2-james.morse@arm.com>
Message-ID: <20180220192852.GB24320@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 06:55:56PM +0000, James Morse wrote:
> +#ifdef CONFIG_HAVE_ACPI_APEI_NMI
> +/*
> + * While printk() now has an in_nmi() path, the handling for CPER records
> + * does not. For example, memory_failure_queue() takes spinlocks and calls
> + * schedule_work_on().
> + *
> + * So in any NMI-like handler, we allocate required memory from lock-less
> + * memory allocator (ghes_estatus_pool), save estatus into it, put them into
> + * lock-less list (ghes_estatus_llist), then delay printk into IRQ context via
> + * irq_work (ghes_proc_irq_work).  ghes_estatus_size_request record
> + * required pool size by all NMI error source.

Since you're touching this, pls correct the grammar too, while at it,
and correct them into proper sentences. Also, end function names with
"()". Also the "we" pronoun and tense sounds funny - let's make it
passive.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
