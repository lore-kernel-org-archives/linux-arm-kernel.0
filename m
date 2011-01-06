From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 6 Jan 2011 15:33:44 +0000
Subject: [PATCH] ARM: Fix warning with gcc 4.5.1 in alignment fixup
In-Reply-To: <1291753724-14437-1-git-send-email-jamie@jamieiles.com>
References: <1291753724-14437-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20110106153344.GM2946@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 08:28:44PM +0000, Jamie Iles wrote:
> With GCC 4.5.1 we get the following warning:
> 
> 	  CC      arch/arm/mm/alignment.o
> 	arch/arm/mm/alignment.c: In function 'do_alignment':
> 	arch/arm/mm/alignment.c:720:21: warning: 'offset.un' may be used
> 	uninitialized in this function
> 
> This warning is triggered for the LDM/STM instructions which don't have
> a register offset so set the offset to 0 to keep GCC happy.
> 
> Cc: George G. Davis <gdavis@mvista.com>
> Cc: Min Zhang <mzhang@mvista.com>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---

Hi Russell,

Ok to send this one to the patch system?

Jamie
