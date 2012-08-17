From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri, 17 Aug 2012 08:53:01 +0200
Subject: [PATCH 13/14] arm: at91: dt: at91sam9 add nand pinctrl support
In-Reply-To: <20120816173844.GC7439@game.jcrosoft.org>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-13-git-send-email-plagnioj@jcrosoft.com>
 <CACRpkdZXjFE7UsRneskNqnN7DFERHxgAt-FCXtL2A52xKgEA=w@mail.gmail.com>
 <CACQ1gAhWdwrXEkicy4ij=rukzS-v98bZRr433Qq5M_Dan5JAog@mail.gmail.com>
 <20120816173844.GC7439@game.jcrosoft.org>
Message-ID: <CACQ1gAgqXOJiiocOEMBZiaBchXDhvxqfA7RkiEvCCsv000LQNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/8/16 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
>> Maybe it will be more readable if we use something like :
>> atmel,pull-up;
>> atmel,multidrive;
>> atmel,mux="GPIO"
>> atmel,mux="A"
>> ...
>> just my 2 cents...
> no too much data and too much node as you will need a node per pin which we
> tyr to avoid

One one hand we've got a DTS quite concise but unreadable, and on the
other hand, something understandable but huge.
( and it's not specific to your patch Jean-Christophe, on imx6q.dtsi,
it looks worse )
I'm just trying to make sure that having a DTS like that :
nand {
	pinctrl_nand: nand-0 {
		atmel,pins =
			<2 13 0x0 0x1   /* PC13 gpio RDY pin pull_up */
			2 14 0x0 0x1>; /* PC14 gpio enable pin pull_up */
	};
};
is better than :
nand {
	pinctrl_nand: nand-0 {
		nand_rdy { atmel,bank = "C"; atmel,pin = <13>; atmel,mux = "GPIO";
atmel,pull-up; };
		nand_ena { atmel,bank = "C"; atmel,pin = <14>; atmel,mux = "GPIO";
atmel,pull-up; };
	};
};
It's what you did in 1st place on linux-at91 git, and I kinda liked it.
But yeah, it's more verbose, and some lines will go beyond 80 columns,
but that's already the case.

Best regards,

Richard.

-- 
for me, ck means con kolivas and not calvin klein... does it mean I'm a geek ?
