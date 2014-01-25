From: John_Mehaffey@mentor.com (Mehaffey, John)
Date: Sat, 25 Jan 2014 20:24:33 +0000
Subject: GPIO triggers kernel reboot
In-Reply-To: <371E240E6FC1D44DA5E51EE9DCDCB7845E5EA0A1@NA-MBX-01.mgc.mentorg.com>
References: <52E3E031.6040709@denx.de>
 <371E240E6FC1D44DA5E51EE9DCDCB7845E5EA0A1@NA-MBX-01.mgc.mentorg.com>
Message-ID: <371E240E6FC1D44DA5E51EE9DCDCB7845E5EA0E1@NA-MBX-01.mgc.mentorg.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-embedded-owner at vger.kernel.org 
> [mailto:linux-embedded-owner at vger.kernel.org] On Behalf Of Heiko 
> Schocher
> Sent: Saturday, January 25, 2014 8:03 AM
> To: linux-embedded at vger.kernel.org
> Cc: Wolfgang Denk; linux-arm-kernel at lists.infradead.org
> Subject: GPIO triggers kernel reboot
> 
> Hello all,
> 
> is it possible to reboot current mainline kernel triggered from a GPIO in kernel space?
> 
> If not, how can be done this, so that it has a chance to go into mainline?
> 
> Thanks for any suggestions
> 
> bye,
> Heiko

Hi Heiko,
Call kexec() from the GPIO driver.
It will take some effort to get it right :)

Or if a simple reboot is all that you want, examine the several reboot APIs in kernel/reboot.c

Sincerely,
John Mehaffey
Principal Engineer, Automotive
Mentor Graphics
> -- 
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-embedded" in the body of a message to majordomo at vger.kernel.org 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-embedded" in the body of a message to majordomo at vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
