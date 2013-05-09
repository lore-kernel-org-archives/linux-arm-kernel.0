From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 9 May 2013 15:36:45 +0200
Subject: [RFC 1/8] serial:st-asc: Add ST ASC driver.
In-Reply-To: <201305082035.57154.arnd@arndb.de>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081831.48566.arnd@arndb.de>
 <alpine.LFD.2.03.1305081239260.13109@syhkavp.arg>
 <201305082035.57154.arnd@arndb.de>
Message-ID: <20130509133645.GG3041@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20:35 Wed 08 May     , Arnd Bergmann wrote:
> On Wednesday 08 May 2013, Nicolas Pitre wrote:
> > I tried to fix this up over 10 years ago.  RMK tried as well. This 
> > failed because X86 people insisted on always having COM1 as /dev/ttyS0, 
> > COM3 as /dev/ttyS2 and so on, even when some of them weren't present.
> > 
> > A common and dynamic namespace eventually succeeded for hard disks.
> > Maybe people are ready to accept it for serial ports as well now?
> 
> Unfortunately it only worked for hard disks because the old name
> space was abandoned entirely. It also caused a lot of surprises
> for people upgrading their kernels, which is something we probably
> don't want to repeat.
> 
> Now we could add a new dynamic registration facility to the tty
> layer for drivers that don't already have a name and dev_t
> associated with the driver, and then use it for all new drivers
> as well as those that intentionally want to convert.

specially that we use devtmpfs and udev

we do not care much about minor/major
> 
> With DT aliases, we already have a way to enumerate serial ports
> across device drivers, so if we are going to do something new,
> we should make sure it works with the numbers defined there.
> 
> 	Arnd
