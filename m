From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 17 Jan 2018 14:32:11 +0900
Subject: [PATCH v2 02/13] iommu/rockchip: Suppress unbinding
In-Reply-To: <CAAFQd5C_d2JW6kPQOMQ=mB6kHMdNZQGFvamjaDhexoPD_4W7+A@mail.gmail.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
 <20180116132540.18939-3-jeffy.chen@rock-chips.com>
 <CAAFQd5C_d2JW6kPQOMQ=mB6kHMdNZQGFvamjaDhexoPD_4W7+A@mail.gmail.com>
Message-ID: <CAAFQd5CXH_20649oZNrzFjHoKfpDi6gHF91jd3uCyjyOkH+Ohw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 1:23 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> On Tue, Jan 16, 2018 at 10:25 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>> It's not safe to unbind rockchip IOMMU driver.
>
> Might be good to explain why it is not safe and actually add that it
> does not make any sense for such low level devices.

Actually, shouldn't we also remove support for .remove() and module
exit? I don't think it's actually feasible to unload this driver. We
actually even have ROCKCHIP_IOMMU Kconfig entry defined as bool, so
the driver can be only built-in.

Best regards,
Tomasz
