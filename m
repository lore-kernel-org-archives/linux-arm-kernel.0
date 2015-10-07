From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  7 Oct 2015 11:58:56 +0100
Subject: [PATCH v2 0/3] nvmem: make sysfs binary file permissions more
 flexible.
Message-ID: <1444215536-10783-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg, 

If its not too late for v4.4, can you please consider this patchset for v4.4.

Recent discussion raised by Andrew Lunn and others regarding default permission
set on the nvmem binary sysfs file resulted in this small fixup patchset.

By default nvmem core sets the readonly permission to everyone (S_IRUGO), this
is not desirable by many providers as they would not want everyone to view things
like passwords stored in the nvmem.

This patchset fixes this by making the default as root-only and then the
providers could supply with additional permissions if required. One of
the patch in this set also sets correct size for the binary file too,
so that the user would not even attempt to read past the size.

I have tested this on IFC6410 with qfprom.

Thanks,
srini

Changes since RFC (https://lkml.org/lkml/2015/8/11/319)
- Renamed perm to mode flag as suggested by Stefan Wahren

Srinivas Kandagatla (3):
  nvmem: core: make default user binary file root-access only
  nvmem: core: set the size for the nvmem binary file.
  nvmem: core: add sysfs file mode flag in nvmem_config

 drivers/nvmem/core.c           | 54 ++++++++++--------------------------------
 include/linux/nvmem-provider.h |  1 +
 2 files changed, 14 insertions(+), 41 deletions(-)

-- 
1.9.1
