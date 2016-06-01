From: horms@verge.net.au (Simon Horman)
Date: Wed, 1 Jun 2016 09:57:51 +0900
Subject: [PATCH 07/13] ARM: dts: r8a7792: initial SoC device tree
In-Reply-To: <2539026.OyU5nvpxa6@wasted.cogentembedded.com>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <2539026.OyU5nvpxa6@wasted.cogentembedded.com>
Message-ID: <20160601005751.GG20527@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 01:24:21AM +0300, Sergei Shtylyov wrote:
> The initial R8A7792 SoC device tree including 2 CPU cores, GIC, timer, SYSC,
> and the required  clock descriptions.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

This is rather large for an initial DTSI. Did you give any consideration
to splitting it up: e.g. only providing what is needed to get to a serial
console?

With regards to SMP. Have you checked to make sure CPU hotplug works
on all CPUs? And that the system behaves sanely on suspend/resume.
If it is not possible to verify this at this stage then I would recommend
only enabling one CPU at this stage.
