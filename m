From: tn@semihalf.com (Tomasz Nowicki)
Date: Wed, 13 Jan 2016 16:27:43 +0100
Subject: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
In-Reply-To: <56966C1C.1050902@codeaurora.org>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <56966C1C.1050902@codeaurora.org>
Message-ID: <56966CEF.1010701@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.01.2016 16:24, Sinan Kaya wrote:
> on an ARM64 server with some nits.
>
> I started seeing these on an ACPI system. I didn't have these before when I tested Tomasz's
> branch yesterday. It must have been introduced after a rebase or a recent change.
>
> _#_dmesg_|_grep_of_irq
> [    3.130774] pci 0002:00:00.0: of_irq_parse_pci() failed with rc=-22
> [    4.182526] pci 0002:00:00.0: of_irq_parse_pci() failed with rc=-22
> [    5.187764] pci 0002:00:00.0: of_irq_parse_pci() failed with rc=-22
> [    5.868518] pci 0003:00:00.0: of_irq_parse_pci() failed with rc=-22
> [    5.910629] pci 0003:00:00.0: of_irq_parse_pci() failed with rc=-22
> [    6.732817] pci 0006:00:00.0: of_irq_parse_pci() failed with rc=-22
> [    7.777698] pci 0006:00:00.0: of_irq_parse_pci() failed with rc=-22
> [    8.782882] pci 0006:00:00.0: of_irq_parse_pci() failed with rc=-22
> / #

You got this because I had dropped patch from the previous series:
https://patchwork.ozlabs.org/patch/557504/
and this is expected.

Tomasz
