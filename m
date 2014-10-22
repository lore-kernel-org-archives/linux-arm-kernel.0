From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 22 Oct 2014 10:45:44 -0700
Subject: [PATCH v5 1/3] power-domain: add power domain drivers for
 Rockchip platform
In-Reply-To: <CAPDyKFp+aNJd_FEY6=-ubK0zvVDWh+x5ZsVG+AVpuBzpSqynOQ@mail.gmail.com>
References: <1413882808-4669-1-git-send-email-jinkun.hong@rock-chips.com>
 <1413882808-4669-2-git-send-email-jinkun.hong@rock-chips.com>
 <20141021195854.GE8609@dtor-ws> <544725C4.4040703@rock-chips.com>
 <CAPDyKFp+aNJd_FEY6=-ubK0zvVDWh+x5ZsVG+AVpuBzpSqynOQ@mail.gmail.com>
Message-ID: <20141022174544.GA4250@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 09:58:34AM +0200, Ulf Hansson wrote:
> 
> Using the devm_*API is supposed to work from here. I have kept this in
> mind, while we added the new dev_pm_domain_attach|detach() API. The
> buses also handles -EPROBE_DEFER.

How do you ensure this? You have no control over from where API is
called. If I happen to call it form anywhere but bus probe code path I
will be leaking memory at least until the device is unbound completely
(which would be in this case an unrelated event).

Thanks.

-- 
Dmitry
