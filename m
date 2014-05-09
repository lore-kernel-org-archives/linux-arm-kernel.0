From: grundler@chromium.org (Grant Grundler)
Date: Fri, 9 May 2014 07:59:44 -0700
Subject: [RFC] Describing arbitrary bus mastering relationships in DT
In-Reply-To: <20140509103309.GA3875@e103592.cambridge.arm.com>
References: <20140501173248.GD3732@e103592.cambridge.arm.com>
 <6555552.UqkKQIAsih@wuerfel>
 <20140502174301.GE3805@e103592.cambridge.arm.com>
 <4735818.FvYoTFuExd@wuerfel>
 <20140509103309.GA3875@e103592.cambridge.arm.com>
Message-ID: <CANEJEGuBD7RH32=YTjPmBt=Ykq21bSQ6gMtfU4H1qTbFPcWLYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave,
Mostly agree with your assessment. My $0.02 on one comment:


On Fri, May 9, 2014 at 3:33 AM, Dave Martin <Dave.Martin@arm.com> wrote:
....
> The downside is that is any path flows through a dynamically
> configurable component, such as an IOMMU or a bridge that can be
> remapped, turned off etc., then unless we describe how the path is
> really linked together the kernel will need all sorts of baked-in
> knowledge in order to manage the system safely.

Absolutely. Some knowledge (assumptions) will be "baked in" as code
and some knowledge (explicit parameters) as device tree.

My understanding of device tree is it essentially specifies
"parameters" and "methods" (code provided in the kernel). All methods
make some assumptions about the behavior of the HW it's operating on
and as long as all users of a method share that assumption, all is
well. We don't need device tree to describe those assumptions.

cheers,
grant
