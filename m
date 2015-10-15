From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Oct 2015 11:54:38 +0100
Subject: [PATCH v3 13/24] arm64: Populate cpuinfo after notify_cpu_starting
In-Reply-To: <1444756952-31145-14-git-send-email-suzuki.poulose@arm.com>
References: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
 <1444756952-31145-14-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151015105438.GL4239@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 06:22:21PM +0100, Suzuki K. Poulose wrote:
> This patch delays populating the cpuinfo for a new (hotplugged)
> CPU until the notifiers have executed. This will enable us to verify
> if the new (hotplugged) CPU has all the capabilities which the system
> already has. If it doesn't, we could prevent it from turning online and
> also modifying the system wide feature register status.

Just a question here: do we expect the notifiers to enable certain
features that we check later? AFAICT, the checking is done on the
feature registers which don't change after notifiers, so we could as
well block the booting before any notifier is run.

-- 
Catalin
