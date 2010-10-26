From: felipe.contreras@nokia.com (Felipe Contreras)
Date: Tue, 26 Oct 2010 20:07:57 +0300
Subject: [PATCH 1/8] staging: tidspbridge - remove req_addr from proc_map
In-Reply-To: <496565EC904933469F292DDA3F1663E602F49E280A@dlee06.ent.ti.com>
References: <1288054306-4361-1-git-send-email-x0095840@ti.com>
	<1288054306-4361-2-git-send-email-x0095840@ti.com>
	<AANLkTimCDM_nruvh_gqxxy0CVnw2sH5UYNT9VgyeBfZN@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602F49E280A@dlee06.ent.ti.com>
Message-ID: <1288112616-notmuch-felipe.contreras@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fernando.lugo at ti.com wrote:
> > On Tue, Oct 26, 2010 at 3:51 AM, Fernando Guzman Lugo 
> > <x0095840@ti.com> wrote:
> > > The device address is assigned by tidspbridge no need for 
> > that parameter anymore.
> > >
> > > Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> > 
> > This would break the API with user-space, right?
> 
> Yes, user-space needs to be changed accordingly.

Wouldn't it make sense to avoid stuffing so many changes at once
including ABI breakage?

Does user-space really _needs_ to be changed? Can't you just ignore that
argument?

> > I think this change should be delayed, preferably after we 
> > have a working tidspbridge.
> 
> The issue you were seeing must be fixed with patch 2/8, and
> Having all the dependencies tidspbridge has to be working
> Properly.

Yes, which might not happen at .37. If we revert the iommu stuff, we
might have a chance at having a working bridge on .37.

-- 
Felipe Contreras
