From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 03 Apr 2018 16:11:49 +0000
Subject: [PATCH v8 11/14] iommu/rockchip: Use OF_IOMMU to attach devices
 automatically
In-Reply-To: <5AB8A7F0.1090305@rock-chips.com>
References: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
 <20180323073814.5802-12-jeffy.chen@rock-chips.com>
 <CAGS+omDUve9DTMJY8FdWBBxQgCOACLYLsRuzmQzd3Fh7TeekDw@mail.gmail.com>
 <5AB8A7F0.1090305@rock-chips.com>
Message-ID: <CAGS+omCN7cXY0APvFuL_wmZeXihivu4hF0+ZfLFffvdZyK9f6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy,

Sorry for delayed response.

On Mon, Mar 26, 2018 at 1:58 AM JeffyChen <jeffy.chen@rock-chips.com> wrote:

> Hi Daniel,

> Thanks for your reply.

> On 03/26/2018 02:31 PM, Daniel Kurtz wrote:
> >> >+struct rk_iommudata {
> >> >+       struct rk_iommu *iommu;
> >> >+};
> > Why do we need this struct?  Can't we just assign a pointer to struct
> > rk_iommu directly to dev->archdata.iommu?
> >
> hmmm, i was trying to add more device related data in patch[13]:

>    struct rk_iommudata {
> +       struct device_link *link; /* runtime PM link from IOMMU to master
*/
>          struct rk_iommu *iommu;
>    };
> >

Can't you just add link to rk_iommu directly?
