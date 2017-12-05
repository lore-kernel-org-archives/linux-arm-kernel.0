From: john.garry@huawei.com (John Garry)
Date: Wed, 6 Dec 2017 00:13:14 +0800
Subject: [RFC PATCH 0/5] perf events patches for improved ARM64 support
Message-ID: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for some perf events features,
targeted at ARM64, implemented in a generic fashion.

The two main features are as follows:
- support for arch/vendor/platform pmu events directory structure
- support for parsing architecture recommended pmu events

On the back of these, the Cavium ThunderX2 and HiSilicon hip08
JSONs are relocated/added.

TODO: 
	- Documentation needs to be updated for recommended
	events format in the JSON
	- tidy up patches a bit

John Garry (5):
  perf jevents: add support for pmu events vendor subdirectory
  perf jevents: add support for arch recommended events
  perf vendor events arm64: add armv8 recommended events JSON
  perf vendor events arm64: relocate thunderx2 JSON
  perf vendor events arm64: add HiSilicon hip08 JSON

 .../pmu-events/arch/arm64/armv8-recommended.json   | 452 +++++++++++++++++++++
 .../arch/arm64/cavium/thunderx2-imp-def.json       |  62 ---
 .../arch/arm64/cavium/thunderx2/core-imp-def.json  |  32 ++
 .../arch/arm64/hisilicon/hip08/core-imp-def.json   | 122 ++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   3 +-
 tools/perf/pmu-events/jevents.c                    | 272 ++++++++++++-
 6 files changed, 859 insertions(+), 84 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/armv8-recommended.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json

-- 
1.9.1
