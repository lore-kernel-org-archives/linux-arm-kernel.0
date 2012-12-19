From: mikpe@it.uu.se (Mikael Pettersson)
Date: Wed, 19 Dec 2012 15:58:27 +0100
Subject: [PATCH 3/3] kcmp: enable the kcmp syscall when C/R is enabled
In-Reply-To: <1355923677-18249-4-git-send-email-alekskartashov@parallels.com>
References: <1355923677-18249-1-git-send-email-alekskartashov@parallels.com>
 <1355923677-18249-4-git-send-email-alekskartashov@parallels.com>
Message-ID: <20689.54803.684081.31731@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Kartashov writes:
 > --- a/arch/arm/kernel/calls.S
 > +++ b/arch/arm/kernel/calls.S
 > @@ -387,7 +387,7 @@
 >  /* 375 */	CALL(sys_setns)
 >  		CALL(sys_process_vm_readv)
 >  		CALL(sys_process_vm_writev)
 > -		CALL(sys_ni_syscall)	/* reserved for sys_kcmp */
 > +		CALL(sys_kcmp)	/* reserved for sys_kcmp */

The /* reserved for sys_kcmp */ comment is now obsolete and should be removed.
