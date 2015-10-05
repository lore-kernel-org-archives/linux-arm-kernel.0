From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 05 Oct 2015 21:50:32 +0200
Subject: [PATCH] ARM: pxa: z2: Fix section mismatch
In-Reply-To: <1444034228-9249-1-git-send-email-thierry.reding@gmail.com>
 (Thierry Reding's message of "Mon, 5 Oct 2015 10:37:08 +0200")
References: <1444034228-9249-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <87mvvxayd3.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding <thierry.reding@gmail.com> writes:

> The z2_power_off() function calls pxa27x_set_pwrmode(), which is marked
> __init. z2_power_off() is set up as the power off handler, so will need
> to stick around after __init data is discarded. Fix this by doing what
> everyone else does and set the power mode from the board initialization
> code instead.
Applied to pxa/fixes, thanks.

Cheers.

--
Robert
