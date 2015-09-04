From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Sep 2015 11:20:03 +0100
Subject: [PATCH v4 14/16] drm: bridge: analogix/dp: try force hpd after
 plug in lookup failed
In-Reply-To: <20150903090421.GC3784@ulmo.nvidia.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441088079-25809-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqJDALnjVaVoEqGGsSLeE31m3MKOfbSoZ3M+g+zPZR2MFg@mail.gmail.com>
 <55E7CC43.7040608@rock-chips.com>
 <20150903090421.GC3784@ulmo.nvidia.com>
Message-ID: <20150904102003.GE21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 03, 2015 at 11:04:40AM +0200, Thierry Reding wrote:
> Conversely, if the panel isn't capable of generating an HPD signal, then
> I don't think it would be appropriate to make it a DT property. It would
> be better to hard-code it in the driver, lest someone forget to set the
> property in DT and get stuck with a device that isn't operational.

There is another way to deal with this: DRM supports the idea of connector
forcing - where you can force the connector to think that it's connected
or disconnected.

One of the problems is that not many ARM DRM drivers implement it - maybe
it should be a requirement for code to be accepted? :)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
