From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 08 Oct 2012 17:02:13 -0600
Subject: Single zImage and A15/LPAE
Message-ID: <50735B75.8070109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm curious what the single-zImage story is for Cortex A15 CPUs with
LPAE extensions; IIRC, LPAE entails a different page table format and so
isn't going to co-exist in the same zImage as non-LPAE (although doesn't
x86 support that now; I though separate LPAE/non-LPAE kernels went away
there?)

Presumably though, the intent is to be able to disable LPAE in Kconfig,
and create a single zImage with both A9 and A15 support, or to enable
LPAE and only support A15 with LPAE, and which you'd choose to do simply
depends on whether you care about LPAE based on how much RAM the boards
you want to support have (or perhaps also what physical address your
peripherals are at)?
