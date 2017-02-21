From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 21 Feb 2017 10:42:45 +0000
Subject: [PATCH/RFC 3/6] drivers: firmware: psci: Implement shallow
 suspend mode
In-Reply-To: <1487622809-25127-4-git-send-email-geert+renesas@glider.be>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-4-git-send-email-geert+renesas@glider.be>
Message-ID: <08c5dcf3-9d7c-33ff-f801-8f94f630f49b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On 20/02/17 20:33, Geert Uytterhoeven wrote:
> Enable support for "shallow" suspend mode, also known as "Standby" or
> "Power-On Suspend".
> 
> As secondary CPU cores are taken offline, "shallow" suspend mode saves
> slightly more power than "s2idle", but less than "deep" suspend mode.
> However, unlike "deep" suspend mode, "shallow" suspend mode can be used
> regardless of the presence of support for PSCI_SYSTEM_SUSPEND, which is
> an optional API in PSCI v1.0.
> 
> List the available system suspend modes:
> 
>     $ cat /sys/power/mem_sleep
>     s2idle shallow [deep]
> 
> Suspend to "shallow" mode:
> 
>     $ echo shallow > /sys/power/mem_sleep
>     $ echo mem > /sys/power/state
> 

I don't have the links to such previous attempts handy, but we have
more elegant alternative options(suspend-to-idle) and any such attempts
to hack around the PSCI will be NACKed.

-- 
Regards,
Sudeep
