From: dcbw@redhat.com (Dan Williams)
Date: Thu, 10 Sep 2009 13:33:09 -0700
Subject: about HAL and USB EVDO usbserial problem
In-Reply-To: <14959928.480571252500507211.JavaMail.coremail@bj126app76.126.com>
References: <14959928.480571252500507211.JavaMail.coremail@bj126app76.126.com>
Message-ID: <1252614789.13201.42.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-09-09 at 20:48 +0800, tommy.hong wrote:
> hi,all!
> 
> Now i met a problem with usb evdo card!
> 
> When i insmod usbserial with vendor id and product id,pppd connect OK
> with ttyUSB1 and can access internet with ppp0!

You really, really want to add that card's IDs to the proper kernel
drivers.  Doing so will allow NetworkManager to see and manage the
interface.  *Plus* you'll get much higher speeds.  usbserial simply
isn't capable of nor designed for the higher speeds of 3G cards.

What card is it?  If I know that, I can suggest what driver to add the
IDs to.

> But I want to use Networkmanager with ppp,because ppp0 isn't a
> standard platform device ,it is kernel virtual net
> (/sys/device/virtual/net/ppp0),causes HAL can't know it is a real
> network,Networkmanager depend on HAL!
> 
> Serveral days ago i have fix marvell8686 driver kernel hotplug
> bug,does usbserial driver miss similiar issue ?

Marvell vendor driver, or the upstream libertas driver?  Upstream
drivers are the only ones we guarantee to really support since they have
been vetted by kernel developers and tested by numerous people.  I test
the libertas driver regularly and it works well with NM.  I don't know
anything about the state of the marvell vendor driver.

Dan
