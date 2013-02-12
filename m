From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 12 Feb 2013 18:08:58 +0100
Subject: ARM big-endian on current kernels for linux-3.8
In-Reply-To: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130212180858.289c3efa@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

On Fri,  8 Feb 2013 23:17:30 +0000, Ben Dooks wrote:
> I have been working on getting big-endian kernels working, mainly from
> little-endian boot envrionments. The following patch series is what I
> have been working on, mainly on the highbank and axp systems.

Nice!

> Feedback and testing is welcome.

I've tested your patch set on Armada XP. The kernel boots fine, but it
fails to bring up the secondary CPUs:

Booting CPU 1
CPU1: failed to come online
Booting CPU 2
CPU2: failed to come online
Booting CPU 3
CPU3: failed to come online
Brought up 1 CPUs
SMP: Total of 1 processors activated (1332.01 BogoMIPS).

The other problem is that I've not been able to build a working armeb
userspace (I tried only very quickly with a Crosstool-NG toolchain I
built for armeb). Do you have a known working armeb toolchain around?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
