From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 26 Sep 2015 16:47:07 +0200
Subject: [PATCH v3 14/26] ARM: pxa: magician: Fix platform data for both
 PXA27x I2C controllers
In-Reply-To: <55FA48BD.4050900@tul.cz> (Petr Cvek's message of "Thu, 17 Sep
 2015 06:59:41 +0200")
References: <cover.1442462898.git.petr.cvek@tul.cz> <55FA48BD.4050900@tul.cz>
Message-ID: <87bncpkzkk.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> This patch changes fast_mode settings for the normal and power I2C
> controller on the HTC Magician machine.
>
> Connected device on the Power I2C:
> - MAX1587A: working in the fast mode
>
> Connected devices on the Normal I2C:
> - UDA1380: working in the fast mode
> - OV9640: bus became stuck in the fast mode
>
> The OV9640 is not using a standard I2C protocol, but an SCCB variant. Maybe
> it is not fully compatible in the fast mode. Therefore fast mode for normal
> I2C is disabled. If you not using the OV9640 then you can enable the fast
> mode for the UDA1380.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Waiting for a week for Philipp's ack and queuing it after.

Cheers.

--
Robert
