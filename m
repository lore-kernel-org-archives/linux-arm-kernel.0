From: leo.yan@linaro.org (Leo Yan)
Date: Sat, 10 Jun 2017 10:34:31 +0800
Subject: [PATCH 00/17] coresight: next v4.12-rc4
In-Reply-To: <20170609175339.28d1d4d5a6c91a9e16c16bf7@arm.com>
References: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
 <20170609175339.28d1d4d5a6c91a9e16c16bf7@arm.com>
Message-ID: <20170610023231.GP17668@leoy-ThinkPad-T440>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kim,

On Fri, Jun 09, 2017 at 05:53:39PM -0500, Kim Phillips wrote:
> On Mon,  5 Jun 2017 14:15:01 -0600
> Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> 
> Hi Mathieu,
> 
> > Please consider for inclusion in the 4.13 cycle.  Of particular interest is
> > patch 15/17, which adds a new driver under the CoreSight umbrella.
> 
> After applying the patchseries, the devices now have self-named
> subdirectories under them:
> 
> $ find /sys/devices/ -name \*sink\*
> /sys/devices/platform/20140000.etf/20140000.etf/enable_sink
> /sys/devices/platform/20070000.etr/20070000.etr/enable_sink
> /sys/devices/platform/20030000.tpiu/20030000.tpiu/enable_sink
> /sys/devices/platform/20010000.etf/20010000.etf/enable_sink
> $ 
> 
> Which doesn't match the coresight.txt usage documentation...

I am worry if my patches do some bad thing, so I did a quick test with
mainline kernel on Hikey, if without this patch series I still can see
self-named subdirectories in '/sys/devices/platform/':

root at linaro-developer:~# find /sys/devices/ -name \*sink\*
/sys/devices/platform/amba/f6404000.etr/f6404000.etr/enable_sink
/sys/devices/platform/amba/f6402000.etf/f6402000.etf/enable_sink

But if search '/sys/bus/coresight/devices/', we can get below info:
root at linaro-developer:~# ls /sys/bus/coresight/devices/*/*sink* -l
-rw-r--r-- 1 root root 4096 Nov 18 08:04 /sys/bus/coresight/devices/f6402000.etf/enable_sink
-rw-r--r-- 1 root root 4096 Nov 18 08:07 /sys/bus/coresight/devices/f6404000.etr/enable_sink

I checked coresight.txt and it uses folder
'/sys/bus/coresight/devices/' as example but not '/sys/devices/'.

> Also, do the current juno platforms not have CPU debug modules?  I'd
> like to test the new driver.

Suzuki's Juno patch has been picked from ARM tree:
http://archive.armlinux.org.uk/lurker/message/20170519.042557.c8b56c20.en.html

Thanks,
Leo Yan
