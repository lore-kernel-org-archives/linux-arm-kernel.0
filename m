From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 19 Nov 2014 11:16:11 +0100
Subject: [GIT PULL] cpuidle: A few improvements for ARM cpuidle via DT
Message-ID: <546C6DEB.8060204@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Rafael,

this pull request, based on 3.18-rc5, contains a set of changes from 
Lorenzo Pieralisi.

  * Added a 'status' definition flag in the DT to specify the 
unsupported firmware idle states and ignore those states in the parsing 
code when initializing the cpuidle driver

  * Added an idle state description in the DT. As the idle states are 
not standardized on ARM, the description gives information about the 
idle state

  * Removed duplicate error message in the arm64 cpuidle drivers

Thanks !

   -- Daniel


The following changes since commit fc14f9c1272f62c3e8d01300f52467c0d9af50f9:

   Linux 3.18-rc5 (2014-11-16 16:36:20 -0800)

are available in the git repository at:

   http://git.linaro.org/git-ro/people/daniel.lezcano/linux.git cpuidle/3.19

for you to fetch changes up to 18f95a3640dbf421ab9532e517070a0c1cd4d582:

   drivers: cpuidle: Remove cpuidle-arm64 duplicate error messages 
(2014-11-19 10:16:28 +0100)

----------------------------------------------------------------
Lorenzo Pieralisi (3):
       drivers: cpuidle: Add status property to ARM idle states
       drivers: cpuidle: Add idle-state-name description to ARM idle states
       drivers: cpuidle: Remove cpuidle-arm64 duplicate error messages

  Documentation/devicetree/bindings/arm/idle-states.txt | 20 
++++++++++++++++++++
  drivers/cpuidle/cpuidle-arm64.c                       | 13 ++-----------
  drivers/cpuidle/dt_idle_states.c                      | 10 +++++++++-
  3 files changed, 31 insertions(+), 12 deletions(-)

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
