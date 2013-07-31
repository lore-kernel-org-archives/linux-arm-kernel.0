From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 31 Jul 2013 13:57:37 -0600
Subject: Defining schemas for Device Tree
In-Reply-To: <CAKON4OzFdZhX0Kzu_6KiimD=KxDr6EM13zUH3GGE=hHaYx=m=Q@mail.gmail.com>
References: <51F6E30B.7060106@wwwdotorg.org>
 <CAKON4Oy6+7ZpAG5emAm_c62t=o_LXM7PcbK-z5YL_qx=r0AKqQ@mail.gmail.com>
 <1706112.Xn49tiCSKF@thinkpad>
 <CAKON4OwNrhmvnznyeD-igtZ5nsm7atUZoa0RJttN5kmwKubaDg@mail.gmail.com>
 <20130730102511.GM9858@sirena.org.uk>
 <CAKON4OxSr13VPJkwkvuF91BwFXfQ6fkAuVeEsiA=JK3cuzmavQ@mail.gmail.com>
 <51F7F596.6020503@wwwdotorg.org>
 <CAKON4OykPqYA8+ZGxjiX00Ut+iM9hqiXr5D9KEZF3PVxoqiM1g@mail.gmail.com>
 <20130730205716.GZ9858@sirena.org.uk>
 <CAKON4Ox7-6Jf0ce64Wqr5E49KS+9E135mqc_iG-PWQ7r8bzWHA@mail.gmail.com>
 <20130730230331.GC9858@sirena.org.uk>
 <CAKON4OzFdZhX0Kzu_6KiimD=KxDr6EM13zUH3GGE=hHaYx=m=Q@mail.gmail.com>
Message-ID: <51F96C31.8030305@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2013 05:23 PM, jonsmirl at gmail.com wrote:
...
> Uboot could be an issue but I don't think they are actually doing
> anything with FDTs yet, they are just talking about doing it.

A couple U-Boot platforms (Tegra, Exynos) actually use DT to
parameterize U-Boot itself, just like the kernel uses it, although:

* often the bindings used there are not the "real" bindings defined in
the kernel:-(

* They use a DTB embedded into the U-Boot binary, which is a different
DTB to that passed to the kernel, which at least in the Tegra case is
always loaded from disk e.g. from /boot, just like zImage is.

U-Boot certainly passes DTs to the kernel, and performs some limited
modification on it such as setting the kernel cmdline, memory size, etc.
