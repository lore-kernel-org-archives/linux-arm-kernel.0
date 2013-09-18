From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 18 Sep 2013 18:11:12 +0200
Subject: [RFC PATCHv2 3/4] of: provide a binding for fixed link PHYs
In-Reply-To: <20130918042923.5D845C42CF7@trevor.secretlab.ca>
References: <1378480701-12908-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1378480701-12908-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130918042923.5D845C42CF7@trevor.secretlab.ca>
Message-ID: <20130918181112.56c10dde@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Grant Likely,

On Tue, 17 Sep 2013 23:29:23 -0500, Grant Likely wrote:

> I understand what you're trying to do here, but it causes a troublesome
> leakage of implementation detail into the binding, making the whole
> thing look very odd. This binding tries to make a fixed link look
> exactly like a real PHY even to the point of including a phandle to the
> phy. But having a phandle to a node which is *always* a direct child of
> the MAC node is redundant and a rather looney. Yes, doing it that way
> makes it easy for of_phy_find_device() to be transparent for fixed link,
> but that should *not* drive bindings, especially when that makes the
> binding really rather weird.
> 
> Second, this new binding doesn't provide anything over and above the
> existing fixed-link binding. It may not be pretty, but it is
> estabilshed.

Have you followed the past discussions about this patch set? Basically
the *only* feedback I received on RFCv1 is that the fixed-link property
sucks, and everybody (including the known Device Tree binding
maintainer Mark Rutland) suggested to not use the fixed-link mechanism.
See http://article.gmane.org/gmane.linux.network/276932, where Mark
said:

""
I'm not sure grouping these values together is the best way of handling
this. It's rather opaque, and inflexible for future extension.
""

So, please DT maintainers, tell me what you want. I honestly don't care
whether fixed-link or a separate node is chosen. However, I do care
about being dragged around between two solutions just because the
former DT maintainer and the new DT maintainers do not agree.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
