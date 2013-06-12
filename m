From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Jun 2013 23:52:32 +0200
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130612213620.GC23012@localhost>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130612212641.GB8625@obsidianresearch.com>
 <20130612213620.GC23012@localhost>
Message-ID: <201306122352.32749.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 June 2013, Ezequiel Garcia wrote:
> Right. And just to confirm: this kernel side dynamic implementation
> will be completely independent of the MBus DT layout proposal.
> So I think it's best to agree on this binding first.
> 
> I'll post a v2 with the progress I've made using the preprocessor.

Right. My thought was just that with the of_bus handler it might end up
being /easier/ to do the dynamic mapping than it is to preconfigure
it in the DT.

Whether that results in an optimum mapping or not depends on the actual
sizes for the child nodes. Since everything is a power-of-two size,
a first-fit algorithm actually isn't bad at all.

	Arnd
