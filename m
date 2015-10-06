From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 6 Oct 2015 05:31:31 +0200
Subject: [PATCH 6/8] ARM: mvebu: enable SDHCI card detection using DAT3
 pin on A388-GP
In-Reply-To: <1444094562-31165-7-git-send-email-mw@semihalf.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
 <1444094562-31165-7-git-send-email-mw@semihalf.com>
Message-ID: <20151006033131.GA24230@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 03:22:40AM +0200, Marcin Wojtas wrote:
> The newest revisions of A388-GP (v1.5 and higher) support only
> DAT3-based card detection, which is enabled by this commit. Hitherto
> revisions, without such modification, will be impacted with a broken
> card detection - in order to operate the cards have to be present
> during kernel boot.

Humm. Is this acceptable, breaking old boards?

I would say at minimum, there should be a big fat comment at the top
of armada-388-gp.dts explaining that this DTS file is broken on
v0.0-v1.4.

Or we have two .dts files for the 388-gp file, and a dtsi file.

   Andrew
