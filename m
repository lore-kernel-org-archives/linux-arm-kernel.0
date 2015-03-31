From: byan@nvidia.com (Bo Yan)
Date: Mon, 30 Mar 2015 19:18:42 -0700
Subject: a question about run-time patching for heterogeneous cores.
Message-ID: <551A0402.90903@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The current code for arm64 run-time patching works fine if all CPUs are 
the same, but doesn't seem to handle the case when CPUs are of different 
type. For example, when you have a mix of A53 and A57 cores, currently 
the errata WARs can be applied irrespective of A53 or A57 since the code 
in need of patching are shared.

It doesn't look like the current WARs will cause functional problems 
across different CPU cores. On the other hand, is there a perf issue due 
to the same errata WARs being applied to different cores?

Thanks

Bo
