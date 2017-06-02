From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Jun 2017 23:24:50 +0100
Subject: Vexpress TC2 no longer booting on v4.12-rc1
In-Reply-To: <CANLsYkz3dcVArStN2GJguYfJbWc_4dC4vvTE1KVtYpVWipEYjg@mail.gmail.com>
References: <CANLsYkz3dcVArStN2GJguYfJbWc_4dC4vvTE1KVtYpVWipEYjg@mail.gmail.com>
Message-ID: <20170602222449.GB4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 04:16:59PM -0600, Mathieu Poirier wrote:
> Good afternoon Russell and friends,
> 
> I noticed that my vexpress-TC2 platform stopped booting when moving to
> kernel v4.12-rc1 (same with -rc2 and 3).  The last time things worked
> properly was on v4.11.  I did a bisect between v4.11 and v4.12-rc1 and
> ended up on [1], hence this email.
> 
> Since CONFIG_ARM_VIRT_EXT is selected by  default I removed the
> "#ifdef CONFIG_ARM_VIRT_EXT" section in the last hunk of the patch and
> the system sprung up to life again.

Hmm, this doesn't make much sense.  The code in last hunk of the patch
you refer to should only get run during system shutdown, not during
system boot, so I think something else is going on...

Please could you test again, this time rather than removing the #ifdef,
add two "mov r0, r0" there?  (So replacing the two instructions that
removing the ifdef would have exposed.)

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
