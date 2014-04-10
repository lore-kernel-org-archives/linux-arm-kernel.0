From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 10 Apr 2014 12:10:54 +0200
Subject: [RFC PATCH v2] edac: synopsys: Added EDAC support for zynq ddr
 ecc controller
In-Reply-To: <20140410100047.GG29093@pd.tnic>
References: <1220b715-6fc2-42ed-8393-b9859fc0deb9@TX2EHSMHS021.ehs.local>
 <20140408204047.GQ30077@pd.tnic> <534633C0.9090905@monstr.eu>
 <20140410092144.GD29093@pd.tnic>
 <5e0042b6-f169-4025-8fd7-9d70c2ed0cf6@AM1EHSMHS012.ehs.local>
 <20140410100047.GG29093@pd.tnic>
Message-ID: <98712034-021c-4b20-8f1a-1b848ef015c6@CH1EHSMHS043.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2014 12:00 PM, Borislav Petkov wrote:
> On Thu, Apr 10, 2014 at 11:49:57AM +0200, Michal Simek wrote:
>> I agree with you that we can use shorter name. I have checked this
>> with Punnaiah and I can't see any problem to have more edac drivers
>> in the system. For zynq there is primary ddr controller which is
>> target by this driver. Then we are talking about L2 in another thread.
>> Because zynq has programmable logic next to chip where you can add
>> soft memory controller (we have these hw designs) on the same bus then
>> there could be others edac drivers. I would say how many you like till
>> pins on the package.
> 
> I knew you were gonna say something like that! :-)

:-) good. We are getting famous by non standard cases.

> 
> Then you'll have to check whether edac can even stomach more than one
> drivers in parallel. TTBOMK, no one has ever done this so far... Yadda
> yadda.

It can there is just a problem with some IDs. :-)

> But before you do all that, you need to check whether edac is really
> what you're looking for, as I put it in my other mail.

If edac is the interface for reporting problems like this. It is probably
just a limitation of current edac core and should be fixed.

Thanks,
Michal
