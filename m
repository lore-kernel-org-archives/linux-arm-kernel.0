From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 10 Nov 2011 09:31:57 +0200
Subject: [PATCH v4 2/7] iommu/core: split mapping to page sizes as
 supported by the hardware
In-Reply-To: <CANqQZNH1YRSgYRVxceicQ3szD=t7zeJjhJKEQ30PeKsxtj5V+A@mail.gmail.com>
References: <1318850846-16066-1-git-send-email-ohad@wizery.com>
 <1318850846-16066-3-git-send-email-ohad@wizery.com>
 <CANqQZNH1YRSgYRVxceicQ3szD=t7zeJjhJKEQ30PeKsxtj5V+A@mail.gmail.com>
Message-ID: <CAK=WgbZbfCRJqA-wwHN=iLH6rYyoKjJCaL0zMfY93Tg6Jw2uvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 8:17 AM, Kai Huang <mail.kai.huang@gmail.com> wrote:
> Seems the unmap function don't take phys as parameter, does this mean
> domain->ops->unmap will walk through the page table to find out the
> actual page size?

The short answer is yes, and furthermore, we also consider to remove
the size param from domain->ops->unmap entirely at some point.

We had a long discussion about it, please see:

https://lkml.org/lkml/2011/10/10/234
