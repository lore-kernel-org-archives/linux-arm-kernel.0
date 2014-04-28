From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Apr 2014 11:28:06 +0100
Subject: [PATCH RFC 6/8] component: remove old add_components method
In-Reply-To: <20140428070727.GC19455@ulmo>
References: <20140426230025.GZ26756@n2100.arm.linux.org.uk>
 <E1WeBbp-0002Gs-Ju@rmk-PC.arm.linux.org.uk> <20140428070727.GC19455@ulmo>
Message-ID: <20140428102806.GH26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 09:07:28AM +0200, Thierry Reding wrote:
> I'm wondering if there may be an advantage to keeping both interfaces.
> Even if currently what all implementations do is essentially creating
> the match table at probe time there may be use-cases where that doesn't
> work so well.

Keeping both interfaces makes this whole change is pointless, because
then there's no way to avoid having to rebuild the tracking of which
components belong to which master - and we might as well stick with
what we have.

Moreover, one of the other points Laurent raised is that we need to
be able to do partial binds for some subsystems, and for that to work
we need more information held within the component helpers and the
teardown/rebuild of the master/component relationships to be eliminated.

The last point is that the repeated teardown/rebuild is already being
used as a justification to go off and write a completely different
infrastructure instead... it seems some people deem this to be far
too wasteful of our billion cycles per second CPUs.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
