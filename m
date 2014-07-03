From: rmk@arm.linux.org.uk (Russell King)
Date: Thu, 3 Jul 2014 15:10:40 +0100
Subject: [GIT PULL] component helper updates for 3.17
Message-ID: <20140703141040.GA725@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

Please incorporate the latest component updates, which can be found at:

  git://ftp.arm.linux.org.uk/~rmk/linux-arm.git component-for-driver

with SHA1 6955b58254c2bcee8a7b55ce06468a645dc98ec5.

These updates fix one bug in the component helper where the matched
components are not properly cleaned up when the master fails to bind.
I'll provide a version of this for stable trees if it's deemed that
we need to backport it.

The second patch causes the component helper to ignore duplicate
matches when adding components - this is something that was originally
needed for imx-drm, but since that has now been updated, we no longer
need to skip over a component which has already been matched.

The final patch starts the process of updating the component helper
API to achieve two goals: to allow the API to be more efficient when
deferred probing occurs, and to allow for future improvements to the
component helper without having a major impact on the users.

This represents groundwork for some other changes; once this has been
merged, I will then send two further pull requests (one for the staging
tree, and one for the DRM tree) to update the drivers to the new API.
This will result in these three commits being shared with those trees.

This will update the following files:

 drivers/base/component.c  | 190 +++++++++++++++++++++++++++++++++++++---------
 include/linux/component.h |   7 ++
 2 files changed, 162 insertions(+), 35 deletions(-)

through these changes:

Russell King (3):
      component: fix missed cleanup in case of devres failure
      component: ignore multiple additions of the same component
      component: add support for component match array

Many thanks.
