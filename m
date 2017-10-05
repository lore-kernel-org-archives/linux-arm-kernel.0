From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Thu, 5 Oct 2017 22:32:01 +0200
Subject: Follow-up: How to deal with weird SCPI firmware and invalid DVFS
 frequencies
Message-ID: <a96ffcce-7399-97c6-10be-88869c77ccef@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Few months ago we discussed how to deal with the Amlogic Meson SCPI
DVFS cpu frequencies. To recap:
SCPI DVFS provides some high frequencies which are usable only if
just one CPU core is used. Else the system will just crash
(even w/o being thermally loaded).

See also:
https://patchwork.kernel.org/patch/9557349/
https://patchwork.kernel.org/patch/9555761/

One idea was to introduce a DT param for the CPU nodes to configure
a max frequency, and all DVFS freq's above this threashold would be
ignored. However we didn't come to an agreement.

Now, when dealing with SCPI again, another idea came to my mind:
Still it would be about introducing such a DT parameter, however
we would not completely ignore higher frequencies but just set
the "turbo" flag of the opp.
This way cpufreq would ignore these frequencies, however we still
had the option to manually enable these frequencies via sysfs and
use them on systems where just one CPU core is used.
(or more general: manually enable the boost frequencies if system
macthes certain criteria)

Does this sound better or would you still consider this to be too
hacky?

Rgds, Heiner
