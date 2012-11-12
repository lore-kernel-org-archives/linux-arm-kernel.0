From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Sun, 11 Nov 2012 22:53:46 -0800
Subject: [PATCH 1/3] gpio: Add simple poweroff-gpio driver
In-Reply-To: <20121112060740.GR24583@lunn.ch>
References: <1352650891-18356-1-git-send-email-andrew@lunn.ch>
 <1352650891-18356-2-git-send-email-andrew@lunn.ch>
 <CACRpkdZvHBjFQTrQnxvc3WCOb2CqGbjYJxyQ5qQkSbU+UWHYZA@mail.gmail.com>
 <20121112011258.GA23724@lizard> <20121112060740.GR24583@lunn.ch>
Message-ID: <20121112065346.GA12571@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Mon, Nov 12, 2012 at 07:07:40AM +0100, Andrew Lunn wrote:
[...]
> > > But I suspect Anton may be ready to welcome a driver like this
> > > under drivers/power/* which I think is where it belongs.
> > 
> > Yup. driver/power/reset/ seems appropriate.
> 
> I was unsure where to put it. I will submit new patches with the move.
> 
> I'm not too sure about 'reset' though. Its not a reset operation, the
> power goes off and stays off. Would 'shutdown' or 'power_off' be
> better?

Other folks already wanted drivers/power/reset/ for board reset/poweroff
drivers. But it makes little sense to make both reset and poweroff
directories. So, let's just do 'reset', somebody might have already using
it in their private trees.

Thanks,
Anton.
