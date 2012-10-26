From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 26 Oct 2012 07:50:56 +0200
Subject: [PATCH 3/6] ARM: OMAP2+: Move plat/iovmm.h to
 include/linux/omap-iommu.h
In-Reply-To: <20121025213935.GD11928@atomide.com>
References: <20121025001913.2082.31062.stgit@muffinssi.local>
 <1466344.HbU9q5zM1q@avalon> <20121025165643.GP11928@atomide.com>
 <1351198976.2hJjhe5gKC@avalon> <20121025213935.GD11928@atomide.com>
Message-ID: <CAK=WgbaCM+MWiHARvdfaGL6w0c7g4_keAm0ADw1vkSeiZ0CZPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 11:39 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > Joerg and Ohad, do you have any opinions on this?

I agree that there's some merit in having a separate header file for
IOVMM, since it's a different layer from the IOMMU API.

But in reality it's tightly coupled with OMAP's IOMMU, and ideally it
really should go away and be replaced with the DMA API.

For this reason, and for the fact that anyway there's only a single
user for it (omap3isp) and there will never be any more, maybe we
shouldn't pollute include/linux anymore.

Anyone volunteering to remove IOVMM and adapt omap3isp to the DMA API
instead ? ;)

Thanks,
Ohad.
