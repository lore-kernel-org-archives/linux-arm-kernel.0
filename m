From: mikedunn@newsguy.com (Mike Dunn)
Date: Thu, 27 Dec 2012 05:16:16 -0800
Subject: [PATCH 1/2] ARM: pxa: palm27x: fix udc device initialization
In-Reply-To: <87sj6vmpkr.fsf@free.fr>
References: <1356200860-3241-1-git-send-email-mikedunn@newsguy.com>
 <1356200860-3241-2-git-send-email-mikedunn@newsguy.com>
 <201212230424.16848.marex@denx.de> <87sj6vmpkr.fsf@free.fr>
Message-ID: <50DC4A20.3080702@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 12/24/2012 07:34 AM, Robert Jarzmik wrote:

[..]


 Actually gpio-vbus was designed to :
>  - detect and handle VBus
>  - and handle following D+ pullup if peripheral controller *can't*
> 
> But pxa27x_udc is a peripheral controller which does handle D+ pullup, and
> expects to handle it by himself (ie. is not fully compatible with a D+ pullup
> handling by gpio-vbus, one not working case being Mike's one).
> 
> So Mike's patch makes sense IMHO. He could have left the VBUS handling to
> gpio-vbus and D+ to pxa27x_udc, or let pxa27x_udc handle both, that's up to you.


I didn't realize the pxa27x-udc driver could handle the vbus as well.


> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>


Thanks Robert.  Should have CC'd you, since you're the udc driver author.  Glad
you saw this.


Thanks again,
MIke
