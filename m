From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Tue, 05 Oct 2010 09:28:28 +0200
Subject: I.MX35 GPIO IRQ + Preempt -> Oops
In-Reply-To: <201010051606.24617.marc@cpdesign.com.au>
References: <4CA739B4.1020506@eukrea.com>
	<4CA98B8C.4010106@eukrea.com>	<4CA9C384.2070208@eukrea.com>
	<201010051606.24617.marc@cpdesign.com.au>
Message-ID: <4CAAD39C.2010103@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Le 05/10/2010 07:06, Marc Reilly a ?crit :
> For what it's worth...
>
>> Also : same problem with Freescale's BSP (2.6.31 based) and same "fix"
>> (removing the WFI).
>
> My kernel won't even boot up (although I don't usually get a kernel oops, only
> very occasionally) unless i pass the jtag=on parameter (or nohlt for non
> freescale kernel). It just freezes.
>
> I think both of those workarounds effectively bypass the cpu_do_idle() call.
>
exactly and it seems the workaround existed in the past in Freescale's 
kernel ( TLSbo65953 is the errata number for i.MX31 ) :
http://svn.buglabs.net/svn/!source/9783/bug/trunk/bug-linux-2.6.27.2/arch/arm/mach-mx3/mxc_pm.c#359

Eric
