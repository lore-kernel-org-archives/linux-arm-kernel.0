From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 23 Oct 2016 23:48:32 -0400
Subject: [PATCH V4 1/3] ACPI, PCI, IRQ: assign ISA IRQ directly during
 early boot stages
In-Reply-To: <CAJZ5v0jm-n8hbS_GFUY4EVKHiRaNPrkNcWDY+6c3SRxWhy4VAg@mail.gmail.com>
References: <1476915664-27231-1-git-send-email-okaya@codeaurora.org>
 <1476915664-27231-2-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0jm-n8hbS_GFUY4EVKHiRaNPrkNcWDY+6c3SRxWhy4VAg@mail.gmail.com>
Message-ID: <22ad2e6b-e4da-1eba-0d2c-b7b86b2a4dbc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2016 5:39 PM, Rafael J. Wysocki wrote:
>> @@ -871,7 +871,7 @@ static int __init acpi_irq_penalty_update(char *str, int used)
>> >  void acpi_penalize_isa_irq(int irq, int active)
>> >  {
>> >         if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
>> > -               acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
>> > +               acpi_isa_irq_penalty[irq] = acpi_isa_irq_penalty[irq] +
> This looks slightly odd.  What about
> 
> +               acpi_isa_irq_penalty[irq] +=
> 
>> >                   (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
>> >  }

Makes sense.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
