From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 15 Nov 2016 17:30:36 +0100
Subject: [PATCH net 1/3] net: phy: realtek: add eee advertisement disable
 options
In-Reply-To: <1479220154-25851-2-git-send-email-jbrunet@baylibre.com>
References: <1479220154-25851-1-git-send-email-jbrunet@baylibre.com>
 <1479220154-25851-2-git-send-email-jbrunet@baylibre.com>
Message-ID: <20161115163036.GB23231@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 03:29:12PM +0100, Jerome Brunet wrote:
> On some platforms, energy efficient ethernet with rtl8211 devices is
> causing issue, like throughput drop or broken link.
> 
> This was reported on the OdroidC2 (DWMAC + RTL8211F). While the issue root
> cause is not fully understood yet, disabling EEE advertisement prevent auto
> negotiation from enabling EEE.
> 
> This patch provides options to disable 1000T and 100TX EEE advertisement
> individually for the realtek phys supporting this feature.

Looking at the code, i don't see anything specific to RealTek
here. This all seems generic. So should it be in phy.c and made a
generic OF property which can be applied to any PHY which supports
EEE.

      Andrew
