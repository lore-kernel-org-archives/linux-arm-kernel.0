From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 15 Jul 2014 09:12:51 -0700
Subject: [PATCH v4 1/7] kernel: Add support for restart notifier call chain
In-Reply-To: <53C3F033.9070408@roeck-us.net>
References: <1405265431-4561-1-git-send-email-linux@roeck-us.net>
 <1405265431-4561-2-git-send-email-linux@roeck-us.net>
 <20140714145311.GC1112@arm.com> <53C3F033.9070408@roeck-us.net>
Message-ID: <20140715161251.GA14534@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 07:58:59AM -0700, Guenter Roeck wrote:
> On 07/14/2014 07:53 AM, Catalin Marinas wrote:
[ ... ]
> >
> >I'm not fully convinced implying a 'notifier' is the right approach
> >here. By analogy with the reboot notifier, this is something drivers
> >would want to know about and do some work before the actual system
> >restart (e.g. disable watchdogs as in the reboot notifier case). The
> >restart notifier here is meant to perform the actual system restart.
> >Arguably, the actual restart should be handled by priority 0 with some
> >preparation before but we have reboot notifier already, so I don't think
> >it's worth another notifier.
> >
> >While re-using the notifier mechanism behind the scene is fine, I think
> >we should at least rename the functions to something like
> >(un)register_restart_handler().
> >
> 
> Fine with me. Any other comments / suggestions on the name of the function ?
> 
Any further feedback on the function names ? If not I'll resubmit the series
tonight or tomorrow morning with the functions renamed as suggested above.

Guenter
