From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Tue, 3 Dec 2013 16:51:40 +0000
Subject: [RFC part1 PATCH 3/7] ACPI / processor_core: Rework _PDC
 related stuff to make it more arch-independent
In-Reply-To: <1386088611-2801-4-git-send-email-hanjun.guo@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <1386088611-2801-4-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20131203165140.24a05540@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  4 Dec 2013 00:36:47 +0800
Hanjun Guo <hanjun.guo@linaro.org> wrote:

> _PDC related stuff in processor_core.c is little bit X86/IA64 dependent,
> rework the code to make it more arch-independent.
> 
> The return value of acpi_processor_eval_pdc() should be 'acpi_status' but
> defined as 'int', fix it too.

Why not just define boot_options_idle_override as well. Then you can
leave the code unchanged. Also more importantly you can have override
values for ARM when it turns out you need those too and the logic will be
the same for both processor families

Alan
