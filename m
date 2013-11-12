From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 12 Nov 2013 20:40:09 +0100
Subject: [RFC DTC PATCH] dtc: add symlink (-L) output to dtbs
In-Reply-To: <20131112193012.GR10335@titan.lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <52814AFB.3070600@wwwdotorg.org>
 <CAL_Jsq+mAoN2Lbg+uqfLMTZBvgz28E-EioiaU4BUSL_7rS5JjA@mail.gmail.com>
 <528275B7.6050209@wwwdotorg.org>
 <20131112193012.GR10335@titan.lakedaemon.net>
Message-ID: <20131112194009.GA13577@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 2) right now: distributions are creating utilities, such a flash-kernel
> in Debian, that pick from a slew of dtbs, append it to the zImage, and
> create the uImage.  The bootloaders in these installs don't have support
> for fdt.
> 
> Our problem (as I see it) is that #2 is creating an ABI out of something
> we never realized would become an ABI, the filenames created by 'make
> dtbs'.

Well, flash-kernel could be taught how to parse .dtb files to get the
compatibility strings out of them, rather than use filenames.

It might still be early enough to give distributions some guidelines
about what DT folks consider ABI and what is not. How they should find
a fitting .dtb file and how they should not.

  Andrew
