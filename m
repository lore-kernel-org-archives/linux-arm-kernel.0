From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 16 May 2011 10:28:46 -0400
Subject: [patch 0/4] [RFC] mcount address adjustment
In-Reply-To: <20110516125717.GB7715@arm.com>
References: <20110510081039.241831019@de.ibm.com>
	<BANLkTi=6FLtzXwg1yLAkLhP4GA4apSQ46g@mail.gmail.com>
	<20110512112454.2fa7e6d6@mschwide>
	<BANLkTinY+gDxoHk4378kXd8WH-hf9CN6ZA@mail.gmail.com>
	<20110516125717.GB7715@arm.com>
Message-ID: <1305556127.5456.1.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-16 at 13:57 +0100, Dave Martin wrote:

> Is there any reason why the recordmcount.pl would ever be used now that the
> C implementation exists?
> 
> I notice that arch/arm/Kconfig has:
> 
> config ARM
> ...
>         select HAVE_C_RECORDMCOUNT
> 
> so deprecating ARM support from recordmcount.pl seems unlikely to hurt
> anyone.
> 
> The C implementation seems to have worked fine when I was testing dynamic
> ftrace with Thumb-2 recently.

It's there only as a backup. But you're right. I may as well start
removing the recordmcount.pl support from those that have the
HAVE_C_RECORDMCOUNT set, and then all users are gone (which may now be
the case) either keep it around as a backup for testing against
recordmcount.c, or remove it completely.

-- Steve
