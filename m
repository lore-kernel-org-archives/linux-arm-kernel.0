From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Thu, 2 Dec 2010 13:04:57 +0200 (EET)
Subject: [PATCH v2] arm: mach-omap2: remove NULL board_mux from board files
In-Reply-To: <20101202103750.GM5429@legolas.emea.dhcp.ti.com>
References: <1291283622-16359-1-git-send-email-aaro.koskinen@nokia.com>
	<20101202103750.GM5429@legolas.emea.dhcp.ti.com>
Message-ID: <alpine.DEB.1.10.1012021303240.27201@esdhcp041196.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 2 Dec 2010, Felipe Balbi wrote:
> On Thu, Dec 02, 2010 at 11:53:42AM +0200, Aaro Koskinen wrote:
>> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
>> index 350c04f..e224ab5 100644
>> --- a/arch/arm/mach-omap2/mux.h
>> +++ b/arch/arm/mach-omap2/mux.h
>> @@ -133,6 +133,8 @@ static inline int omap_mux_init_signal(char *muxname, 
>> int val)
>> 	return 0;
>> }
>> 
>> +static struct omap_board_mux *board_mux __initdata 
>> __attribute__((unused));
>
> how about __unused ??

I don't think we have that:

   CC      arch/arm/mach-omap2/mux.o
In file included from arch/arm/mach-omap2/mux.c:39:
arch/arm/mach-omap2/mux.h:136: error: expected ',' or ';' before '__unused'
make[1]: *** [arch/arm/mach-omap2/mux.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

A.
