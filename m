From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 21 Nov 2014 16:24:25 +0000
Subject: [PATCH v2 0/2] arm+arm64: perf: Prevent wraparound during overflow
In-Reply-To: <1416412346-8759-1-git-send-email-daniel.thompson@linaro.org>
References: <1416412346-8759-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1416587067-3220-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes problems on arm and arm64 when the PMU counters wrap
around and become larger than the value originally programmed into them.

The problem was observed and fixed on arm but the perf code is,
rather to my surprise, sufficiently similar on arm64 that the fix still
makes sense there too.

v2:

* Remove the redundant cast to s64 (Will Deacon).


Daniel Thompson (2):
  arm: perf: Prevent wraparound during overflow
  arm64: perf: Prevent wraparound during overflow

 arch/arm/kernel/perf_event.c   | 10 ++++++++--
 arch/arm64/kernel/perf_event.c | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

--
1.9.3
