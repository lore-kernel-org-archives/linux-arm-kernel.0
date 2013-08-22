From: dinguyen@altera.com (Dinh Nguyen)
Date: Thu, 22 Aug 2013 11:19:21 -0500
Subject: [PATCHv3 3/4] clocksource: dw_apb_timer: Move timer defines to
 header file.
In-Reply-To: <20130822110118.GB19347@amd.pavel.ucw.cz>
References: <1377118427-20644-1-git-send-email-dinguyen@altera.com>
 <1377118427-20644-3-git-send-email-dinguyen@altera.com>
 <20130822110118.GB19347@amd.pavel.ucw.cz>
Message-ID: <1377188361.30624.18.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-08-22 at 13:01 +0200, ZY - pavel wrote:
> Hi!
> 
> On Wed 2013-08-21 15:53:46, dinguyen at altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Move all dw_apb_timer defines to include/linux/dw_apb_timer.h.
> 
> That makes sense. But the changelog says "move" while the patch only
> adds them to second place, which can not be right.

Oops, must not have saved on one of my shells. Thanks for the review.
Will post a v4 asap.

> 
> Is there public git tree with the patches somewhere?

git://git.rocketboards.org/linux-socfpga-next.git

Dinh
> 
> Thanks,
> 								Pavel
> 
> > ---
> >  include/linux/dw_apb_timer.h |   19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/include/linux/dw_apb_timer.h b/include/linux/dw_apb_timer.h
> > index 1f79b20..1d2b949 100644
> > --- a/include/linux/dw_apb_timer.h
> > +++ b/include/linux/dw_apb_timer.h
> > @@ -19,6 +19,25 @@
> >  
> >  #define APBTMRS_REG_SIZE       0x14
> >  
> > +#define APBT_MIN_PERIOD                 4
> > +#define APBT_MIN_DELTA_USEC             200
> > +
> > +#define APBTMR_N_LOAD_COUNT             0x00
> > +#define APBTMR_N_CURRENT_VALUE          0x04
> > +#define APBTMR_N_CONTROL                0x08
> > +#define APBTMR_N_EOI                    0x0c
> > +#define APBTMR_N_INT_STATUS             0x10
> > +
> > +#define APBTMRS_INT_STATUS              0xa0
> > +#define APBTMRS_EOI                     0xa4
> > +#define APBTMRS_RAW_INT_STATUS          0xa8
> > +#define APBTMRS_COMP_VERSION            0xac
> > +
> > +#define APBTMR_CONTROL_ENABLE           (1 << 0)
> > +/* 1: periodic, 0:free running. */
> > +#define APBTMR_CONTROL_MODE_PERIODIC    (1 << 1)
> > +#define APBTMR_CONTROL_INT              (1 << 2)
> > +
> >  struct dw_apb_timer {
> >  	void __iomem				*base;
> >  	unsigned long				freq;
> 
