From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Oct 2014 22:40:29 +0100
Subject: [PATCH v4 1/3] power-domain: add power domain drivers for
 Rockchip platform
In-Reply-To: <7hppdme8d6.fsf@deeprootsystems.com>
References: <1413795824-3453-1-git-send-email-jinkun.hong@rock-chips.com>
 <1413795824-3453-2-git-send-email-jinkun.hong@rock-chips.com>
 <7hppdme8d6.fsf@deeprootsystems.com>
Message-ID: <20141020214029.GY27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 02:31:17PM -0700, Kevin Hilman wrote:
> "jinkun.hong" <jinkun.hong@rock-chips.com> writes:
> > +	spin_lock_irqsave(&pd->idle_lock, flags);
> > +	val = (idle) ? mask : 0;
> > +	regmap_update_bits(pd->regmap_pmu, REQ_OFFSET, mask, val);
> > +	dsb();
> 
> A summary of the locking and barriers here (or in changelog) would be
> helpful for reviewers to verify you're protecting what you need to
> protect.

It's also worth saying that the Linux specific barrier names should be
used unless there is a pressing reason to use the ARM specific barrier
names.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
