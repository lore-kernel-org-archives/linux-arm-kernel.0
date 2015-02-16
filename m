From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 Feb 2015 17:49:20 +0100
Subject: [PATCH v3 1/2] mtd: nand: pxa3xx: Fix PIO FIFO draining
In-Reply-To: <54E1F236.4090706@free-electrons.com>
References: <1424091072-7738-1-git-send-email-maxime.ripard@free-electrons.com>
 <1424091072-7738-2-git-send-email-maxime.ripard@free-electrons.com>
 <54E1F236.4090706@free-electrons.com>
Message-ID: <20150216164920.GF25269@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 16, 2015 at 10:35:50AM -0300, Ezequiel Garcia wrote:
> On 02/16/2015 09:51 AM, Maxime Ripard wrote:
> > The NDDB register holds the data that are needed by the read and write
> > commands.
> > 
> > However, during a read PIO access, the datasheet specifies that after each 32
> > bits read in that register, when BCH is enabled, we have to make sure that the
> > RDDREQ bit is set in the NDSR register.
> > 
> 
> Typo s/32 bits/32 bytes

Good catch, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150216/b05f972f/attachment.sig>
