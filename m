From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Fri, 17 Jan 2014 12:00:35 +0100
Subject: [PATCH 08/11] of: Increase MAX_PHANDLE_ARGS
In-Reply-To: <CAL_Jsq+fDUYne1OQAd4AeQw-JAoFBf0TCv4YVpy6Vt_UmdkA8A@mail.gmail.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-9-git-send-email-andreas.herrmann@calxeda.com>
 <CAL_Jsq+fDUYne1OQAd4AeQw-JAoFBf0TCv4YVpy6Vt_UmdkA8A@mail.gmail.com>
Message-ID: <20140117110035.GU3471@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 09:25:59AM -0500, Rob Herring wrote:
> On Thu, Jan 16, 2014 at 6:44 AM, Andreas Herrmann
> <andreas.herrmann@calxeda.com> wrote:
> > arm-smmu driver uses of_parse_phandle_with_args when parsing DT
> > information to determine stream IDs for a master device.
> > Thus the number of stream IDs per master device is bound by
> > MAX_PHANDLE_ARGS.
> >
> > To support Calxeda ECX-2000 hardware arm-smmu driver requires a
> > slightly higher value for MAX_PHANDLE_ARGS as this hardware has 10
> > stream IDs for one master device.
> >
> > Cc: Grant Likely <grant.likely@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree at vger.kernel.org
> > Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> One comment below...
> 
> > ---
> >  include/linux/of.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index 276c546..0807af8 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -67,7 +67,7 @@ struct device_node {
> >  #endif
> >  };
> >
> > -#define MAX_PHANDLE_ARGS 8
> > +#define MAX_PHANDLE_ARGS 10
> 
> Just bump this to 16. This is normally just a temporary on the stack
> and 8 more words on the stack is not going to cost much.

Yes, that seems reasonable.


Thanks,

Andreas
