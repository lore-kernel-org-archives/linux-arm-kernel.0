From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Nov 2018 15:59:39 +0000
Subject: Please check linux-next boot results from tonight for next seven days
Message-ID: <20181108155938.GY30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For anyone running builds and boot tests of tonight's linux-next,
I've pushed out the final bits of the Spectre big.Little fixes
for sfr to pick up tonight.

These were omitted from the last merge window because towards the
end of the -rc cycle, it was belatedly reported that it was causing
a regression on some platforms, so they had to be dropped out of
that merge window.  I believe that this was discovered on some
non-kernelci based test system.

However, they really need to go in before the end of the year, so
I'm proposing to send them before 4.20-rc3.

This means I need help to test them and make sure that they do not
cause any other unknown regressions.  Please note that merely looking
at kernelci and checking whether it says the boot test passed is
_insufficient_ - the boot logs must be inspected becaues a "green"
pass result does _not_ mean that there isn't some kind of warning.
The same problem may also be present in other automated boot testing
systems elsewhere.

Please check your boot logs for tonight's linux-next over the next
seven days and report ASAP if the Spectre fixes are causing a
regression for your platform.  If I don't hear anything, I will be
sending them for -rc3.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
