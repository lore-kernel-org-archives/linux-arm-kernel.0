From: joseph@codesourcery.com (Joseph S. Myers)
Date: Tue, 12 Jun 2012 19:11:18 +0000 (UTC)
Subject: Detecting support for trapping floating-point exceptions on ARM
Message-ID: <Pine.LNX.4.64.1206121900150.1359@digraph.polyomino.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM VFPv3 and VFPv4 do not support trapping floating-point exceptions; 
VFPv2, VFPv3U and VFPv4U do.  The lack of support causes the glibc 
math/test-fenv test to fail on VFPv3 and VFPv4 systems.

The natural fix for that would be for fesetenv (FE_NOMASK_ENV) to fail on 
hardware not supporting trapping exceptions.  There is, however, no HWCAP 
bit to indicate whether trapping floating-point exceptions is supported.  
Could one be added to the kernel, or is there a good way fesetenv could 
detect this from userspace without a new HWCAP bit?

-- 
Joseph S. Myers
joseph at codesourcery.com
