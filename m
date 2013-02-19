From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 19 Feb 2013 15:48:27 +0530
Subject: [PATCH, RFC 3/8] ARM: twd: clock rate from DT (if no DT clk tree)
In-Reply-To: <94cb377171f84ceefd667aead4602d70adab6619.1361186097.git.afzal@ti.com>
References: <cover.1361186097.git.afzal@ti.com>
 <94cb377171f84ceefd667aead4602d70adab6619.1361186097.git.afzal@ti.com>
Message-ID: <51235173.5020000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 February 2013 05:07 PM, Afzal Mohammed wrote:
> Add an optional property to find clock-frequency from DT. This helps
> as a fallback mechanism in case there is no representation of clock
> tree in DT.
>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
This won't work always because twd clock is CPU dependent and changes
with CPU clock speed. And more importantly to get CPUFreq working, you
need to provide the correct clock-node to TWD library. Refer OMAP4 clock
data for reference.

Regards,
Santosh
