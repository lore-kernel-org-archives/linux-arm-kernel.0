From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 30 Mar 2018 17:50:24 -0500
Subject: [PATCH V3] PM / core: fix deferred probe breaking suspend resume
 order
In-Reply-To: <CAL85gmAAVoCCXoLH+c0ROSBy4mS3z86tnbX+7Avh5oGT=fHcfA@mail.gmail.com>
References: <1520274579-30492-1-git-send-email-fkan@apm.com>
 <CAL85gmAAVoCCXoLH+c0ROSBy4mS3z86tnbX+7Avh5oGT=fHcfA@mail.gmail.com>
Message-ID: <20180330225024.GH9322@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 11:41:33AM -0700, Feng Kan wrote:
> On Mon, Mar 5, 2018 at 10:29 AM, Feng Kan <fkan@apm.com> wrote:
> > When bridge and its endpoint is enumerated the devices are added to the
> > dpm list. Afterward, the bridge defers probe when IOMMU is not ready.
> > This causes the bridge to be moved to the end of the dpm list when
> > deferred probe kicks in. The order of the dpm list for bridge and
> > endpoint is reversed.
> >
> > Add reordering code to move the bridge and its children and consumers to
> > the end of the pm list so the order for suspend and resume is not altered.
> > The code also move device and its children and consumers to the tail of
> > device_kset list if it is registered.
> >
> > Signed-off-by: Feng Kan <fkan@apm.com>
> > Signed-off-by: Toan Le <toanle@apm.com>
> > ...
> >
> Hi, just wanted to check if there is anything else I need to change on
> this. Thanks.

I'm assuming Rafael will handle this.
