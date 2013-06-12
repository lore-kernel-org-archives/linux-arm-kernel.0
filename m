From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Jun 2013 15:51:39 +0100
Subject: [PATCHv4 2/9] i2c: mv64xxx: make the registers offset configurable
In-Reply-To: <20130612144447.GI16699@lukather>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
 <1371024438-16631-3-git-send-email-maxime.ripard@free-electrons.com>
 <20130612135735.GR18614@n2100.arm.linux.org.uk>
 <20130612144447.GI16699@lukather>
Message-ID: <20130612145139.GS18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 04:44:47PM +0200, Maxime Ripard wrote:
> Hi Russel,
> 
> On Wed, Jun 12, 2013 at 02:57:35PM +0100, Russell King - ARM Linux wrote:
> > It'd be much better to copy the offsets themselves in drv_data.  You're
> > only talking about 7 bytes here, so there's no worry about bloating the
> > drv_data structure.
> 
> It was more about keeping things separated. Moreover, the probe
> function gets smaller, since you have only a pointer to pass on, instead
> of assigning those 7 bytes.

	struct driver_data {
		struct mv64xxx_i2c_regs reg_offsets;
	};

	struct driver_data *drv_data;

	memcpy(drv_data->reg_offsets, reg_offsets, sizeof(drv_data->reg_offsets));

No need to write it each member as a separate assignment.
