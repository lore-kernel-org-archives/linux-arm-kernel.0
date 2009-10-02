From: bgat@billgatliff.com (Bill Gatliff)
Date: Fri, 02 Oct 2009 13:26:53 -0500
Subject: Generic GPIO I2C bitbang kernel question
In-Reply-To: <3d1967ab0910021119g5d81e8dar1056ef37ca8d4e35@mail.gmail.com>
References: <3d1967ab0909301917g1acc4fd4ga49eb1906a8fccf5@mail.gmail.com>	
	<4AC61CEF.2020003@billgatliff.com>
	<3d1967ab0910021119g5d81e8dar1056ef37ca8d4e35@mail.gmail.com>
Message-ID: <4AC645ED.3080904@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Brian Hutchinson wrote:
>
> Good talking to you again at ESC!

Likewise!  When are you going to give an actual presentation?  :)

> I've sense been able to get the i2c-core bit banging to work!  I wrote 
> a user land app to write to a eepot and it is working now.  The 
> problem was in fact the line I mentioned that was driving SDA high 
> when it should have been turned into a input to look for the ACK from 
> the slave.

Aaah.  With I2C, you never "drive" the line high--- that's what the 
pullups are for.

So if you want to output a zero, you drive the line low.  To output a 
one, you float the line.


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
