From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 21 Feb 2013 13:09:43 +0100
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
In-Reply-To: <20130221101603.GI23234@tbergstrom-lnx.Nvidia.com> (Peter De
 Schrijver's message of "Thu, 21 Feb 2013 12:16:03 +0200")
References: <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130215064429.GA30038@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1302191530190.32069@utopia.booyaka.com>
 <20130220191638.GA25609@arwen.pp.htv.fi>
 <20130221101603.GI23234@tbergstrom-lnx.Nvidia.com>
Message-ID: <87txp5hnqw.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Peter" == Peter De Schrijver <pdeschrijver@nvidia.com> writes:

 >> 
 >> Also, IMHO reset should always be done during probe() so driver can be
 >> dead sure that we're starting from a known state. This is even more

 Peter> Depends on the IP block. Eg: you might want to keep the screen
 Peter> showing the contents drawn by the bootloader while booting the
 Peter> kernel and smoothly change to a new image when userspace comes
 Peter> online. In that case you probably don't want to blindly reset
 Peter> the display controller for example.

Indeed. Another recent example was gpio pins (controlling stuff like
reset signals) where the bootloader had already set things up correctly
and the reset caused pins to toggle.

-- 
Bye, Peter Korsgaard
