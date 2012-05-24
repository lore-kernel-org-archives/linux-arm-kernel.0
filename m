From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 24 May 2012 09:10:54 +0200
Subject: ARM: ETH PHY Micrel: KSZ8051MNL Driver?
In-Reply-To: <20120524033848.GA9851@sapphire.tkos.co.il> (Baruch Siach's
 message of "Thu, 24 May 2012 06:38:48 +0300")
References: <1337720919.493.YahooMailClassic@web45209.mail.sp1.yahoo.com>
 <87obpepscr.fsf@macbook.be.48ers.dk>
 <20120524033848.GA9851@sapphire.tkos.co.il>
Message-ID: <878vgioxz5.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Baruch" == Baruch Siach <baruch@tkos.co.il> writes:

Hi,

 >> I can give the micrel driver a try if you want though.

 Baruch> In one project that were using the KSZ8051MNL PHY, we needed
 Baruch> the micrel phy driver to set 50MHz RMII clock. This PHY
 Baruch> defaults to 25MHz MII, and there is no way to change that with
 Baruch> pull-up resistors. See commit d606ef3f (phy/micrel: add ability
 Baruch> to support 50MHz RMII clock on KZS8051RNL).

Yes, that's indeed quite unfortunate. For this project I write the phy
register in the bootloader as we need it there anyway, but for another
(am335x based) project it means we cannot used the ROM support for
network boot.

Is 50MHz is needed, the 8021/8031 are probably a better choice.

-- 
Bye, Peter Korsgaard
