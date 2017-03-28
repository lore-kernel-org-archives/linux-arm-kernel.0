From: afd@ti.com (Andrew F. Davis)
Date: Tue, 28 Mar 2017 12:53:37 -0500
Subject: [PATCHv3] ARM: omap2+: Revert omap-smp.c changes resetting CPU1
 during boot
In-Reply-To: <20170328113341.GK23750@n2100.armlinux.org.uk>
References: <20170314180555.23597-1-tony@atomide.com>
 <aa5d7ee3-2e54-2c6c-df5d-b5efff4b365e@ti.com>
 <20170328113341.GK23750@n2100.armlinux.org.uk>
Message-ID: <f69d290f-67d6-dc9e-c2d2-55df6304e1d7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2017 06:33 AM, Russell King - ARM Linux wrote:
> On Mon, Mar 27, 2017 at 11:33:30AM -0500, Andrew F. Davis wrote:
>> I still don't like this style of workaround, if kexec cannot regain
>> control of core1 without a hard core reset than kexec should BUG() and
>> force the user to reboot to a sane state.
> 
> No, because kexec might already be in progress, and that would create
> an infinite loop of kexec -> bug -> kexec -> bug etc.
> 

Ah, yes, I was assuming BUG would halt and force a real reboot.
