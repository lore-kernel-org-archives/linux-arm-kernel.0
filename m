From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Jul 2011 13:10:14 +0200
Subject: [PATCH v2] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <CAGsJ_4wf0Lhe2yHg1fE2QAF40=J6ZoubpfLFWQ6X9o3db0O8LQ@mail.gmail.com>
References: <1309231954-23260-1-git-send-email-bs14@csr.com>
	<201107041653.50962.arnd@arndb.de>
	<CAGsJ_4wf0Lhe2yHg1fE2QAF40=J6ZoubpfLFWQ6X9o3db0O8LQ@mail.gmail.com>
Message-ID: <201107051310.14405.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 July 2011, Barry Song wrote:
> > If your hardware can do that, you can replace the msleep() with a
> > single readl or a readl()/msleep(1) loop?
> 
> i can't agree more. if there is such a register in chip, we would have
> used it. ic guys confirmed there isn't such a register. so..delay...

Ok, fair enough. Maybe add a comment then to provide an explanation
why you are waiting for exactly 10ms. This will show up when people
try to optimize boot time, so it's good to know for the reader if it
can be made shorter or not.

	Arnd
