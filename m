From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 16 Apr 2014 18:03:15 +0200
Subject: [PATCH 5/6] ARM: mvebu: Add thermal quirk for the Armada 375 DB
 board
In-Reply-To: <534EA8C9.7010907@gmail.com>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1397657720-10893-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <534EA8C9.7010907@gmail.com>
Message-ID: <20140416180315.5153c3f7@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Wed, 16 Apr 2014 17:59:05 +0200, Sebastian Hesselbarth wrote:

> Are we sure, we want to fixup quirks like this the way below?

We already have an exactly identical quirk for the A0 I2C issue, in the
same file, right above the quirk Ezequiel is adding here. So using the
same strategy for both cases would be nice.

> Alternatively, we can also keep some armada-375-z1.dtsi and one
> for the board including it.

For minor differences such as SoC stepping, I personally prefer to not
have separate Device Trees. We already have many of them, for each
variant of the various SOCs. If we add the different steppings, it's
going to be even more complicated. Also, there will be a new iteration
of the Armada 375 DB with an A0 chip, which does not have the Z1 bug.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
