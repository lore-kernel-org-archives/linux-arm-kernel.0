From: dann.frazier@canonical.com (Dann Frazier)
Date: Mon, 10 Aug 2015 10:37:13 -0600
Subject: [PATCH v2 0/3] edac: Add L3/SoC support to the APM X-Gene SoC
 EDAC driver
In-Reply-To: <1437808063-17592-1-git-send-email-lho@apm.com>
References: <1437808063-17592-1-git-send-email-lho@apm.com>
Message-ID: <CALdTtnv7P5d0Y6wyKe1SOqXedNhQxMsFZY=m-rxK3zouLcFv-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 25, 2015 at 1:07 AM, Loc Ho <lho@apm.com> wrote:
> v2:
> * Update binding documentation accordingly
> * Change all single bit defines to BIT(x)
> * Add support for L3 version 1 and 2 HW's
> * Change to use debug file system for error injection
> * In L3/SoC instance add function, allocate EDAC context after all
>   initalization successed
> * Support raw or detail info for SoC EDAC error reporting
>
> v1:
> * Add L3/SoC support to the APM X-Gene SoC EDAC driver

Loc,
  I tested 4.2-rc5 on a Mustang board with one DIMM, and it hangs (RCU
stall) in xgene_edac_mc_irq_ctl() on modprobe. Same board with 2 DIMMs
boots fine. (U-boot 1.15.12).

 -dann
