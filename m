From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 23 Apr 2018 10:24:51 +0200
Subject: [PATCH V4] PM / core: fix deferred probe breaking suspend resume
 order
In-Reply-To: <13159334.FbaSTEhggn@aspire.rjw.lan>
References: <1523404626-1466-1-git-send-email-fkan@apm.com>
 <13159334.FbaSTEhggn@aspire.rjw.lan>
Message-ID: <20180423082451.GA20822@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 10:03:19AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, April 11, 2018 1:57:06 AM CEST Feng Kan wrote:
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
> 
> I'm going to queue this up for 4.18-rc1.
> 
> If anyone, and Greg in particular, has any objections of concerns regarding
> that, please let me know.

No objection from me:
	Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
