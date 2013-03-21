From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 21 Mar 2013 11:45:01 +0200
Subject: [PATCH] clk: add table lookup to mux
In-Reply-To: <20130320155158.11073.43798@quantum>
References: <1363113747-6572-1-git-send-email-pdeschrijver@nvidia.com>
 <20130319235110.8663.67548@quantum>
 <20130320094957.GG18519@tbergstrom-lnx.Nvidia.com>
 <20130320155158.11073.43798@quantum>
Message-ID: <20130321094501.GP18519@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 04:51:58PM +0100, Mike Turquette wrote:
> Quoting Peter De Schrijver (2013-03-20 02:49:57)
> > On Wed, Mar 20, 2013 at 12:51:10AM +0100, Mike Turquette wrote:
> > > Quoting Peter De Schrijver (2013-03-12 11:42:23)
> > > > diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
> > > > index 9c7f580..53d39c2 100644
> > > > --- a/include/linux/clk-private.h
> > > > +++ b/include/linux/clk-private.h
> > > > @@ -144,12 +144,13 @@ struct clk {
> > > >  
> > > >  #define DEFINE_CLK_MUX(_name, _parent_names, _parents, _flags, \
> > > >                                 _reg, _shift, _width,           \
> > > > -                               _mux_flags, _lock)              \
> > > > +                               _mux_flags, _table, _lock)      \
> > > >         static struct clk _name;                                \
> > > >         static struct clk_mux _name##_hw = {                    \
> > > >                 .hw = {                                         \
> > > >                         .clk = &_name,                          \
> > > >                 },                                              \
> > > > +               .table = _table,                                \
> > > >                 .reg = _reg,                                    \
> > > >                 .shift = _shift,                                \
> > > >                 .width = _width,                                \
> > > 
> > > This breaks OMAP horribly since OMAP already uses this macro.  There are
> > > two options:
> > > 
> > > 1) stop using statically initialized data and no longer use
> > > clk-private.h macros.  I was under the impression that the tegra clock
> > > data no longer required this?
> > 
> > Ok. We don't do that anymore. Maybe I just modified it out of habbit...
> > 
> 
> Cool.  Will you send a V2 that drops the macro changes?
> 

Yes. Coming soon :)

Cheers,

Peter.
