From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 29 Jan 2013 21:48:00 +0100
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that kirkwood_ge0[01]_init()
 finds its clock
In-Reply-To: <20130129203221.GG7717@titan.lakedaemon.net>
References: <510506F9.3070500@gmail.com> <20130127110857.GA23687@schnuecks.de>
 <51053761.1020009@gmail.com> <20130127144610.GW1758@titan.lakedaemon.net>
 <51053F81.6020904@gmail.com> <20130127152431.GX1758@titan.lakedaemon.net>
 <20130128223148.GA10275@schnuecks.de>
 <20130129004824.GB7717@titan.lakedaemon.net>
 <20130129194243.GA30831@schnuecks.de> <51082C4E.5050903@gmail.com>
 <20130129203221.GG7717@titan.lakedaemon.net>
Message-ID: <51083580.1010900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2013 09:32 PM, Jason Cooper wrote:
> On Tue, Jan 29, 2013 at 09:08:46PM +0100, Sebastian Hesselbarth wrote:
>> (Issue 1: gated runit clock hangs kernel due to serial access)
>
> This can be fixed with a patch removing clock-frequency from all
> kirkwood boards (dove, orion, etc?) I'll gin this up and add it to the
> havoc ;-)

For kirkwood.dtsi it is already there as you stated, but yes, it should
be removed from the board files including kirkwood.dtsi and also the
comments in kirkwood.dtsi. I'll prepare a patch for dove.dtsi.

>> (Issue 2: gated gbe clock hangs kernel due to smi access)
>
> Here, I'm going to wait for Florian's mvmdio changes to settle out and
> then readdress this.  My current understanding is that there will only
> be one DT node for this.  iiuc, each board dts will have to say which
> gate clocks to consume to prevent the mvmdio node in the dtsi from
> consuming both unconditionally.

Ok, feel free to consume the patch ;)

>> Leaves Issue 3, gbe forgets about its MAC address when gated or powered
>> down. That should be done with local-mac-address passed by DT enabled
>> u-boot or any other (dirty) ATAG hack ;)
>
> A patch to mv643xx_eth to pull this from DT should solve this.

Great.

Sebastian
