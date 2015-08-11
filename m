From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 11 Aug 2015 12:02:11 +0100
Subject: [PATCH RFC 0/3] nvmem: make sysfs binary file permissions more
 flexible.
Message-ID: <1439290931-18232-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All, 

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

Srinivas Kandagatla (3):
  nvmem: make default user binary file root-access only
  nvmem: set the size for the nvmem binary file.
  nvmem: add permission flags in nvmem_config

 drivers/nvmem/core.c           | 55 +++++++++---------------------------------
 include/linux/nvmem-provider.h |  1 +
 2 files changed, 13 insertions(+), 43 deletions(-)

-- 
1.9.1
