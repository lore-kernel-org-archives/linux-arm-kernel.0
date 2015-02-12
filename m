From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 12 Feb 2015 10:13:36 -0500 (EST)
Subject: [PATCH RFC v4 1/3] PM / Runtime: Add an API pm_runtime_set_slave
In-Reply-To: <CADGdYn6OwXgsGFspQva-q5WV5b_WB=G2PxZyhcETTgt8zY96ZQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1502121010070.1209-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Feb 2015, amit daniel kachhap wrote:

> Hi Alan,
> 
> On Mon, Feb 9, 2015 at 9:28 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Mon, 9 Feb 2015, Amit Daniel Kachhap wrote:
> >
> >> This API creates a pm runtime slave type device which does not itself
> >> participates in pm runtime but depends on the master devices to power
> >> manage them.
> >
> > This makes no sense.  How can a master device manage a slave device?
> > Devices are managed by drivers, not by other devices.
> May be my commit is not explaining the requirements completely and the
> API name may not reflect the relevance. But If you see the 3rd patch
> it has one clock use-case where this new feature is used and the
> current pm runtime feature is not sufficient enough to handle it. I
> have one more IOMMU use case also which is not part of this patch
> series.

Regardless, your description should say what is really happening.  The
master device doesn't power-manage the clock; some driver power-manages
it.

> I am not sure if this approach is final but I looked at runtime.c file
> and it has couple of API's like pm_runtime_forbid/allow which
> blocks/unblocks the runtime callbacks according to driver requirement.
> In the similar line I added this new API.

forbid/allow blocks/unblocks runtime PM according to the user's 
requirements, not the driver's requirements.

> > Besides, doesn't the no_callbacks flag already do more or less what you
> > want?
> yes to some extent. But I thought its purpose is different so I added 1 more.

The purpose doesn't matter.  If no_callbacks does what you want then 
you should use it instead of adding another API.

Alan Stern
