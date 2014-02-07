From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 7 Feb 2014 22:32:31 +0100
Subject: [PATCH] ARM: sun7i: dt: Fix interrupt trigger types
In-Reply-To: <1391269576-13274-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391269576-13274-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140207213231.GR3192@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 01, 2014 at 04:46:16PM +0100, Maxime Ripard wrote:
> The Allwinner A20 uses the ARM GIC as its internal interrupts controller. The
> GIC can work on several interrupt triggers, and the A20 was actually setting it
> up to use a rising edge as a trigger, while it was actually a level high
> trigger, leading to some interrupts that would be completely ignored if the
> edge was missed.
> 
> Fix this for the remaining DT nodes that slipped through.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: stable at vger.kernel.org

Merged in sunxi/fixes-for-3.14.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140207/9f4f7b8f/attachment-0001.sig>
