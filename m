From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 24 May 2012 06:38:48 +0300
Subject: ARM: ETH PHY Micrel: KSZ8051MNL Driver?
In-Reply-To: <87obpepscr.fsf@macbook.be.48ers.dk>
References: <1337720919.493.YahooMailClassic@web45209.mail.sp1.yahoo.com>
 <87obpepscr.fsf@macbook.be.48ers.dk>
Message-ID: <20120524033848.GA9851@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter, Shmuel,

On Wed, May 23, 2012 at 10:14:44PM +0200, Peter Korsgaard wrote:
> >>>>> "Shmuel" == Shmuel Yitzhaki <shmuelyi@yahoo.com> writes:
> 
>  Shmuel> Hi Everyone,
>  Shmuel> Do you know if this newer chip is compatible with older Micrel devices
>  Shmuel> (supported at mainline)?
>  Shmuel> Did anyone try using it? results?
> 
> I'm using it with the generic genphy driver without any problems. I
> haven't tried the micrel driver, but as the board doesn't have the
> interrupt connected it wouldn't really buy me anything.
> 
> I can give the micrel driver a try if you want though.

In one project that were using the KSZ8051MNL PHY, we needed the micrel phy 
driver to set 50MHz RMII clock. This PHY defaults to 25MHz MII, and there is 
no way to change that with pull-up resistors. See commit d606ef3f (phy/micrel: 
add ability to support 50MHz RMII clock on KZS8051RNL).

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
