From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Dec 2014 19:50:40 +0100
Subject: [PATCH v2 1/3] power: reset: read priority from device tree
In-Reply-To: <20141201174100.GC22708@leverpostej>
References: <1417453389-1588-1-git-send-email-stefan@agner.ch>
 <e5c5a44c84b95c4e48ed01c4dcffd35a@agner.ch>
 <20141201174100.GC22708@leverpostej>
Message-ID: <3594295.ivTLMMcK6I@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 December 2014 17:41:00 Mark Rutland wrote:
> Otherwise, I would imagine that most systems have a single preferred
> mechanism with some possible fallback(s), for which a single
> preferred-poweroff property might suffice, and has better interaction
> w.r.t. priority (in that it should _always_ be tried first). Even that's
> difficult to reconcile with FW bindings though, especially EFI (which we
> sometimes must use in preference for variable storage and capsule
> updates).

The preferred-poweroff property sounds better to me, too. I can see
two ways of doing that though, and I'm not sure which one you mean.
Would you put that as a bool property into the device that does the reboot,
or would you put it as reference into the /chosen or /aliases node?

I think the latter would be better as it avoids any ambiguity, but
either way would work.

	Arnd
