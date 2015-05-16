From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sat, 16 May 2015 11:43:26 +0300
Subject: [PATCH v3 4/4] remoteproc/wkup_m3: add a remoteproc driver for TI
 Wakeup M3
In-Reply-To: <5550C43F.3070507@ti.com>
References: <1427917039-43206-1-git-send-email-d-gerlach@ti.com>
 <1427917039-43206-5-git-send-email-d-gerlach@ti.com>
 <CAK=WgbaQPK1x6k8iq8DDCSRpna4HRyDJ-MTU+DTAst6VZy13_Q@mail.gmail.com>
 <5550C43F.3070507@ti.com>
Message-ID: <CAK=WgbaooxQyTYJ8rTP5ss9_hMuWbvYjeAJTKq5kVqYuXaweuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On Mon, May 11, 2015 at 6:01 PM, Suman Anna <s-anna@ti.com> wrote:
> We don't have any carveouts or usage of any external DDR, as this
> processor is used during Power Management, like cpuidle or suspend path,
> and is used to control the MPU and DDR states. The resource table is
> very simple and straight-forward [1].

Ok thanks.

Could you please document in the patch how the WkupM3 memory is
managed? Perhaps add to this latter explanation of yours also what
stands behind the umem/dmem names, justify usage of '__force' and
document the code around the l4_offset math (which I suspect may not
always be correct, as it seems the value of l4_offset depends on the
order of mem resources returned by platform_get_resource_byname).

Thanks,
Ohad.
