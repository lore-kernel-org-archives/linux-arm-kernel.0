From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 5 Jan 2016 10:16:19 +0530
Subject: [PATCH V11 3/7] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <CAHp75Vd49-1H+1dkDmJzLpVhov1g+uJV+YiTBC9Xd3hVTmwRVg@mail.gmail.com>
References: <1451865996-12808-1-git-send-email-okaya@codeaurora.org>
 <1451865996-12808-4-git-send-email-okaya@codeaurora.org>
 <CAHp75Vd49-1H+1dkDmJzLpVhov1g+uJV+YiTBC9Xd3hVTmwRVg@mail.gmail.com>
Message-ID: <20160105044619.GJ2940@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 08:37:30PM +0200, Andy Shevchenko wrote:

> > +static int set_priority(struct hidma_mgmt_dev *mdev, unsigned int i, u64 val)
> > +{
> > +       u64 tmp;
> > +       int rc;
> > +
> > +       if (i > mdev->dma_channels)
> 
> Shouldn't be >= ? I somehow missed that.

There is no merit is posting not related context while replying, makes your
emails harder to read, please fix that

> > +               return -EINVAL;
> > +
> > +       tmp = mdev->priority[i];
> > +       mdev->priority[i] = val;
> > +       rc = hidma_mgmt_setup(mdev);
> > +       if (rc)
> > +               mdev->priority[i] = tmp;
> > +       return rc;
> > +}
> > +
> > +static int set_weight(struct hidma_mgmt_dev *mdev, unsigned int i, u64 val)
> > +{
> > +       u64 tmp;
> > +       int rc;
> > +
> > +       if (i > mdev->dma_channels)
> 
> Ditto.

Exactly, ditto...


-- 
~Vinod
