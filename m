From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 17 Jun 2015 14:46:56 +0200
Subject: [PATCH] ARM: fix DEBUG_UART_PHYS/VIRT issue when modifying
 DEBUG_LL output
In-Reply-To: <1421145468-4144-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1421145468-4144-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150617144656.61eb29ae@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 13 Jan 2015 11:37:48 +0100, Boris Brezillon wrote:
> The DEBUG_UART_PHYS/VIRT value can only be automatically set once
> (automatically means set from the DEBUG_<SOC_ID>_<UART_ID> option), which
> prevents re-configuring the earlyprintk output for another platform once
> the DEBUG_LL output has been selected.
> 
> Add a new boolean option (DEBUG_CUSTOM_UART_ADDR) enabling custom phys and
> virt address setting (configured through DEBUG_CUSTOM_UART_PHYS/VIRT
> options), and make DEBUG_UART_PHYS/VIRT hidden so that they will always be
> set from one of the 'default' definitions, and thus will be overwritten
> each time you change the DEBUG_LL output.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

What is the status of this patch? It would actually be quite useful
when switching back and forth between different DEBUG_LL configurations.

Russell, what do you think of the proposed approach?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
