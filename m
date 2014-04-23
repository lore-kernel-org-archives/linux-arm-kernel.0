From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 23 Apr 2014 09:46:26 -0300
Subject: [PATCH v2 17/38] ARM: orion5x: use node labels for UART and SATA
 on edmini_v2
In-Reply-To: <20140423142334.286c57c0@skate>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-18-git-send-email-thomas.petazzoni@free-electrons.com>
 <5357A2BA.1050900@gmail.com> <20140423142334.286c57c0@skate>
Message-ID: <20140423124626.GB1797@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Apr 23, Thomas Petazzoni wrote:
[..]
> 
> I continue to have mixed feelings about the usage of node labels. To
> me, it breaks the "tree" nature of the Device Tree, by turning it into
> just a bunch of &bleh { ... } long list of statements. But this is
> purely subjective (just like your opinion, I believe), and I wanted to
> move forward with this, so I just did what was necessary :-)
> 

Let me try to convince you a little :) Regressions like this would never
appear with proper usage of phandles:

http://www.spinics.net/lists/arm-kernel/msg322999.html

This may be a matter of taste, but when I'm on the devicetree "user" side,
I really don't care if the USB0 is part of some super complex tree, but just
want to enable it in my board. Writing:

&usb0 {
	status = "okay";
};

seems to be just fine.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
