From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Nov 2013 09:30:34 +0100
Subject: [PATCH v2] serial: 8250_dw: Improve unwritable LCR workaround
In-Reply-To: <20131127185448.GA21422@localhost>
References: <1380647888-32473-1-git-send-email-tim.kryger@linaro.org>
 <20131126183559.GA18570@localhost>
 <CAAYSxhqU9GZdaoTjoCAeyQ4h-KPVzU0BH0D1eLYJoFZ+s8tPgQ@mail.gmail.com>
 <20131127185448.GA21422@localhost>
Message-ID: <20131128093034.5d61130a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Wed, 27 Nov 2013 15:54:49 -0300, Ezequiel Garcia wrote:

> > An external device may be keeping the UART busy and preventing LCR
> > from being written.
> > 
> > What device is attached to ttyS1?
> 
> There's no device attached at ttyS1. I've just tested this in another
> box and it seems the same error is obtained on each unused port:

Are you sure about this? I suppose you're testing on the Armada XP GP
board, and this board has a 4 ports FTDI chip, and according to the
board schematics the four UARTs are all connected to the FTDI chip. So
from the SoC perspective, ttyS1 is connected to something, as far as I
can understand. Or maybe you also tested Armada XP DB ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
