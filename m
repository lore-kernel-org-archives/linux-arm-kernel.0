From: olof@lixom.net (Olof Johansson)
Date: Thu, 6 Aug 2015 10:10:52 +0200
Subject: [PATCH 1/2] ARM: ux500: add an SMP enablement type and move cpu
 nodes
In-Reply-To: <1438586801-30115-1-git-send-email-linus.walleij@linaro.org>
References: <1438586801-30115-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20150806081052.GB16520@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 09:26:41AM +0200, Linus Walleij wrote:
> The "cpus" node cannot be inside the "soc" node, while this
> works for the CoreSight blocks, the early boot code will look
> for "cpus" directly under the root node, so this is a hard
> convention. So move the CPU nodes.
> 
> Augment the "reg" property to match what is actually in the
> hardware: 0x300 and 0x301 respectively.
> 
> Then add an SMP enablement type to be used by the SMP init
> code, "ste,dbx500-smp".
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi ARM SoC people: please apply this as a fix for v4.2
> as it is prerequisite for 2/2 which is a more proper fix
> for the secondary CPU boot regression addressed by the
> fixed remappings patch.

Applied, thanks.


-Olof
