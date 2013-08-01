From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 01 Aug 2013 13:04:12 +0200
Subject: [PATCH] pinctrl: at91: choose appropriate handler for level
 interrupts
In-Reply-To: <1374331893-16009-1-git-send-email-b.brezillon@overkiz.com>
References: <1374331893-16009-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <51FA40AC.8060900@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20/07/2013 16:51, Boris BREZILLON wrote:
> The current implementation handle both edge and level interrupts with the
> 'handle_simple_irq' handler.
>
> Level interrupts are active as long as the pin stays at the configured
> level (low or high). In this case we have to use 'handle_level_irq' which
> mask the interrupt until the handle has treated it.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

This solves the issue on my side.

Tested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
