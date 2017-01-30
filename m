From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 30 Jan 2017 14:46:40 -0800
Subject: [PATCH net-next v3 06/10] net: dsa: Migrate to device_find_class()
In-Reply-To: <20170125212500.GA6052@kroah.com>
References: <fc247aeb-a8d6-5ba9-c26d-cb057a5ac34d@gmail.com>
 <20170115173949.GA19268@kroah.com>
 <a9ea1f45-b9a5-d840-68e0-9bf9bc7a6598@gmail.com>
 <20170115191632.GD5643@lunn.ch>
 <912e6143-c67a-d909-2a6c-939de79efc5d@gmail.com>
 <20170119142820.GA494@kroah.com> <20170119145315.GD21805@lunn.ch>
 <20170119165155.GH27312@n2100.armlinux.org.uk>
 <841dc133-e9af-e7ca-75bf-8371337d6281@gmail.com>
 <c98f3ff8-9d4e-a007-1fef-130fcf580201@gmail.com>
 <20170125212500.GA6052@kroah.com>
Message-ID: <bc9e3b08-1722-5e24-5749-8860e10f1aa3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2017 01:25 PM, Greg KH wrote:
> On Tue, Jan 24, 2017 at 10:59:15AM -0800, Florian Fainelli wrote:
>> On 01/19/2017 10:12 AM, Florian Fainelli wrote:
>>>
>>> Back to the actual code that triggered this discussion, the whole
>>> purpose is just a safeguard. Given a device reference, we can assume
>>> that it is indeed the backing device for a net_device, and we could do a
>>> to_net_device() right away (and crash if someone did not write correct
>>> platform_data structures), or, by walking the device tree (the device
>>> driver model one) we can make sure it does belong in the proper class
>>> and this is indeed what we think it is.
>>
>> Greg, did Russell's explanation clarify things, or do you still think
>> this is completely bogus and we need to re design the whole thing?
>>
>> Just asking so I can try to resubmit just the preparatory parts or just
>> the whole thing.
> 
> Sorry, I haven't gotten back to this, it's lower on my list.  Should try
> to get to it tomorrow...

Greg, please give some feedback here, I can only produce new patches as
fast as I am given feedback, and I would really hate to miss the 4.11
merge window because we have been sleeping on this. If there is a need
to clarify things, I will be more than happy to try to provide information.

Thank you!
-- 
Florian
