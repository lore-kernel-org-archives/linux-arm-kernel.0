From: segher@kernel.crashing.org (Segher Boessenkool)
Date: Wed, 21 Sep 2011 07:16:52 +0200
Subject: [PATCH 0/3] GIC OF bindings
In-Reply-To: <20110920.224910.1996429830782124690.davem@davemloft.net>
References: <1316550244-3655-1-git-send-email-robherring2@gmail.com>
	<20110920.224910.1996429830782124690.davem@davemloft.net>
Message-ID: <15B014F7-0085-455D-A641-AA7ADFB68545@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Just out of curiosity where does this "interrupt-parent" property
> come from?
>
> On platforms I am familiar with, the parent path is walked to the root
> and we stop at device nodes that have "interrupt-map" and
> "interrupt-map-mask" properties.

"interrupt-parent" is defined in the Open Firmware "interrupt mapping"
recommended practice, the same place as "interrupt-map" etc. are.

> The mechanism shown here seems overly simplistic and not able to  
> handle
> the cases handled by existing OF property schemes in use for several
> years on real systems.

"interrupt-parent" is only meant to be used for the simple cases.  It's
quite handy there.  It is also required in all "interrupt-controller"
nodes that aren't the root of the interrupt tree.


Segher
