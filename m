From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 25 Aug 2017 10:20:12 -0600
Subject: [PATCH 0/9] constify amba_id
In-Reply-To: <1503592565-21601-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503592565-21601-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <CANLsYkwVT=N8FOCOAYnZMCXEBt8aB9ovMymPYuYHLhqb4DwwGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 August 2017 at 10:35, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> amba_id are not supposed to change at runtime. All functions
> working with const amba_id. So mark the non-const structs as const.

The real explanation here is that coresight IDs are only referenced in
the amba driver declaration where the "id_table" field of struct
amba_driver is a const.  Given the widespread usage of the pattern I
would have expected this set to be part of a wide effort.  Also did
you find this manually or by using a tool?  If so please provide a
description of what that tool is.

Thanks,
Mathieu

>
> Arvind Yadav (9):
>   [PATCH 1/9] coresight: constify amba_id
>   [PATCH 2/9] coresight: etb10: constify amba_id
>   [PATCH 3/9] coresight: etm3x: constify amba_id
>   [PATCH 4/9] coresight: etm4x: constify amba_id
>   [PATCH 5/9] coresight: funnel: constify amba_id
>   [PATCH 6/9] coresight: replicator: constify amba_id
>   [PATCH 7/9] coresight: stm: constify amba_id
>   [PATCH 8/9] coresight: tmc: constify amba_id
>   [PATCH 9/9] coresight: tpiu: constify amba_id
>
>  drivers/hwtracing/coresight/coresight-cpu-debug.c       | 2 +-
>  drivers/hwtracing/coresight/coresight-etb10.c           | 2 +-
>  drivers/hwtracing/coresight/coresight-etm3x.c           | 2 +-
>  drivers/hwtracing/coresight/coresight-etm4x.c           | 2 +-
>  drivers/hwtracing/coresight/coresight-funnel.c          | 2 +-
>  drivers/hwtracing/coresight/coresight-replicator-qcom.c | 2 +-
>  drivers/hwtracing/coresight/coresight-stm.c             | 2 +-
>  drivers/hwtracing/coresight/coresight-tmc.c             | 2 +-
>  drivers/hwtracing/coresight/coresight-tpiu.c            | 2 +-
>  9 files changed, 9 insertions(+), 9 deletions(-)
>
> --
> 2.7.4
>
