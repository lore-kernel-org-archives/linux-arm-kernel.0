From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 10 Apr 2014 11:49:57 +0200
Subject: [RFC PATCH v2] edac: synopsys: Added EDAC support for zynq ddr
 ecc controller
In-Reply-To: <20140410092144.GD29093@pd.tnic>
References: <1220b715-6fc2-42ed-8393-b9859fc0deb9@TX2EHSMHS021.ehs.local>
 <20140408204047.GQ30077@pd.tnic> <534633C0.9090905@monstr.eu>
 <20140410092144.GD29093@pd.tnic>
Message-ID: <5e0042b6-f169-4025-8fd7-9d70c2ed0cf6@AM1EHSMHS012.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2014 11:21 AM, Borislav Petkov wrote:
> On Thu, Apr 10, 2014 at 08:01:36AM +0200, Michal Simek wrote:
>> Just add it to Zynq maintainer fragment as we are doing for non
>> zynq/xilinx drivers.
> 
> Yep, as a file pattern F:

yep.

>> At least the is the first time when someone saying that only some
>> functions should be documented.
> 
> I don't see the need to document simple functions which are *obvious*.
> But if you want to do that, I'm not going to stop you so be my guest.

ok. thanks.


>> I don't think this is good to do. When we remove this prefix entirely
>> it is bigger chance that the same function name will be used by
>> another driver. It is not a problem with linking but the same
>> functions names will be listed in System.map which will complicate
>> debugging.
> 
> Ok, fair enough. You probably still want to make them shorter, though,
> so that your code doesn't have to be line-broken too much. For example,
> since we only load a single edac driver per system, you can shorten the
> prefix to "edac_" only.

I agree with you that we can use shorter name.
I have checked this with Punnaiah and I can't see any problem to have
more edac drivers in the system.
For zynq there is primary ddr controller which is target by this driver.
Then we are talking about L2 in another thread.
Because zynq has programmable logic next to chip where you can add
soft memory controller (we have these hw designs) on the same bus
then there could be others edac drivers.
I would say how many you like till pins on the package.

Thanks,
Michal
