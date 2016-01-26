From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Jan 2016 22:35:51 +0000
Subject: Problem with component helpers and probe deferral in 4.5-rc1
In-Reply-To: <1453831153.2850.107.camel@linaro.org>
References: <1453831153.2850.107.camel@linaro.org>
Message-ID: <20160126223551.GU10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 05:59:13PM +0000, Jon Medhurst (Tixy) wrote:
> I believe I've found a problem with the component helpers and/or how
> drivers use them. I discovered this whilst trying to get ARM's HDLCD
> driver [1] working on 4.5-rc1, however I believe that code is following
> a pattern used by drivers already in 4.5 and the problem isn't specific
> to it. This is what I have observed...

Hmm, it all looks plausible, and I'm again left wondering how the code
passed testing over the last year (I've been running this code for
ages both on iMX6 and Dove, where deferred probing does happen.)

Your patch looks like the right thing to do, so I'll add it to the
component tree shortly - it should end up in linux-next in a few days
time.

Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
