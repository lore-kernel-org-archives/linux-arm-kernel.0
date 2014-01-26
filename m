From: ben@decadent.org.uk (Ben Hutchings)
Date: Sun, 26 Jan 2014 18:56:30 +0000
Subject: Freescale FEC packet loss
In-Reply-To: <201401222255.29467.marex@denx.de>
References: <201401222255.29467.marex@denx.de>
Message-ID: <1390762590.2735.39.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-01-22 at 22:55 +0100, Marek Vasut wrote:
> Hi guys,
> 
> I am running stock Linux 3.13 on i.MX6Q SabreLite board. The CPU is i.MX6Q TO 
> 1.0 .
> 
> I am hitting a WARNING when I use the FEC ethernet to transfer data, thus I 
> started investigating this problem. TL;DR I am not able to figure this problem 
> out, so I am not attaching a patch :-(
> 
> Steps to reproduce:
> -------------------
> 1) Boot stock Linux 3.13 on i.MX6Q SabreLite board
> 2) Plug in an SD card into one of the SD slots (I use the full-size one)
> 3) Plug in an USB stick into one of the USB ports (I use the upper one)
> 4) Plug in an ethernet cable into the board
>    -> Connect the other side into a gigabit-capable PC
[...]

I think there are known problems with 1000BASE-T on the Sabre Lite
board.  Two possible workarounds are to limit the PHY to 100BASE-TX
(should be doable with ethtool) or force it to be clock master for
1000BASE-T (requires a driver patch).  The vendor kernel apparently does
both!  Matthew Garrett has been trying to implement a workaround in a
clean way.

Ben.

-- 
Ben Hutchings
If the facts do not conform to your theory, they must be disposed of.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140126/b5b61309/attachment-0001.sig>
