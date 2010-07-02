From: inki.dae@samsung.com (In-Ki Dae)
Date: Fri, 02 Jul 2010 01:21:12 +0000 (GMT)
Subject: [PATCH 1/3] FB: Add some members for CPU Interface.
Message-ID: <5572310.15091278033672605.JavaMail.weblogic@epml12>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Andrew,

cpu timing variables could be used generically.
now fb.h and modedb.c file have been considered only for video mode.
but the way of transfering screen data includes also command mode(cpu mode or i80 mode)
so I thought it should be added things for it to fb_varscreeninfo struct.

Could you please tell me why cpu timing variables are specific to s3c-fb?
------- Original Message -------
Sender : Andrew Morton<akpm@linux-foundation.org> 
Date   : 2010-07-02 07:26 (GMT+09:00)
Title  : Re: [PATCH 1/3] FB: Add some members for CPU Interface.

On Tue, 29 Jun 2010 19:28:14 +0900
InKi Dae <inki.dae@samsung.com> wrote:

> 
> CPU interface needs cs, wr setup, wr act and hold delay.
> I added some members for them to common framework.
> 
> Signed-off-by: InKi Dae <inki.dae at samsung.com <mailto:p.osciak@samsung.com>>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com
> <mailto:kyungmin.park@samsung.com>>

These email addresses are mangled.

> --- a/drivers/video/modedb.c
> +++ b/drivers/video/modedb.c
> ...
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h

The patch seems pretty specific to s3c-fb.  Is it possible and sensible
to somhow avoid adding code to generic files?  Can we push more (or
all) of these changes into s3c-fb.c or into the arch/arm support code?
