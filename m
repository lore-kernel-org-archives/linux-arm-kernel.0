From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Thu, 26 Mar 2015 09:31:50 +0200
Subject: [PATCH 2/6] i2c: qup: Add V2 tags support
In-Reply-To: <55139CD4.5040100@codeaurora.org>
References: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
 <1426268992-19298-3-git-send-email-sricharan@codeaurora.org>
 <1427286263.25053.18.camel@mm-sol.com> <55139CD4.5040100@codeaurora.org>
Message-ID: <1427355110.7093.1.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sricharan,

On Thu, 2015-03-26 at 11:14 +0530, Sricharan R wrote:
> 
> > > +       if (msg->flags & I2C_M_RD)
> > > +               qup->rx_tag_len = (qup->blocks << 1);
> > 
> > here again.
> > 
> hmm, why not shift ?

Because it makes reading code harder and because compiler
 is smart enough to choose appropriate instruction for
underling CPU architecture.

> > > +       else
> > > +               qup->rx_tag_len = 0;
> > > +}
> > > +
> > > +static u32 qup_i2c_xfer_data(struct qup_i2c_dev *qup, int len,
> > > +                                                               u8 *buf, int last)
> > > +{
> > 
> > I think that xfer is too vague in this case, prefer write or send.
> > 
> ok. Will change it to send.
> > > +       static u32 val, idx;
> > 
> > static? please fix.
>   That was intentional. Using to pack tag and data in to one word across
>   two calls. So preserving val, idx across calls.

Sorry this is no go! Reorganize the code, please.

Regards,
Ivan
