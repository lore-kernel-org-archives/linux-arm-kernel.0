From: bgat@billgatliff.com (Bill Gatliff)
Date: Fri, 02 Oct 2009 10:31:59 -0500
Subject: Generic GPIO I2C bitbang kernel question
In-Reply-To: <3d1967ab0909301917g1acc4fd4ga49eb1906a8fccf5@mail.gmail.com>
References: <3d1967ab0909301917g1acc4fd4ga49eb1906a8fccf5@mail.gmail.com>
Message-ID: <4AC61CEF.2020003@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Brian Hutchinson wrote:
> Hi,
>
> I'm trying to get i2c-core gpio bitbang I2C adapter working on a picoChip
> PC205 (ARM926EJS core)
>
> I have soft i2c bit banging working in u-boot and am now trying to get it
> working in Linux.
>   

What is the response time of the slave?  I have at times had troubles
over-running my slave's address checking code, which would result in
false NAK reporting.  The quick fix was to slow down the i2c clock to
give the slave more time to respond.

Presumably, if your hardware is working in u-boot then your pullup
resistors and other hardware must be right.  But at higher speeds, is it
_really_ right?  If your pullup resistors have low resistance, the slave
might not be able to sink them fast enough for the master to see the ACK.

Just a couple of things that have bitten me in the bit-bang code.  But
when the above aren't issues, I have found the current implementation to
be solid.  I haven't checked the .31+ kernels, but I did thoroughly test
the .30 and previous ones.


HTH,


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
