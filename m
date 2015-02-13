From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 13 Feb 2015 15:02:40 +0100
Subject: [RFC PATCH] ARM: LL_DEBUG: Fix hang on i.MX53 when wrong port
 selected.
In-Reply-To: <20150213124849.22919.14204.stgit@localhost>
References: <20150213124849.22919.14204.stgit@localhost>
Message-ID: <20150213140240.GD6000@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On 13/02/2015 at 13:48:49 +0100, Martin Fuzzey wrote :
> Attempts to access the i.MX53 UART data registers while the UART
> is not enabled cause the processor to hang.
> 
> This can occur when CONFIG_LL_DEBUG is selected but
> CONFIG_DEBUG_IMX_UART_PORT does not correspond to the
> port enabled by the bootloader.
> 
> So, do not attempt to send any data if the port is not enabled.
> 
> Checking the enabled bit requires an extra scratch register.
> For the moment I have only added this to the imx version.
> Obviously, if this solution is acceptable, the register would have to be
> added to all the other implementations too in order to avoid breaking
> the build.
> 
> Hence RFC status for the moment to see if there are any better ideas.
> 

I think the current consensus is to not try to fix CONFIG_LL_DEBUG too
much as if you use it it means you know what you are doing, refer to the
following discussion:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/319187.html

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
