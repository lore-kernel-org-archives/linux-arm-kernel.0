From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 13 Jul 2011 11:29:15 +0200
Subject: [PATCH v2] AT91 OHCI active-high vbus and overcurrent handling
Message-ID: <1310549358-13330-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series of patches adds two features to the AT91 OHCI driver :
 * Support for active-high vbus pin USB power switches (patch 1)
 * Support for over-current notification (patches 2 and 3)

Changes since v1 (posted July, 5th 2011) :

 * Simplify expressions in gpio_direction_output() when controlling
   the VBUS pin, as suggested by Sergei Shtylyov
   <sshtylyov@mvista.com>

 * Extend the overcurrent notification support by notifying the USB
   stack and exposing the fact that per-port power switching and
   overcurrent notification, based on ohci-da8xx.c and ohci-s3c2410.c,
   as suggested by Matthieu CASTET <matthieu.castet@parrot.com>

I haven't yet taken into account Jean-Christophe Plagniol-Villard
comment on using the named ressources, because I don't see how a board
file can define ressources with the current AT91 code structure (the
ressources are only defined at the SoC level). Input from
Jean-Christophe on this would be greatly appreciated.

Regards,

Thomas
