From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 4 Jul 2014 21:42:54 +0530
Subject: [PATCH 2/8] cpufreq: add driver for Armada XP
In-Reply-To: <20140704141541.GE7773@lunn.ch>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404467103-29644-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAKohponuvPd1kWDdB66kxd8TxxYqQ219jCq2D2RGhMHAuZTSWA@mail.gmail.com>
 <20140704131247.2c8ecde2@free-electrons.com>
 <1404481934.4634.2.camel@weser.hi.pengutronix.de>
 <20140704141541.GE7773@lunn.ch>
Message-ID: <CAKohpon-ncOGR7KCJeUJEru7bZfoNbKTqUpkZUkMxPwH2WWFJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 July 2014 19:45, Andrew Lunn <andrew@lunn.ch> wrote:
> We are talking about legacy devices here, which have been in the field
> for years. There is very little chance of a boot loader
> upgrade. Appended DT is the norm for these devices, and modifying the
> DT would have to happen in kernel.

FWIW, I should mention that we don't need to fix DT's at all in your case.
Just add OPPs at runtime using dev_pm_opp_add() API from within
kernel, maybe from your arch/arm/mach-* folder and cpufreq-cpu0
would be able to parse them.

--
viresh
