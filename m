From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 24 Feb 2016 17:10:20 -0800
Subject: [PATCH] drivers: perf: arm: implement CPU_PM notifier
In-Reply-To: <1456251759-24768-1-git-send-email-lorenzo.pieralisi@arm.com>
 (Lorenzo Pieralisi's message of "Tue, 23 Feb 2016 18:22:39 +0000")
References: <1456251759-24768-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <7hsi0hr3wj.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> When a CPU is suspended (either through suspend-to-RAM or CPUidle),
> its PMU registers content can be lost, which means that counters
> registers values that were initialized on power down entry have to be
> reprogrammed on power-up to make sure the counters set-up is preserved

This assumes that the PMUs are always sharing a power rail with a
specific CPU, not the cluster.  Is that a reliable assumption?

Kevin
