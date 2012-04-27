From: balbi@ti.com (Felipe Balbi)
Date: Fri, 27 Apr 2012 21:18:36 +0300
Subject: [PATCH] clk: constify parent name arrays in macros
In-Reply-To: <CAJOA=zNzkOvzdFSuSzC015ELZWE+Jtj=H5P9fbQSHW3HZdsZow@mail.gmail.com>
References: <1335529693-14280-1-git-send-email-rnayak@ti.com>
 <CAJOA=zNzkOvzdFSuSzC015ELZWE+Jtj=H5P9fbQSHW3HZdsZow@mail.gmail.com>
Message-ID: <20120427181833.GA24587@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 10:55:50AM -0700, Turquette, Mike wrote:
> On Fri, Apr 27, 2012 at 5:28 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> > parent name array is now expected to be const char *, make
> > the relevent changes in the clk macros which define
> > default clock types.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> 
> Good catch Rajendra.  I'll pull it into clk-next.
> 
> Regards,
> Mike
> 
> > ---
> > ?include/linux/clk-private.h | ? ?6 +++---
> > ?1 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
> > index eeae7a3..6ebec83 100644
> > --- a/include/linux/clk-private.h
> > +++ b/include/linux/clk-private.h
> > @@ -70,7 +70,7 @@ struct clk {
> > ?#define DEFINE_CLK_FIXED_RATE(_name, _flags, _rate, ? ? ? ? ? ?\
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?_fixed_rate_flags) ? ? ? ? ? ? ?\
> > ? ? ? ?static struct clk _name; ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> > - ? ? ? static char *_name##_parent_names[] = {}; ? ? ? ? ? ? ? \
> > + ? ? ? static const char *_name##_parent_names[] = {}; ? ? ? ? \

does it make sense to have this as:

static const char * const _name##_parent_names[] = { }; ??

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120427/396c5483/attachment.sig>
