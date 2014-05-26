From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 May 2014 14:09:31 -0300
Subject: [PATCH] ahci: imx: PLL clock needs 100us to settle down
In-Reply-To: <20140525064043.GC2650@dragon>
References: <1400330761-2432-1-git-send-email-shawn.guo@freescale.com>
 <CAOMZO5AUFkRY2VJYdTNQvs=vTagFQBaYBynpBRj5e_DsD2EXqQ@mail.gmail.com>
 <20140525064043.GC2650@dragon>
Message-ID: <CAOMZO5DnSVgn+Y_i6b-cSgThh8xmG60Hd70-YrR7ELRNGJ1piQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 25, 2014 at 3:40 AM, Shawn Guo <shawn.guo@freescale.com> wrote:

> Hmm, I haven't seen this?  How do I reproduce it on imx6q?

Run linux-next on a mx6qsabresd with no SATA disk connected and then:

$ echo enabled > /sys/class/tty/ttymxc0/power/wakeup
$ echo mem > /sys/power/state

Hit any key in console and then you will get the warning from ahci_imx suspend.
