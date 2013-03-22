From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 22 Mar 2013 13:41:12 -0700
Subject: [PATCH V2 2/3] clk: Improve errorhandling for clk_set_parent
In-Reply-To: <CA+Z25wWnGFFK9d+zdL+6iDDmS=0PKGDtU=+rePeGTv8PMtgSOg@mail.gmail.com>
References: <1363873693-30902-1-git-send-email-ulf.hansson@stericsson.com>
 <1363873693-30902-3-git-send-email-ulf.hansson@stericsson.com>
 <20130321210019.834.12024@quantum>
 <CA+Z25wWnGFFK9d+zdL+6iDDmS=0PKGDtU=+rePeGTv8PMtgSOg@mail.gmail.com>
Message-ID: <20130322204112.834.21029@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Rajagopal Venkat (2013-03-22 02:59:17)
> On 22 March 2013 02:30, Mike Turquette <mturquette@linaro.org> wrote:
> > Quoting Ulf Hansson (2013-03-21 06:48:12)
> >> @@ -1344,8 +1341,9 @@ out:
> >>  int clk_set_parent(struct clk *clk, struct clk *parent)
> >>  {
> >>         int ret = 0;
> >> +       u8 p_index;
> >>
> >> -       if (!clk || !clk->ops)
> >> +       if (!clk || !clk->ops || !parent)
> >>                 return -EINVAL;
> >>
> >
> > A NULL clock is valid according to the clk.h api.  I would like to allow
> > parent to be NULL, resulting in a migration from the real clock tree to
> > the orphans list.
> >
> > This feature was apparently buggy for some time and Rajagopal sent me a
> > patch off-list to fix it.  Rajagopal, can you post your patch publicly?
> >
> 
> Patch is available at https://patchwork.kernel.org/patch/2012221/
> Do you want me to rebase it on top of this patchset?
> 

Maybe.  Let's see what Ulf's next version of the clk_set_parent locking
patch looks like.

Thanks,
Mike

> > Thanks,
> > Mike
> 
> 
> 
> -- 
> Regards,
> Rajagopal
