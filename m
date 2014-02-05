From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 5 Feb 2014 19:41:47 +0000
Subject: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
In-Reply-To: <20140205192733.GG25695@obsidianresearch.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <1391532784-1953-3-git-send-email-will.deacon@arm.com>
 <3460536.Sh23gjDa6X@wuerfel>
 <20140205190947.GA22297@mudshark.cambridge.arm.com>
 <20140205192733.GG25695@obsidianresearch.com>
Message-ID: <CAFEAcA9bhWK+pSy8wVLtNPyHtBCnudLi7pMhNny=ZfgNLty87Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 February 2014 19:27, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> I can't think of a reason to support alternate MMIO layouts if
> kvmtool is the only user and can be changed.

I expect we'll get a QEMU implementation too at some point,
but we should be able to just make that match whatever you
decide is the correct layout and behaviour.

The only constraint QEMU has which kvmtool doesn't is that
we care about not randomly shuffling things around between
QEMU versions, so whatever we pick we're more or less
stuck with. So a layout which leaves scope for "supports
PCI now, may do PCI-e later, MSI after that" would be good.
(My PCI knowledge is very piecemeal, I hope that makes sense...)

thanks
-- PMM
