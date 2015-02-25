From: jasper@endlessm.com (Jasper St. Pierre)
Date: Wed, 25 Feb 2015 09:27:54 -0800
Subject: [PATCH] ARM: dma-mapping: support non-consistent DMA attribute
In-Reply-To: <20150225172551.GG8656@n2100.arm.linux.org.uk>
References: <1424810703-20382-1-git-send-email-drake@endlessm.com>
 <16874142.jSTJ8OZePS@wuerfel>
 <CAD8Lp46KOQZMJqiqudE_0nvpaHgYxpD0qCeM2r8ZOgfzJUo6dA@mail.gmail.com>
 <20150225141846.GZ8656@n2100.arm.linux.org.uk>
 <CAD8Lp46de18aC+6cQUyn3hZV3HhLHNMsOuxSoQVg+5hU7vPMdA@mail.gmail.com>
 <20150225144208.GA8656@n2100.arm.linux.org.uk>
 <CABqkSC+Pgc2tZm8X+wuk4zL7=QebqL9yzX3LNZec0WfaGNr-bw@mail.gmail.com>
 <20150225172551.GG8656@n2100.arm.linux.org.uk>
Message-ID: <CABqkSCKzDQ4Ac6t-kED94TWP5juPkikbzBHkmQovt0kfagRiNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 9:25 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> It seems to be a reasonable thing to do.
>
> However, what I would raise is whether you /really/ want to be using
> CMA for this.

Our scanout hardware / display controller does not have an iommu, and
requires contiguous buffers.

> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.

-- 
  Jasper
