From: zonque@gmail.com (Daniel Mack)
Date: Fri, 08 Nov 2013 08:51:14 +0100
Subject: [PATCH v4] ARM: omap: edma: add suspend suspend/resume hooks
In-Reply-To: <527C636D.4040007@ti.com>
References: <1383164468-4610-1-git-send-email-zonque@gmail.com>
 <527BC118.1050609@ti.com> <527BCFD8.9010207@gmail.com>
 <527C636D.4040007@ti.com>
Message-ID: <527C97F2.2080702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2013 05:07 AM, Gururaja Hebbar wrote:
> On Thursday 07 November 2013 11:07 PM, Daniel Mack wrote:

>> I'm running long-time tests here on a device
>> which has a mwifiex connected to omap_hsmmc. The test procedure includes:
>>
>> a) a script on the device that puts the device to sleep some seconds
>> after it has been woken up
>> 
>> b) a script on a host that wakes up the device with wake-on-lan every 10
>> seconds
>>
>> c) a flood ping that checks whether the device is responding
> 
> can you share above 2 (b & C) test scripts? (pastebin or inline if small)

Of course. It's very hand-baked and simple:

a)

# wpa_supplicant is started and and the ip address ist set

while [ true ]; do
        ethtool -s eth0 wol g
        echo mem >/sys/power/state
        ethtool -s eth0 wol d
        sleep 7
done

b)

while [ true ]; do
	sudo etherwake -i em1 BC:6A:29:84:0A:62
	sleep 5
done

c)

ping -s 32768 -i 0.1 192.168.178.222



Daniel
