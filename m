From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 26 Apr 2013 11:09:33 -0700
Subject: [PATCH v2 0/6] ARM;
 OMAP2+: hwmod and SERIAL: Remove sysc handling from driver
In-Reply-To: <1366973695-2088-1-git-send-email-rnayak@ti.com> (Rajendra
 Nayak's message of "Fri, 26 Apr 2013 16:24:49 +0530")
References: <1366973695-2088-1-git-send-email-rnayak@ti.com>
Message-ID: <87ppxhxixu.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rajendra Nayak <rnayak@ti.com> writes:

[...]

> OMAP UART IP needs manual idle modes based on functional state of the
> IP. Currently this is handled by the driver with function pointers
> implemented in platform code.
>
> This however breaks in case of device tree because of missing
> idle handling. 
>
> The series tries to address the issue and tries to remove complete
> sysc handling from serial driver.

Other than the minor nit about the order of the series for bisect, 

Reviewed-by: Kevin Hilman <khilman@linaro.org>

Also tested this on OMAP4/Panda where I was having the sluggish console
issues using DT boot, and and can confirm that this fixes the problem:

Tested-by: Kevin Hilman <khilman@linaro.org>  # OMAP4/Panda

Kevin
