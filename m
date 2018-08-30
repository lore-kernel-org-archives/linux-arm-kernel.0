From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Thu, 30 Aug 2018 08:30:59 +0000
Subject: [PATCH v4 1/2] clk: Add of_clk_get_by_name_optional() function
In-Reply-To: <20180829171039.GD11447@smile.fi.intel.com>
References: <1533039060-18779-1-git-send-email-phil.edworthy@renesas.com>
 <1533039060-18779-2-git-send-email-phil.edworthy@renesas.com>
 <20180829171039.GD11447@smile.fi.intel.com>
Message-ID: <TY1PR01MB176960BEDC23EA64095EF6F2F5080@TY1PR01MB1769.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On 29 August 2018 18:11 Andy Shevchenko wrote:
> On Tue, Jul 31, 2018 at 01:10:59PM +0100, Phil Edworthy wrote:
> > Quite a few drivers get an optional clock, e.g. a clock required
> > to access peripheral's registers that is always enabled on some
> > devices.
> >
> > This function behaves the same as of_clk_get_by_name() except that
> > it will return NULL instead of -ENOENT.
> 
> > +		if (optional && (index == -EINVAL || index == -ENODATA ||
> > +		    PTR_ERR(clk) == -ENOENT)) {
> 
> A nit: I would rather rearrange this to be
> 
> if (optional &&
>     (... || ... || ...)) {
> 
> (disregard 80 characters limit for second line)

Thanks for the review. I'm not particularly happy with the patch as is, it's
pretty messy. I was in rush trying to get things done before holidays - always
a mistake.
Would you mind if I sent a v5 that I feel is somewhat clearer?

Thanks
Phil
