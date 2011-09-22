From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Sep 2011 09:22:05 +0100
Subject: [PATCH] dmaengine: delete redundant chan_id and chancnt
	initialization in dma drivers
In-Reply-To: <CAGsJ_4zURv1_zJ0rwZawa8VSOw0kT9U4-cCCj2Q4-BhV1pdTHA@mail.gmail.com>
References: <1316166200-20595-1-git-send-email-Baohua.Song@csr.com>
	<CABb+yY2L=wfRoascoriAcnNMKkV7LbQEHCpp78+rCY=aM46x7A@mail.gmail.com>
	<CAGsJ_4zURv1_zJ0rwZawa8VSOw0kT9U4-cCCj2Q4-BhV1pdTHA@mail.gmail.com>
Message-ID: <20110922082205.GI17169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 08:08:44AM +0800, Barry Song wrote:
> actually i don't like the way dmaengine core handles chan_id. in my
> opinion, every dmac only needs to tell dmaengine core the chan_base.
> then dmaengine core set the id in a global scale.

Think about where we're heading with DT - with the description of the
hardware setup.  We're no longer interested in a global number from
0 to N.  We're more interested in per-device numbering.
