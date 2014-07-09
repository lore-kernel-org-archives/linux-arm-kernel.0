From: riel@redhat.com (Rik van Riel)
Date: Tue, 08 Jul 2014 23:11:07 -0400
Subject: [PATCH v3 04/12] sched: Allow all archs to set the power_orig
In-Reply-To: <1404144343-18720-5-git-send-email-vincent.guittot@linaro.org>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-5-git-send-email-vincent.guittot@linaro.org>
Message-ID: <53BCB2CB.6050108@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/30/2014 12:05 PM, Vincent Guittot wrote:
> power_orig is only changed for system with a SMT sched_domain level
> in order to reflect the lower capacity of CPUs. Heterogenous system
> also have to reflect an original capacity that is different from
> the default value.
> 
> Create a more generic function arch_scale_cpu_power that can be
> also used by non SMT platform to set power_orig.
> 
> The weak behavior of arch_scale_cpu_power is the previous SMT one
> in order to keep backward compatibility in the use of power_orig.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Rik van Riel <riel@redhat.com>


- -- 
All rights reversed
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTvLLLAAoJEM553pKExN6D/bAH/3bwSpTQUfp37uMHo42JEwHV
+GiMv+Q8dnVi6/b14UEYaRa0T7ELBOfbAvn7MjUDJVTGDOhCptXuE1Xedz+fKh01
FaVA5sJmCtyhH6v1n8q0PM5D/HcL6WRCBuf91Mx+3aSJhHcULRgN22wajYfxFOEy
IBPQjwwxjbWOBsN4l8UevMnzOVLV3S9I/+NHHTRmIcPpc/gdREO31ey4LX4E1y4U
sni6exOmhjYGiWgYwt9x5+Fmio0EwqVbSsdygWrSJykjW5dcUfM5A6ACp44u7keK
L2tb/eiZthGGd+ct4J08nF51BLrXUAIBcyXM3wxWNFCIQkwhbnVxYapkfmSfe48=
=ucGA
-----END PGP SIGNATURE-----
