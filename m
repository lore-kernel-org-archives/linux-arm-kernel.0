From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 1 Jul 2010 01:16:35 +0400
Subject: [PATCH v2 3/3] ARM: cns3xxx: Add support for SMP
In-Reply-To: <20100618203702.GC9155@oksana.dev.rtsoft.ru>
References: <20100618181707.GA21578@n2100.arm.linux.org.uk>
	<20100618203702.GC9155@oksana.dev.rtsoft.ru>
Message-ID: <20100630211635.GB29737@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 19, 2010 at 12:37:02AM +0400, Anton Vorontsov wrote:
> Thanks to the previous refactorings, nothing fancy needs to be
> done, just use generic SCU routines.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---
[...]
> @@ -3,6 +3,7 @@ menu "CNS3XXX platform type"
>  
>  config MACH_CNS3420VB
>  	bool "Support for CNS3420 Validation Board"
> +	select HAVE_ARM_SCU

This should be 'select HAVE_ARM_SCU if SMP', otherwise non-SMP build
fails.

Apart from this, Russell, do these patches look OK?

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
