From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 30 Sep 2011 09:58:04 +0200
Subject: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <4E854532.6080605@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-3-git-send-email-rnayak@ti.com>
	<20110927121003.GB4289@opensource.wolfsonmicro.com>
	<4E81E224.2070408@ti.com>
	<20110927150511.GM4289@opensource.wolfsonmicro.com>
	<4E854532.6080605@ti.com>
Message-ID: <4E85768C.6050601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/30/2011 6:27 AM, Nayak, Rajendra wrote:

[...]

>> They need both.  We need to reference the device that provides the
>> supply and use a name to say which of the potentially multiple supplies
>> on the consumer device is which.
>
> Mark, I still seem to be a little confused with this one as to why
> we would need a phandle *and* a supply-name to reference a parent
> regulator/supply.
> The phandle would point to a regulator dt node and that node internally
> would have just one name associated with it.

I think as well that we should avoid considering a regulator with 
several outputs. I saw the same pattern used for the clock binding in DT 
as well.

A clock node like a regulator node should output only one signal.
These nodes should provide atomic functionality. And if extra 
functionality are needed we might consider adding some intermediate nodes.
Except for a regulator that will output several lines at the same 
voltage to spread the current load, assuming it does exist, I'm not sure 
to understand the need.

Mark,
What usage do you have in mind for such supply node with several outputs?

Regards,
Benoit
