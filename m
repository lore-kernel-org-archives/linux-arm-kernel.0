From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sat, 30 Jun 2018 18:44:39 +0530
Subject: [PATCH v2 5/6] i2c: Add Actions Semi OWL family S900 I2C driver
In-Reply-To: <CAHp75Ve5Thjsux6oaZis7axF3jZwqhr2CfrXFcpZuziszB_E9A@mail.gmail.com>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
 <20180628181042.2239-6-manivannan.sadhasivam@linaro.org>
 <CAHp75Vd__qOXVxZTdxREwD6p1sEw49R2Kqb+esAmr_EhtT=gFg@mail.gmail.com>
 <20180630124400.GB16775@Mani-XPS-13-9360>
 <CAHp75Ve5Thjsux6oaZis7axF3jZwqhr2CfrXFcpZuziszB_E9A@mail.gmail.com>
Message-ID: <20180630131439.GC16775@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Sat, Jun 30, 2018 at 04:04:20PM +0300, Andy Shevchenko wrote:
> On Sat, Jun 30, 2018 at 3:44 PM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > On Sat, Jun 30, 2018 at 03:14:37PM +0300, Andy Shevchenko wrote:
> >> On Thu, Jun 28, 2018 at 9:10 PM, Manivannan Sadhasivam
> >> <manivannan.sadhasivam@linaro.org> wrote:
> 
> >> > +static int owl_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> >> > +                               int num)
> >> > +{
> >>
> >> > +       int ret = 0, idx;
> >>
> >> Redundant assignment.
> >>
> >
> > No. Actually the return path will be fixed in next iteration. Please
> > see my reply to Peter's review for explanation.
> 
> How come? I didn't find anything related to this comment in reply you
> are referring to.
> I left deliberately the below part to show you the pointlessness of an
> assignment to 0.
>

Sorry, my bad. I overlooked this part. This assignment will be dropped.

> >> > +       ret = owl_i2c_hw_init(i2c_dev);
> >> > +       if (ret)
> >> > +               return ret;
> 
> Do you mean you are dropping this in next revision?
> 

Nope :)

Thanks,
Mani

> -- 
> With Best Regards,
> Andy Shevchenko
