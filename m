From: dcbw@redhat.com (Dan Williams)
Date: Sun, 20 Sep 2009 07:36:32 -0700
Subject: about ppp0 and Networkmanager
In-Reply-To: <48cbf6bf0909100232x3d736f1fhfa6b0882cfcfaa60@mail.gmail.com>
References: <48cbf6bf0909100232x3d736f1fhfa6b0882cfcfaa60@mail.gmail.com>
Message-ID: <1253457392.11702.25.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-09-10 at 17:32 +0800, tommy tommy wrote:
> hi,Dear Dan!
> 
> Now i met a problem with usb evdo card!
> 
> When i insmod usbserial with vendor id and product id,pppd connect OK
> with ttyUSB1 and can access internet with ppp0!
> 
> But I want to use Networkmanager with ppp,because ppp0 isn't a
> standard platform device ,it is kernel virtual net
> (/sys/device/virtual/net/ppp0),causes HAL can't know it is a real
> network,Networkmanager depend on HAL!
> 
> Serveral days ago i have fix marvell8686 driver kernel hotplug
> bug,does usbserial driver miss similiar issue ?

NM 0.7.1 and later probe modems dynamically to figure out their
capabilities.  But it doesn't probe devices driven by 'usbserial' since
they are not generally supposed to be 3G modems.

Your 3G modem USB ids should be added to 'option' (for Option, ZTE,
Huawei, Novatel, etc devices) or 'sierra' (for Sierra devices), because
those drivers enable the high-speed communication that 3G devices are
used for.

usbserial is not built for high-speed communication and thus your
transfer rates will be quite limited.  If you add your modems IDs to a
known mobile broadband driver (like 'option') it should get picked up by
NM.

Dan


> Thanks all!
> 
> Platform :ARM11
> Linux kernel version:2.6.24.2
> 
> Tommy at China
