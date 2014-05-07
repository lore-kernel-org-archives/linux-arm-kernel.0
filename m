From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 7 May 2014 10:41:22 +0200
Subject: [PATCH 1/4] dma: ste_dma40: Maintain spinlock order while
 handling pause
In-Reply-To: <20140507062215.GH28638@intel.com>
References: <1398282724-2607-1-git-send-email-ulf.hansson@linaro.org>
 <20140507062215.GH28638@intel.com>
Message-ID: <CAPDyKFoitAjagRPp1Pb4uZT1-F=ZMy81TVDFA4pbB6EGDp7OMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 May 2014 08:22, Vinod Koul <vinod.koul@intel.com> wrote:
> On Wed, Apr 23, 2014 at 09:52:01PM +0200, Ulf Hansson wrote:
>> The runtime PM resume callback needs to be executed while holding the
>> spinlock, make sure to maintain this for the pause operation as well.
>
> Applied, all thanks.
>
> Though we need to change the driver to use SET_LATE_SYSTEM_SLEEP_PM_OPS as
> all dmaengine drivers should suspend late as clients can be active while
> suspending

Right, I suspected that as well - even if I did ran some tests to
verify this not to happen in practice for ux500.

Anyway, I will send a patch which converts to
SET_LATE_SYSTEM_SLEEP_PM_OPS, since for sure it makes sense.

Kind regards
Ulf Hansson

>
> --
> ~Vinod
>
