From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 19 Feb 2014 12:17:01 +0000
Subject: [PATCH 0/2] CCI PMU update
Message-ID: <1392812223-29274-1-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are a short couple of patches to update the CCI PMU perf backend
to better support IP updates.

The first patch simplifies version checking to assume that event
numbering doesn't change for > r1p0 (it changed between r0 and r1).
This change should help reduce code churn when IP version is bumped up
without any changes to event numbering.

The second patch exports the PMU version to userspace (via the PMU
name) to allow tooling to deal with event numbering differences.

I'd appreciate any feedback on the changes.

The patches are based on top of 3.14-rc3 and can hopefully make it for
3.15.

Thanks,
Punit

Punit Agrawal (2):
  drivers: cci: Extend support to CCI revisions > r1p2
  drivers: cci: Export CCI PMU revision

 drivers/bus/arm-cci.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

-- 
1.7.10.4
