From: p.pisati@gmail.com (Paolo Pisati)
Date: Tue, 16 Apr 2013 18:55:16 +0200
Subject: 3.8+, PL310_ERRATA_769419 and highbank: borked reboot
Message-ID: <20130416165516.GA3097@luxor.wired.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Scenario:

3.9-rc7 kernel, multiplatform support with highbank and imx6 selected, highbank
node -> reboot doesn't work (actually it works 1 out of 10 times)

And playing around with the config i was able to track it down to
PL310_ERRATA_769419.

-a config and kernel that reproduce the issue:

http://people.canonical.com/~ppisati/highbank_769419_reboot/config.brk

http://people.canonical.com/~ppisati/highbank_769419_reboot/zImage.brk

-a config and kernel that don't reproduce it: 

http://people.canonical.com/~ppisati/highbank_769419_reboot/0003-highbank-dbg-comment-out-PL310_ERRATA_769419.patch

http://people.canonical.com/~ppisati/highbank_769419_reboot/config.ok

http://people.canonical.com/~ppisati/highbank_769419_reboot/zImage.ok

If you are building pl330 support too, you need a patch like this one:

http://people.canonical.com/~ppisati/highbank_769419_reboot/0001-dma-of-dma-check-OF-pointer-property-before-derefere.patch

to avoid a NULL ptr oops during boot.

Same issue happens on 3.8, and due to my test environment (conserver
on top of ipmi for 'serial over lan') i was unable to sysrq and give you a
stacktrace, sorry.
-- 
bye,
p.
