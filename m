From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 24 Mar 2014 17:28:35 -0400 (EDT)
Subject: [PATCH RFC] ARM: mm: Fix for highmem on machines with more than
 14 cores
In-Reply-To: <52661057074abf5bfe6174cb561bec5eea8892fb.1395692531.git.anders.berg@lsi.com>
References: <cover.1395692531.git.anders.berg@lsi.com>
 <52661057074abf5bfe6174cb561bec5eea8892fb.1395692531.git.anders.berg@lsi.com>
Message-ID: <alpine.LFD.2.11.1403241727290.1291@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Mar 2014, Anders Berg wrote:

> The fixmap area was hard coded to 224 pages which was only enough for 14 CPU:s.
> Now the area adapts to the configured number of CPU:s (NR_CPUS). We still have
> a hard limit of 30 CPU:s since we only have a single pte-chunk (512 pte:s).
> 
> Signed-off-by: Anders Berg <anders.berg@lsi.com>
> Signed-off-by: Fredrik Markstr?m <fredrik.markstrom@gmail.com>

This is under discussion already.  Please have a look at this thread:

http://news.gmane.org/group/gmane.linux.kernel/thread=1672068/


Nicolas
