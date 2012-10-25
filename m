From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Oct 2012 15:21:14 +0200
Subject: [PATCH 2/2] arm: mvebu: adding SATA support: dt binding and
 config update
In-Reply-To: <20121025131818.GF18811@titan.lakedaemon.net>
References: <1351086561-13569-1-git-send-email-gregory.clement@free-electrons.com>
 <1351086561-13569-3-git-send-email-gregory.clement@free-electrons.com>
 <20121024160139.6dbf5e16@skate> <5087F5B9.0@free-electrons.com>
 <20121025131818.GF18811@titan.lakedaemon.net>
Message-ID: <20121025152114.73e69c92@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Thu, 25 Oct 2012 09:18:18 -0400, Jason Cooper wrote:

> > Jason, Andrew, do you want I split this patch as suggested by
> > Thomas or are you fine with having one single patch?
> 
> Yes, please make the defconfig changes a separate patch.  Also, please
> make sure only the minimum is enabled (eq RAID... isn't needed).

I haven't looked in details at the driver, but is nr-ports = <foo> the
right way of doing things? We may have platforms were port 0 is not
used, but port 1 is used, and just a number of ports doesn't allow to
express this.

Shouldn't the DT property be

  ports = <0>, <1>
  ports = <1>
  ports = <1>, <3>

In order to allow to more precisely enabled SATA ports? Or maybe the
SATA ports cannot be enabled/disabled on a per-port basis, in which
case I'm obviously wrong here.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
