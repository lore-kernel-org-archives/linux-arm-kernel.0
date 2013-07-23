From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 23 Jul 2013 08:02:12 -0300
Subject: [PATCH] ARM: Do not run dummy_flush_tlb_a15_erratum() on
 non-Cortex-A15
In-Reply-To: <51EE3B46.7020906@ti.com>
References: <1374556774-18795-1-git-send-email-festevam@gmail.com>
 <51EE3B46.7020906@ti.com>
Message-ID: <CAOMZO5Brgj2CzJXqjUfihi-aNxumvamDUGdvZuU94rHMwutCog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On Tue, Jul 23, 2013 at 5:13 AM, Roger Quadros <rogerq@ti.com> wrote:

>> -     if (!erratum_a15_798181())
>> -             return;
>> -
>
> Removing this if statement will cause "ipi_flush_tlb_a15_erratum" to be called
> on non A15 platforms. So I would just keep it to be safe.

I just moved the if statement into the the beginning of
dummy_flush_tlb_a15_erratum(), so ipi_flush_tlb_a15_erratum will not
be called on non-A15 systems.

Regards,

Fabio Esteva,
