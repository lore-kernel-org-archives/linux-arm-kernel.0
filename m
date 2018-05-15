From: kim.phillips@arm.com (Kim Phillips)
Date: Tue, 15 May 2018 08:15:19 -0500
Subject: [PATCH 1/4] amba: Export amba_bustype
In-Reply-To: <CAPDyKFqagt5zhz-8hLSXOqofv-nBqg4i-EVjA=UV3Jfi4zktKg@mail.gmail.com>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
 <CAPDyKFqagt5zhz-8hLSXOqofv-nBqg4i-EVjA=UV3Jfi4zktKg@mail.gmail.com>
Message-ID: <20180515081519.22751a39c49e63224da3acac@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 May 2018 08:59:02 +0200
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On 8 May 2018 at 21:06, Kim Phillips <kim.phillips@arm.com> wrote:
> > This patch is provided in the context of allowing the Coresight driver
> > subsystem to be loaded as modules.  Coresight uses amba_bus in its call
> > to bus_find_device() in of_coresight_get_endpoint_device() when
> > searching for a configurable endpoint device.  This patch allows
> > Coresight to reference amba_bustype when built as a module.
> 
> Sounds like you are fixing a bug, don't your want this to go for
> stable and then also add a fixes tag?

How do you consider this a bug fix?  What commit would the fixes tag
reference?  The introduction of the amba bus?  Not only aren't busses
required to export their bus_type, but that commit predates git.

Kim
