From: mhei@heimpold.de (Michael Heimpold)
Date: Sat, 01 Jun 2013 14:19:58 +0200
Subject: [PATCH v2 2/2] ARM: mxs: Pass the system revision
In-Reply-To: <1370040127-15072-2-git-send-email-festevam@gmail.com>
References: <1370040127-15072-1-git-send-email-festevam@gmail.com>
 <1370040127-15072-2-git-send-email-festevam@gmail.com>
Message-ID: <3068502.pO6ZTjjROM@kerker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Am Freitag, 31. Mai 2013, 19:42:07 schrieb Fabio Estevam:
>...                                                                                 
> Hardware        : Freescale i.MX28 Evaluation Kit                               
> Revision        : 28012                                                         
> ...
> +	system_rev = (cputype | mxs_get_cpu_rev());
> +}

I think it would be difficult to use system_rev for this purpose as some
boards I know about are using this field to pass a board/PCB revision from
U-Boot to the kernel.
After spending a short look through documentation in kernel and U-Boot
I did not find any hint whether this was the indended usage of this field.

I would rather argue about introducing a new line
"SoC revision: ..." as this is the revision you want to pass to user-space.

The lines "Revision" and "Serial" should IMHO left
alone for usage by board vendors.

BR, Michael
