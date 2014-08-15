From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 14 Aug 2014 21:45:09 -0700
Subject: VFP available on a single CPU in a dual-CPU complex
Message-ID: <CAGVrzcaX4n2rJko_Kny81jkzQbV6z5TmcA2coGrj6BU-ahiOTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Broadcom's BCM63138 SoC, the second Cortex A9 CPU does not have
VFP, which is a problem as one might imagine because we currently
assume it is available for all CPUs within the complex.

I started to patch vfp_support_entry to test for CPU1 and branch to a
different location, but that raises a bunch of question, in particular
what to do if NEON/VFP came from the kernel, how can we migrate that
execution to CPU0?

If the answer is don't use VFP, I guess that's fine, and I can have a
runtime check in vfp_init() that checks for BCM63138 and set
vfp_vector to vfp_null_entry even though we are running on a multi-v7
kernel with VFP enabled.

Thanks!
-- 
Florian
