From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 04 Jan 2013 08:38:08 +0100
Subject: Kirkwood issues with 3.8-rc1 - Ooops and hang on reboot
In-Reply-To: <CAMW5UfbvwVgBiDQxSEJ5+rg4ZL1mCxTQ_xgcZL-8rTZCf3uV4w@mail.gmail.com>
References: <20121228171749.GA6152@lunn.ch>
 <20121228173818.GD24604@n2100.arm.linux.org.uk>
 <CAMW5UfaPv=Rq64MVtJNsdt8L4+0bq=cvbw5nqFBEcjY_+3cHZA@mail.gmail.com>
 <20121230002301.GA2631@n2100.arm.linux.org.uk>
 <CAMW5UfZiUmGs9BRMz-NOAiU=E3uH8ZnSkAKPM6vud-PRwKfjZQ@mail.gmail.com>
 <50E53FC7.1060202@lunn.ch>
 <CAMW5UfbvwVgBiDQxSEJ5+rg4ZL1mCxTQ_xgcZL-8rTZCf3uV4w@mail.gmail.com>
Message-ID: <50E686E0.5010001@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/13 00:26, Josh Coombs wrote:
> I did a test build with the __init tag removed (which is not the
> correct answer) and everything works.  GPIO is functional (I didn't
> catch the power LED wasn't working prior), I don't get a panic, and I
> can now reboot cleanly as well.  So that confirms the basic diagnosis.
>
> I've been trying to wrap my head around include/linux/init.h to see
> what the correct tagging should be but I'll admit, I'm in over my head
> so far.  If anyone has suggested reading on the topic I'd be very
> appreciative.

Hi Josh

The question is, when can this function be used? Only during boot time? 
Or at any time? For functions which are only used during boot, __init is 
O.K. However, since modules can also want to use clks, we need to be 
able to look up clocks at any time. So this function needs to be around 
all the time, which is the default behavior of no tag.

	Andrew
