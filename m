From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 17 Jul 2014 00:02:49 +0200
Subject: [PATCH] cpufreq: Don't destroy/realloc policy/sysfs on
 hotplug/suspend
In-Reply-To: <1404959850-11617-1-git-send-email-skannan@codeaurora.org>
References: <1404959850-11617-1-git-send-email-skannan@codeaurora.org>
Message-ID: <16164926.ZsJxe6UV3e@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 09, 2014 07:37:30 PM Saravana Kannan wrote:
> Preliminary patch. Not tested. Just sending out to give an idea of what I'm
> looking to do. Expect a lot more simplification when it's done.
> 
> Benefits:
> * A lot more simpler code.
> * Less stability issues.
> * Suspend/resume time would improve.
> * Hotplug time would improve.
> * Sysfs file permissions would be maintained.
> * More policy settings would be maintained across suspend/resume.
> * cpufreq stats would be maintained across hotplug for all CPUs.

One problem.  The real hotplug (when the CPU actually goes away) depends on
offline removing all that stuff for it.  How are you going to address that?

Rafael
