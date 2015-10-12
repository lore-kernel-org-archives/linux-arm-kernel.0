From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 12 Oct 2015 15:27:03 +0200
Subject: [PATCH] sata/mvebu: use #ifdef around suspend/resume code
In-Reply-To: <5727002.l6plqmRKB3@wuerfel>
References: <5727002.l6plqmRKB3@wuerfel>
Message-ID: <20151012152703.4d82bd02@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Mon, 12 Oct 2015 15:05:27 +0200, Arnd Bergmann wrote:

> +#ifdef CONFIG_PM_SUSPEND

Shouldn't this be CONFIG_PM_SLEEP ?

The generic suspend/resume function in libahci_platform.c are defined
when CONFIG_PM_SLEEP is enabled.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
