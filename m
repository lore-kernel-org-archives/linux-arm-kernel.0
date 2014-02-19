From: Russ.Dill@ti.com (Russ Dill)
Date: Wed, 19 Feb 2014 11:10:31 -0800
Subject: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
In-Reply-To: <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
Message-ID: <530501A7.2030703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/19/2014 08:12 AM, Lorenzo Pieralisi wrote:

+ *  https://patchwork.kernel.org/patch/96442/


I think the idea here is to get the CPU into a state so that later
when we resume from the resume kernel, the actual CPU state matches
the state we have in kernel. The main thing flush_thread does is clear
out any and all FP state.

The may be part of the patchset that is OBE.



cpu_resume makes many assumptions about the state of the state of the
CPU, the primary being that the MMU is disabled, but also that all
caches and IRQs are disabled. soft_restart does all this for us.



ah, you are saying just return from __swsusp_arch_save_image and allow
cpu_suspend_abort to be called, placing the result of swsusp_save
somewhere else. This may work and would reduce the complexity of the
code slightly.



This is taken from the previous iteration of the patchset, I think the
comment is OBE.



But this is still required to select the right mapping for our copying.



I don't remember why I needed to prevent gcc from manipulating the
stack here.



This is another holdover from previous patch versions that may be OBE.



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMFAaYACgkQfNRrxBinbdsWTwCgowSU7VPqGcM4ks39FtAihsBe
vfYAn3gxZEu753xyESuye0y1z+wbWJRp
=JZ1s
-----END PGP SIGNATURE-----
