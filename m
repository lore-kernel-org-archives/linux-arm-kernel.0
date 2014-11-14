From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Nov 2014 15:59:51 +0100
Subject: [PATCH v2 13/14] ARM: STi: DT: STiH410: Add usb2 picophy dt nodes
In-Reply-To: <20141114133425.GA28680@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1415876417-28728-1-git-send-email-peter.griffin@linaro.org>
 <1546892.RCPeXgVQNJ@wuerfel>
 <20141114133425.GA28680@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <3480005.rnSDFdcTbG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 November 2014 13:34:25 Peter Griffin wrote:
> > 
> > > From looking around in the source I see a few different ways people have done this: -
> > > 
> > > 1) Some drivers encode the data statically into the source and make a decision based on compatible string.
> > > 2) Some drivers add a couple of extra dt properties to encode the offset (spifsm in stih416)
> > > 3) Some drivers mix address spaces in the reg properties (examples given above) 
> > > 3) Probably some other ways I've not found yet
> > >
> > > Is there a blessed way of doing this? It would be nice at least for all the drivers in STI to be doing
> > > it the same as currently there seems to be a mix of implementations.
> > 
> > You can do 1 or 2, not 3.
> 
> Yep got it.
> 
> One last question, what are the rules about updating ethernet and miphy365 over
> to using this method for there sysconfig registers? 

It depends on whether you have any machines that rely on this for backwards
compatibility. If the platform support is still work in progress and you
wouldn't be able to run a machine with an upstream kernel yet, just say
in the patch description that this breaks compatibility and why it is ok
in this particular case.

If you have existing users that rely on these properties, make the
driver code handle the existing dtb files but print a warning if you
encounter them. In the documentation, you should list the new method
as required then, but you can mention that the old method might be
accepted for backwards compatibility.

	Arnd
