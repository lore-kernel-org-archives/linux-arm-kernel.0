From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Nov 2011 20:21:38 +0000
Subject: [PATCH] ARM : fix /proc/interrupts per online cpu
In-Reply-To: <1322150719-28243-1-git-send-email-daniel.lezcano@linaro.org>
References: <1322150719-28243-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20111124202138.GQ9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 05:05:19PM +0100, Daniel Lezcano wrote:
> The loop should look at the online cpus instead of the present cpus
> in order to hide the offline cpus in procfs like it is done on the
> other architectures.

And what happens if you're reading /proc/interrupts while a CPU is
changing state?

Given that it's just user presentation, whether its online or present
makes little odds - and having it as present CPUs makes the output
100% stable with the effects of hotplug.
