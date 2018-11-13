From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Tue, 13 Nov 2018 17:55:58 +0100
Subject: [PATCH 0/5] media: Allwinner A10 CSI support
In-Reply-To: <cb504ffc-b74c-d6e3-7bde-6c5840c87997@cisco.com>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <df54f2e6-e207-92de-767a-e356345a1a56@xs4all.nl>
 <20181113135259.onutfjtoi25afnfe@flea>
 <f07a0460-cdba-c1a5-acfd-66a39f447a5a@cisco.com>
 <20181113155227.62jjs3mpomwgr7xd@flea>
 <cb504ffc-b74c-d6e3-7bde-6c5840c87997@cisco.com>
Message-ID: <20181113175558.3bfa3e8d@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 13 Nov 2018 17:00:25 +0100, Hans Verkuil wrote:

> Weird, if I build directly from that tarball, then v4l2-compliance should say:
> 
> v4l2-compliance SHA: not available, 64 bits
> 
> So that's what I expect to see from buildroot as well.

Indeed, that's strange, I see that the v4l2-compliance Makefile does:

version.h:
        @if git -C $(srcdir) rev-parse HEAD >/dev/null 2>&1; then \
                echo -n "#define SHA " >$@ ; \
                git -C $(srcdir) rev-parse HEAD >>$@ ; \
        else \
                touch $@ ; \
        fi

which correctly uses $(srcdir), so it shouldn't go "up" the libv4l
build folder and pick up the latest Buildroot commit SHA1. I'll have a
quick look.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
