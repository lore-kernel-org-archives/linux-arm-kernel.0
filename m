From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 4 Feb 2010 14:14:51 +0100
Subject: [PATCH 1/1] fix i2c_msg.len not aligning with i2c_master_send
In-Reply-To: <f17812d71002040447y4b6f889o1137ae6149559994@mail.gmail.com>
References: <309424b61002032204y37307236q94ab3a502b0526e0@mail.gmail.com>
	<20100204103530.65429c04@hyperion.delvare>
	<309424b61002040438i2fae055dt2d3ef528eae99b48@mail.gmail.com>
	<f17812d71002040447y4b6f889o1137ae6149559994@mail.gmail.com>
Message-ID: <20100204141451.3e0f865e@hyperion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 4 Feb 2010 04:47:41 -0800, Eric Miao wrote:
> > How about return error in i2c_master_send & i2c_master_recv when count
> > is bigger than 64K, as suggested by Ben.
> 
> I think that's more preferable. Making the count parameter as u16,
> though is going to generate a warning, yet that's usually ignored
> by careless programmer, screaming out when this happens might
> be more useful sometimes.

Developers ignoring warnings get the pain the deserve.

A check on "count" would come at the price of a small performance hit
for every caller, even though in 99% of the cases the check isn't
needed.

That being said I don't care too much and will take whatever patch is
sent to me.

It would be a good idea to add a note about this limit in
Documentation/i2c/writing-clients and/or include/linux/i2c.h.

> > The device I used could receive 32K one time instead, the firmware
> > download only takes place on-demand in fact.
> > However, it took some time to debug, since no error info come out.
> > Add error msg may notify users, though transfering more than 64K data
> > one time is rarely happen.

-- 
Jean Delvare
