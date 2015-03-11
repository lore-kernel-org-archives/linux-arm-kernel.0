From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Mar 2015 13:12:42 +0000
Subject: [PATCH 2/2] ARM: l2c: Maintain CPU endianness for early resume
 function
In-Reply-To: <20150311101845.GL19577@ulmo.nvidia.com>
References: <1421757420-20983-1-git-send-email-digetx@gmail.com>
 <20150311101845.GL19577@ulmo.nvidia.com>
Message-ID: <20150311131242.GB8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 11:18:46AM +0100, Thierry Reding wrote:
> On Tue, Jan 20, 2015 at 03:36:55PM +0300, Dmitry Osipenko wrote:
> > In big endian CPU mode l2x0_saved_regs structure stores registers values in BE
> > format. In order to maintain BE CPU mode, these values and immediate constants
> > must be converted back to LE format before writing them to cache controller.
> > 
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  arch/arm/mm/l2c-l2x0-resume.S | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> 
> Hi Russell,
> 
> Did you get a chance yet to review this patch? It's a dependency for
> enabling big-endian support on Tegra. As such, I wonder if you would be
> willing to ack it, so that I can take it through the Tegra tree along
> with the rest of the patches.

Yes, it's fallen through the cracks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
