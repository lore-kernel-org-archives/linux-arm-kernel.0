From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 22 Dec 2011 20:08:34 +0800
Subject: [PATCH v4] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
In-Reply-To: <20111221034753.GC5983@S2101-09.ap.freescale.net>
References: <1323852927-13521-1-git-send-email-Barry.Song@csr.com>
 <20111220200750.GA2577@n2100.arm.linux.org.uk>
 <CAGsJ_4y8vwrK=UD8a10gf2aN=O3hs_R_jYBKeFYf0v+gk0hiuQ@mail.gmail.com>
 <20111221033444.GH15863@b20223-02.ap.freescale.net>
 <20111221034753.GC5983@S2101-09.ap.freescale.net>
Message-ID: <CAGsJ_4wS1Otr3Od3y+pBg+YssDbwhU2xKsKzJk_UcVowxwzVOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/12/21 Shawn Guo <shawn.guo@freescale.com>:
> On Wed, Dec 21, 2011 at 11:34:45AM +0800, Richard Zhao wrote:
>> On Wed, Dec 21, 2011 at 11:29:29AM +0800, Barry Song wrote:
>> > 2011/12/21 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> > > On Wed, Dec 14, 2011 at 04:55:27PM +0800, Barry Song wrote:
>> > >> +static int __devinit i2c_sirfsoc_probe(struct platform_device *pdev)
>> > >> +{
>> > >> + ? ? struct clk *clk;
>> > >> +
>> > >> + ? ? clk = clk_get(&pdev->dev, NULL);
>> > >> + ? ? err = clk_prepare(clk);
>> > >> + ? ? err = clk_enable(clk);
>> > > ...
>> > >> + ? ? clk_disable(clk);
>> > >> +
>> > >> + ? ? dev_info(&pdev->dev, " I2C adapter ready to operate\n");
>> > >> +
>> > >> + ? ? return 0;
>> > >> +}
>> > >> +
>> > >> +static int __devexit i2c_sirfsoc_remove(struct platform_device *pdev)
>> > >> +{
>> > >> + ? ? clk_disable(siic->clk);
>> > >> + ? ? clk_unprepare(siic->clk);
>> > >> + ? ? clk_put(siic->clk);
>> > >
>> There's a handy clk_disable_unprepare function in the patch I ever sent
>> out. It's in Sascha or Shawn's tree.
>>
> We cannot really ask people to use that before it hits Linus' tree.

Thanks. Shawn/Richard.
The problem is that Ben seems to have been scheduled to TASK_UNINTERRUPTIBLE.

>
> --
> Regards,
> Shawn
>

-barry
