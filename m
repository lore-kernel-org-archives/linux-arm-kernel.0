From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Mar 2017 12:55:28 +0000
Subject: [PATCH] arm: install.sh: don't use /sbin/install if
 cross-compiling
In-Reply-To: <ca1a7552e8c3705dbcb64ff3b2e6ad5616a1073a.1489581503.git.mchehab@s-opensource.com>
References: <ca1a7552e8c3705dbcb64ff3b2e6ad5616a1073a.1489581503.git.mchehab@s-opensource.com>
Message-ID: <20170315125528.GS21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 09:43:21AM -0300, Mauro Carvalho Chehab wrote:
> It doesn't make sense to run the local machine's install
> script if the Kernel was built using a cross-compiler, as it
> will try to create symlinks at the rootfs on the local machine:

Please only do this for /sbin/installkernel.  The user's ~/bin/installkernel
may be designed to cope with this (I use this feature for my cross-built
kernels.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
