From: tj@kernel.org (Tejun Heo)
Date: Wed, 25 Oct 2017 07:54:50 -0700
Subject: [PATCH] ata: fixes kernel crash while tracing
 ata_eh_link_autopsy event
In-Reply-To: <1508926976-11467-1-git-send-email-rsahu@apm.com>
References: <1508926976-11467-1-git-send-email-rsahu@apm.com>
Message-ID: <20171025145450.GA59538@devbig577.frc2.facebook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Oct 25, 2017 at 03:52:56PM +0530, Rameshwar Prasad Sahu wrote:
> @@ -288,8 +289,8 @@
>  	),
> 
>  	TP_fast_assign(
> -		__entry->ata_port	= dev->link->ap->print_id;
> -		__entry->ata_dev	= dev->link->pmp + dev->devno;
> +		__entry->ata_port	= link->ap->print_id;
> +		__entry->ata_dev	= link->pmp + link->device->devno;

The above is wrong if there are multiple devices on the link.  It
probably should take both link and dev and use dev iff it's not NULL.

Thanks.

-- 
tejun
