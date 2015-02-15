From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 15 Feb 2015 23:12:51 +0000
Subject: [PATCH 05/14] ARM: call reset_controller_of_init from default
 time_init handler
In-Reply-To: <CAL_Jsq+Sk0C-1UHCKE18fEVwBbV=quV9mrJSKTO_UPXWcaYfCw@mail.gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1423763164-5606-6-git-send-email-mcoquelin.stm32@gmail.com>
 <CAL_Jsq+Sk0C-1UHCKE18fEVwBbV=quV9mrJSKTO_UPXWcaYfCw@mail.gmail.com>
Message-ID: <20150215231251.GL8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 15, 2015 at 04:17:31PM -0600, Rob Herring wrote:
> On Thu, Feb 12, 2015 at 11:45 AM, Maxime Coquelin
> <mcoquelin.stm32@gmail.com> wrote:
> > Some DT ARM platforms need the reset controllers to be initialized before
> > the timers.
> > This is the case of the stm32 and sunxi platforms.
> 
> I would say this is the exception, not the rule and therefore should
> be handled in a machine desc function. Or it could be part of your
> timer setup. Or is the bootloader's problem (like arch timer setup).
> 
> We just want to limit how much this mechanism gets used.

Can you clarify please - what is "this mechanism"?  Placing explicit
calls at this location, or the whole OF_DECLARE_* stuff?

Sebastian suggested using the OF_DECLARE_* stuff for the Dove PMU -
so maybe you have a comment on that too?

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
