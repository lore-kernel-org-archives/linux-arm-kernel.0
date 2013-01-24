From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 24 Jan 2013 09:37:36 -0500
Subject: [RFC PATCH 6/6] ARM: kirkwood: consolidate mv643xx_eth init for DT
In-Reply-To: <51013933.9020601@openwrt.org>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <ecb64cdf824399badaf9d659177811d8cb091156.1358983578.git.jason@lakedaemon.net>
 <51013933.9020601@openwrt.org>
Message-ID: <20130124143736.GZ1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 02:37:55PM +0100, Florian Fainelli wrote:
> Hello Jason,
> 
> On 01/24/2013 12:34 AM, Jason Cooper wrote:
> >replace a lot of unneeded code and files with a lookup table.
> 
> Would not it be better to keep all of this as-is and merge/improve
> Ian's mv643xx_eth device tree bindings [1], and then only remove
> these files? It is just 81 new lines, so it is not a big deal, just
> wondering here what is best.

I agree, however, there is a long history with that patch.  That driver
has been in use by powerpc for many years.  We need to be mindful not to
break existing installations.  I don't think it'll be ready in time for
v3.9.  So, I'd like to do the cleanup now.

thx,

Jason.

> [1]: http://patchwork.ozlabs.org/patch/175652/
