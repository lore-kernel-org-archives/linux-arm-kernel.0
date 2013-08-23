From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 22 Aug 2013 21:07:14 -0400
Subject: [PATCH 0/7] Orion watchdog DT changes to support more SoCs
In-Reply-To: <1377182518-12554-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377182518-12554-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130823010714.GC13964@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 11:41:51AM -0300, Ezequiel Garcia wrote:
> As part of my work to add watchdog support to Armada 370/XP SoCs,
> here's some early patches to get early feedback.
> 
> This patchset allows to build the orion_wdt driver in any Orion
> platforms.
> 
> To achieve this it's necessary to remove the need for a mach-specific,
> which in turn is done by splitting the single memory resource into
> three memory resources: timer control, watchdog counter and RSTOUT registers;
> and handling each of this resources as independent memory resources (as they
> really are).
> 
> The only drawback with this approach is the breakage of devicetree backwards
> compatibility such change produces. This is an important issue, and the main
> reason I'm submitting this patchset: Is it possible to introduce such
> DT-binding change?
> 
> It's worth noting that a similar was proposed in July-15th [1], which received
> some acceptance [2].
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/183628.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/183857.html

Well, my point was that *if* it needed to be broken, now was the best
time to do it.

Please see my other reply for current thoughts.

thx,

Jason.
