From: psidhu@gateworks.com (Pushpal Sidhu)
Date: Tue, 8 Dec 2015 16:09:12 -0800
Subject: Bad FEC tx TCP ethernet performance with certain defconfig
Message-ID: <CAD1M063HAxb+5p2MzK_2=WPK_8jJoEMEsxS8L7S1UxStr6XnZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I've found a state in which the TCP tx performance is severely
degraded when using a specific defconfig and I can't really figure out
the differences between the imx_v6_v7_defconfig vs. this one in both
the 4.3 kernel and 4.4-rc4. Please see [1] and [2] for links to the
".config.bad" and ".config.good" for a comparison for the 4.4-rc4
kernel.

With the bad config, I achieve roughly 120mbps, but it can vary
between 70~200mbps, but only with TCP tx traffic. I get normal
performance when transmitting UDP, or receiving TCP/UDP. I've verified
that this has nothing to do with netfilter/iptables by
enabling/disabling it.

I also found that when I backported the 4.3. fec_main driver to a
downstream vendor 3.14 vendor kernel, the same thing would occur
unless I set CONFIG_PROVE_LOCKING=y, in which case the performance is
normal. However, this behavior does not translate to the 4.4-rc4
kernel.

Finally, on the same system, I happen to have a NIC that's not the FEC
and I can't seem to show the problem on it, so it appears to be FEC
specific.

Can anyone reproduce my findings? I'm wondering if this is a known
problem, but I couldn't figure out the right thing to search on the
web or something.

[1] http://pastebin.com/PsjfhBqv
[2] http://pastebin.com/FE1qET5S

- Pushpal
