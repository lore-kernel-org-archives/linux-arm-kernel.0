From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Jul 2014 17:02:38 +0100
Subject: gpio-mxc gpio get always returns 0 for outputs for IMX6
In-Reply-To: <CAJ+vNU3w9Oi+dErmy9x8g6ps=eLHLNLO-w7=gn_8JtY4Kab6JQ@mail.gmail.com>
References: <CAJ+vNU3w9Oi+dErmy9x8g6ps=eLHLNLO-w7=gn_8JtY4Kab6JQ@mail.gmail.com>
Message-ID: <20140711160238.GD21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 08:34:19AM -0700, Tim Harvey wrote:
> I've noticed that for IMX6 the gpio-mxc gpio driver always returns 0
> for gpio's configured as outputs regardless of if they are outputing
> high or low.

There's a different way which this can be solved - set the SION but on
your GPIOs.  You will then be able to read back the state of the
output pin.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
