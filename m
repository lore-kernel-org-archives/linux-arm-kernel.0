From: cjb@laptop.org (Chris Ball)
Date: Fri, 27 Aug 2010 20:03:06 +0100
Subject: [PATCH] mmc: move regulator handling to core
In-Reply-To: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
References: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
Message-ID: <20100827190306.GB20407@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Thu, Dec 03, 2009 at 01:46:30PM +0100, Daniel Mack wrote:
> At the moment, regulator operations are done from individual mmc host
> drivers. This is a problem because the regulators are not claimed
> exclusively but the mmc core enables and disables them according to the
> return value of regulator_is_enabled(). That can lead to a number of
> problems and warnings when regulators are shared among multiple
> consumers or if regulators are marked as 'always_on'.
> 
> Fix this by moving the some logic to the core, and put the regulator
> reference to the mmc_host struct and let it do its own supply state
> tracking so that the reference counting in the regulator won't get
> confused.

Looks like this patch got dropped because of the missing modifications
to arch/arm/mach-omap2/mmc-twl4030.c.  Are we still interested in the
patch otherwise, and can anyone help with that?

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
