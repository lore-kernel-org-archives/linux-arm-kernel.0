From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 May 2013 14:26:30 +0200
Subject: [RFC PATCHv3 3/6] clk: Add TI-Nspire clock drivers
In-Reply-To: <C574C0B3-194E-451A-8584-A351D85C5792@gmail.com>
References: <1368332581-94691-1-git-send-email-dt.tangr@gmail.com>
 <201305192148.46398.arnd@arndb.de>
 <C574C0B3-194E-451A-8584-A351D85C5792@gmail.com>
Message-ID: <4603632.xLpXUpmrfP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 May 2013 21:19:33 Daniel Tang wrote:
> On 20/05/2013, at 5:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Sunday 19 May 2013, Daniel Tang wrote:
> >> If the vendors for the on-SOC components are unknown, should we just
> >> leave the compatible strings as is (i.e. "nspire-XXX")?
> > 
> > In that case, I would use the name of the company that made the SoC.
> > I believe someone mentioned it was made by LSI logic.
> 
> Yep, that's right. So "lsi,nspire-XXX" should be fine?

I wouldn't use that combination, since lsi did not make the nspire.
For anything on the LSI chip, "lsi,zevio-XXX" would be correct,
or maybe "lsi,zevio1020-XXX" for something specific to a particular
SoC variant. For off-SoC parts, "ti,nspire-XXX" would be right,
or "ti,nspire-cx-XXX" if you care about the model.

	Arnd
