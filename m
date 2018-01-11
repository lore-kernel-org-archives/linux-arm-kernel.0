From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Thu, 11 Jan 2018 13:44:56 +0100
Subject: [GIT PULL] tee dynamic shm fixes for v4.16
Message-ID: <20180111124456.2fziqy4sdxq5wdlz@jax>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello arm-soc maintainers,

Please pull these fixes for the previous tee-drv-dynamic-shm-for-v4.16
pull request that is currently kept in the drivers/tee-2 branch in the
arm-soc git.

This pull request addresses the question about registering memory that
isn't regular memory. I posted those patches some time ago with no feedback
so far.

There's also three small fixes to the dynamic shm patches that I've
picked up from the mailing lists.

Thanks,
Jens


The following changes since commit ef8e08d24ca84846ce639b835ebd2f15a943f42b:

  tee: shm: inline tee_shm_get_id() (2017-12-15 13:36:21 +0100)

are available in the git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tee-drv-dynamic-shm+fixes-for-v4.16

for you to fetch changes up to 2490cdf6435b1d3cac0dbf710cd752487c67c296:

  tee: shm: Potential NULL dereference calling tee_shm_register() (2018-01-09 14:34:00 +0100)

----------------------------------------------------------------
This pull request updates the previous tee-drv-dynamic-shm-for-v4.16 pull
request with five new patches fixing review comments and errors.

Apart from three small fixes there's two larger patches that in the end
checks that memory to be registered really is normal cached memory.

----------------------------------------------------------------
Colin Ian King (2):
      tee: shm: make function __tee_shm_alloc static
      tee: shm: don't put_page on null shm->pages

Dan Carpenter (1):
      tee: shm: Potential NULL dereference calling tee_shm_register()

Jens Wiklander (2):
      tee: add start argument to shm_register callback
      tee: optee: check type of registered shared memory

 drivers/tee/optee/call.c          | 50 +++++++++++++++++++++++++++++++++++----
 drivers/tee/optee/optee_private.h |  6 +++--
 drivers/tee/tee_shm.c             | 18 +++++++-------
 include/linux/tee_drv.h           |  3 ++-
 4 files changed, 62 insertions(+), 15 deletions(-)
