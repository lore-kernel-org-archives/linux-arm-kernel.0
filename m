From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Jan 2013 16:42:58 +0000
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <CAErSpo7fPzrF_OZSL7Ss0LT70Qz+veXLW-ihA7fAXCwsn142cQ@mail.gmail.com>
References: <CAErSpo7gCFfLB6+ebvANQjkr7Bii8Jqt3y5YqExD-DcnBG7hgA@mail.gmail.com>
 <20130129184157.GA29274@obsidianresearch.com>
 <CAErSpo5K8yKqjzQ6s+imb3d5wLSkhvWp-d=pPv9CZk+o67kyaQ@mail.gmail.com>
 <20130129191853.GB29274@obsidianresearch.com>
 <CAErSpo4Zvy7=ROajygecfsEFVJxy-yNbSntdQdDFcQBPz=Qgfg@mail.gmail.com>
 <CAErSpo41TbWTZ_6m0_uv-EaKnnqMR9jpqsarOJLGYZ31mrdkiw@mail.gmail.com>
 <20130130103501.1873d39c@skate>
 <CAErSpo5NTyrHv8AQkw3hYpJRiZsk1HKHP3jP_MMpEVVhCgjKYg@mail.gmail.com>
 <20130131170401.4b3bfbbf@skate>
 <CAErSpo7fPzrF_OZSL7Ss0LT70Qz+veXLW-ihA7fAXCwsn142cQ@mail.gmail.com>
Message-ID: <20130131164258.GD23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 09:30:07AM -0700, Bjorn Helgaas wrote:
> Linux makes the unwarranted assumption that the PCI hierarchy has
> already been configured by firmware.  If the only problem is the
> messages above, I think we could just rework the message so it doesn't
> look like an error.

That's not a safe assumption, especially on platforms where there's no
BIOS (like ARM platforms).  Thankfully, for the platforms I care about,
the boot loaders I wrote for them _do_ do a full bus setup, so I don't
see a problem. :)

However, I have historially had the kernel over many years (probably
around 14 or 15 now) reassign all resources so that things are how the
kernel wants them, and not how my half-hearted attempt at setting them
up did (which only does a limited job enough to get the system to a
state where we can load the kernel.)
