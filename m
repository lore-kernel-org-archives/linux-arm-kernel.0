From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Feb 2013 08:58:20 +0000
Subject: [PATCH 0/4] Convert highbank to use PSCI calls
In-Reply-To: <1361936528-25998-1-git-send-email-robherring2@gmail.com>
References: <1361936528-25998-1-git-send-email-robherring2@gmail.com>
Message-ID: <201302270858.20864.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 February 2013, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This series converts highbank to use PSCI calls for secondary core boot,
> hotplug, cpuidle, suspend/resume, reset, and poweroff. Doing this removes
> about 200 lines of platform code (1/3 of it) and abstracts out the A9 and
> A15 differences (some of which are not yet in place).

Hi Rob,

This looks pretty cool. Can you or Will comment on what is still left
for the SMP ops that is actually required as platform specific code?

Specifically, I'm wondering if we could have a set of default smp_ops
based on this that we could use with the default machine descriptor [1]
and any platform that has SMP enabled but a NULL smp_ops pointer.

	Arnd

[1] https://patchwork.kernel.org/patch/2074871/
