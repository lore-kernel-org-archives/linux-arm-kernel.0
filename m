From: mikpe@it.uu.se (Mikael Pettersson)
Date: Tue, 28 Sep 2010 11:15:25 +0200
Subject: Robust futex on SMP
In-Reply-To: <1285625627.20158.98.camel@c-dwalke-linux.qualcomm.com>
References: <1285625627.20158.98.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <19617.45613.356715.178709@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Walker writes:
 > 
 > Is anyone working on implementing the robustness feature on SMP?
 > 
 > I found your commit e589ed23dd27b890900eb7514f0a9e297d1e02b5 which
 > implements UP, so I thought you might be familiar with it (or someone
 > else on the list).

I think I've seen a couple of proposed patches flying by on the
linux-arm-kernel list, but I think they've all failed to handle
corner cases (like what if the user's futex is on a page that
has been swapped out or been made read-only?)

I'd implement it myself if I had decent SMP HW, but alas I don't.

/Mikael
