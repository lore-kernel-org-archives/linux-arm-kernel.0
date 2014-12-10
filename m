From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Dec 2014 17:39:18 +0000
Subject: [RFC 00/15] Resource tracking/allocation framework
In-Reply-To: <CA+tnuKYSDZ0mtzQ_g1QjovJwG01OgPjSXuozEBXQsEZv_2o-=w@mail.gmail.com>
References: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
 <20141210161620.GM11285@n2100.arm.linux.org.uk>
 <CA+tnuKYSDZ0mtzQ_g1QjovJwG01OgPjSXuozEBXQsEZv_2o-=w@mail.gmail.com>
Message-ID: <20141210173918.GN11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 06:23:49PM +0100, A H wrote:
> 10 gru 2014 17:16 "Russell King - ARM Linux" <linux@arm.linux.org.uk>
> napisa?(a):
> >
> > On Wed, Dec 10, 2014 at 04:48:18PM +0100, Andrzej Hajda wrote:
> > > 3. There are drivers which can work without specific resource, but if
> > >   the resource becomes available/unavailable it can do some additional
> stuff.
> > >   An example of such driver is DRM driver (more precisely
> drm_connector) -
> > >   it can start without attached drm_panel, but if the panel becomes
> available it
> > >   can react by generating HPD event and start using it.
> >
> > Bad example, and actually incorrect.  DRM connectors are referenced in
> > userspace by an IDR number, which can be re-used in the case of a
> > connector appearing, disappearing, and then a different connector
> > re-appearing.
> 
> But it is not about reappearing of drm_connector, it is about reappearing
> of drm_panel which is fortunately not a part of drm driver. Connector here
> is only consumer of drm_panel which should have possibility to receive
> notifications on panel (dis-)appearance.

Okay, so that's exactly like a panel being "hotplugged" to the connector,
which should be fine.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
