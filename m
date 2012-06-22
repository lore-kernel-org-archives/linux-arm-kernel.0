From: mturquette@ti.com (Turquette, Mike)
Date: Thu, 21 Jun 2012 19:52:30 -0700
Subject: [PATCH] clk: mxs: mx23,
 mx28: fix clock lookup after freeing init memory
In-Reply-To: <20120622020726.GC21418@S2101-09.ap.freescale.net>
References: <1340301865-15815-1-git-send-email-mkl@pengutronix.de>
 <20120622020726.GC21418@S2101-09.ap.freescale.net>
Message-ID: <CAJOA=zNeSPdNrP0Z8ymaYMjHA4dVoBrPSEWrumNXT04gVQak-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 7:07 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Thu, Jun 21, 2012 at 08:04:25PM +0200, Marc Kleine-Budde wrote:
>> The struct clk_lookup are marked as __initdata, resulting in beeing
>> removed from memory after the kernel finished booting. However this
>> leads to a NULL pointer de-ref if loading a module which uses clk_get.
>>
>> This patch removes the __initdata from the struct clk_lookup.
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> Thanks for the fixing. ?Will try to send it for -rc together with
> another fixing on imx28 clock code.
>

Looks like a clk-fixes branch is in order.  There are at least three
fixes that need to into the 3.5 bugfix window.  I'll push such a
branch to my linaro git tree tomorrow.

Mike

> Regards,
> Shawn
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
