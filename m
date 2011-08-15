From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 15 Aug 2011 09:15:20 -0700
Subject: [RFC PATCH 05/12] arm/dt: Tegra: Add nvidia,gpios property to
	GPIO controller
In-Reply-To: <CAOesGMj8firxDz-kqkh=jwsbC_QRW+YSFpf7dh3WaOhseCg91w@mail.gmail.com>
References: <1313189697-21287-1-git-send-email-swarren@nvidia.com>
	<1313189697-21287-6-git-send-email-swarren@nvidia.com>
	<CAOesGMj8firxDz-kqkh=jwsbC_QRW+YSFpf7dh3WaOhseCg91w@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04AEA25057@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Sunday, August 14, 2011 1:02 AM:
> On Fri, Aug 12, 2011 at 3:54 PM, Stephen Warren <swarren@nvidia.com> wrote:
> > Add board-specific gpio node for Harmony and Seaboard. This lists the
> > GPIOs used by the board. Note that not all GPIOs that exist on the board
> > are listed; only those used by devices currently supported by device
> > tree.
> 
> I don't want to bikeshed over this, but something like
> "nvidia,enabled-gpios" could be a bit more descriptive. Either way is
> OK though.

Yes, that's a much better name.

Existing board files do have a Boolean enabled/disabled flag per GPIO,
which is currently always true,  whereas this patch series only implements
"enabled" entries. I thought about it briefly, and didn't think that
explicitly disabling GPIOs that the bootloader had already enabled was
likely to be useful. Do you agree? Possibly not since IIRC you added the
tables that contain that Boolean.

> The property should be documented under the bindings Documentation/
> hierarchy though.

Yup. The next posting will include this.

-- 
nvpublic
