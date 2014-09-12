From: marvin24@gmx.de (Marc Dietrich)
Date: Fri, 12 Sep 2014 09:51:31 +0200
Subject: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
In-Reply-To: <20140911145421.GE5149@katana>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <1591383.Xdy91rktuP@fb07-iapwap2> <20140911145421.GE5149@katana>
Message-ID: <9935938.eKOCvCAtLt@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 11. September 2014, 16:54:22 schrieb Wolfram Sang:
> On Thu, Sep 11, 2014 at 04:52:22PM +0200, Marc Dietrich wrote:
> > Am Donnerstag, 11. September 2014, 16:40:04 schrieb Wolfram Sang:
> > > > b) could be seen as a configuration thing since the functionality
> > > > backend could be changed at runtime even.
> > > 
> > > Come to think of it, not only the functionality, also the address can be
> > > changed at runtime. This makes me think it should really not be in DT
> > > after all.
> > 
> > even worse, there can be multiple masters and slaves changing their role
> > on
> > the fly AFAIK. So the best dt can do is to provide an initial
> > configuration, so all drivers know where they are and where to start.
> > Everything else can be changed during runtime.
> 
> Why do you want DT to be involved at all?

Imagine a device which supports both, slave or master mode. The driver needs 
to know in which mode it should operate. This cannot be hard coded, because on 
different boards, different modes can be used.

The point is, that if we define a dt binding for master device on slave 
adapters it will be there forever. So even if it makes no sense for the 
example eeprom simulator (or even our embedded controller), it may make sense 
for other or future devices.

On the other hand, we had some painful discussion about that issue in the 
past, so if no one else steps up to propose a good alternative binding, I will 
be the last to criticize your approach.

Marc
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140912/47dbeea6/attachment.sig>
