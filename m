From: davem@davemloft.net (David Miller)
Date: Mon, 19 Feb 2018 18:43:43 -0500 (EST)
Subject: [PATCH net 2/4] net/8390: Fix msg_enable patch snafu
In-Reply-To: <alpine.LNX.2.21.1802200844340.8@nippy.intranet>
References: <db538e6962eb16045ec85c15aee2b9b30eedcce5.1519007130.git.fthain@telegraphics.com.au>
 <20180219.141137.2095980245673495027.davem@davemloft.net>
 <alpine.LNX.2.21.1802200844340.8@nippy.intranet>
Message-ID: <20180219.184343.1801583131809551924.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Finn Thain <fthain@telegraphics.com.au>
Date: Tue, 20 Feb 2018 09:01:11 +1100 (AEDT)

> On Mon, 19 Feb 2018, David Miller wrote:
> 
>> From: Finn Thain <fthain@telegraphics.com.au>
>> Date: Sun, 18 Feb 2018 21:39:17 -0500 (EST)
>> 
>> > The lib8390 module parameter 'msg_enable' doesn't do anything useful:
>> > it causes an ancient version string to be logged.
>> 
>> Since you are removing the last reference to this 'version' string
>> you should remove it as well.
>> 
>> I'm surprised the compiler doesn't warn about this.
>> 
> 
> I compile-tested every 8390 module and I didn't come across any compiler 
> bugs.
> 
> Please take another look. I think you'll find that lib8390.c is always 
> #included by a module which does define that symbol.

But nothing references 'version' after you remove the log message.

You can therefore delete it.

And I'm politely asking you to.

Thank you.
