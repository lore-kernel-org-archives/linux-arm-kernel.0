From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 6 Jul 2013 13:08:05 +0800
Subject: [PATCH v3 4/6] ARM: dts: imx6q{dl}: fix the wrong RTS/CTS pad name
In-Reply-To: <1373004752-21302-5-git-send-email-b32955@freescale.com>
References: <1373004752-21302-1-git-send-email-b32955@freescale.com>
 <1373004752-21302-5-git-send-email-b32955@freescale.com>
Message-ID: <20130706050803.GC30164@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 02:12:30PM +0800, Huang Shijie wrote:
> There is something wrong with the RTS/CTS pads:
>   The RTS pad is assigned with the CTS's value;
>   while the CTS pad is assigned with the RTS's value.
> 

So basically, you are saying that select_input should be set up for CTS
rather than RTS.  It seems that the people who generated the macro got
the wrong input from developer.

So imx6sl-pinfunc.h also needs to be fixed up.

Shawn

> In order to fix it, this patch exchanges the RTS/CTS pad name.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/boot/dts/imx6dl-pinfunc.h |   88 ++++++++++++++++++------------------
>  arch/arm/boot/dts/imx6q-pinfunc.h  |   88 ++++++++++++++++++------------------
>  2 files changed, 88 insertions(+), 88 deletions(-)
