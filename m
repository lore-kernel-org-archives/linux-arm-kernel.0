From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 30 Oct 2012 12:50:52 +0000 (UTC)
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <20121030123254.GD29095@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210200611150.9865@utopia.booyaka.com>
 <CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com>
 <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
 <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
 <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
 <20121025101212.GD21217@arwen.pp.htv.fi>
 <20121026201539.GD29548@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
 <20121029200032.GD30152@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com>
 <20121030123254.GD29095@arwen.pp.htv.fi>
Message-ID: <alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Oct 2012, Felipe Balbi wrote:

> the wmb() patch should help, but you said it doesn't, right ?

Correct.  Not sure why you think that would help; the problem is almost 
certainly PM-idle related, given that the problem goes away by reverting 
Jean's commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc "ARM: OMAP: convert 
I2C driver to PM QoS for MPU latency constraints".

The problem is consistent and easy to reproduce here.

> without seeing debugging information on the failing case, it'll be very
> difficult to sort this one out provided noone else seems to be able to
> reproduce it.

Aaro sees it also, so it's definitely not a local artifact.

It's not very surprising that the problem doesn't appear with the extra 
logging enabled, since the extra logging presumably keeps the system out 
of idle.  

Anyway, you are welcome to the userspace, bootloader, and X-loader here if 
you would like to try to reproduce it.  They've been sent to Jean and 
Kevin and Shubhrajyoti already.  Simply request it and I will send links.


- Paul
