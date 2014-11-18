From: xudong.chen@mediatek.com (xudong chen)
Date: Tue, 18 Nov 2014 18:07:01 +0800
Subject: [PATCH v2 0/3] ARM: mediatek: Add driver for Mediatek I2C
 controller
In-Reply-To: <1415934752.2152.58.camel@mhfsdcap03>
References: <1415078977-18374-1-git-send-email-xudong.chen@mediatek.com>
 <20141113183122.GH1275@katana> <1415934752.2152.58.camel@mhfsdcap03>
Message-ID: <1416305221.4982.23.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-11-14 at 11:12 +0800, xudong chen wrote:
> On Thu, 2014-11-13 at 19:31 +0100, Wolfram Sang wrote:
> > > MTK I2C HW has some limitation.
> > > 1. If the i2c_msg number is more than one, STOP will be issued instead of
> > > RS(Repeat Start) between each message.
> > > 
> > > 2. Mediatek I2C controller support WRRD(write then read) mode, in WRRD
> > > mode the Repeat Start will be issued between 2 messages.
> > > In this driver if 2 messages is first write then read, the driver will
> > > combine 2 messages using Write-Read mode so the RS will be issued between
> > > the 2 messages.
> > > Ex: W/R/R, driver will combine first W/R and then R.
> > > 
> > > 3. Due to HW limitation, in this version the max transfer data length is 255
> > > in one message.
> > 
> > This looks to me more like an SMBUS controller instead of I2C. Maybe you
> > should populate smbus_xfer rather than master_xfer?
> 
> This is the HW limitation, we will try to workaround this in the
> separate patch.
> 
Except limited RS and limited length support, our HW follow I2C protocol
spec.
The length is compatible with most I2C devices, only a few I2C devices
need transfer more than 255 bytes.
The future Mediatek IC will fix the RS and length limitation.

Thanks!
> 
> 
