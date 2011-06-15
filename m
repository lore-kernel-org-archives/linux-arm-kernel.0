From: peter.fordham@gmail.com (Peter Fordham)
Date: Tue, 14 Jun 2011 17:19:06 -0700
Subject: [MPCore Watchdog]: Convert from misc_dev to dynamic device node.
In-Reply-To: <20110614234858.GA15534@gallagher>
References: <BANLkTinaQpnVxwX5rB1jrabGX6ArvhhS7g@mail.gmail.com>
	<20110614234858.GA15534@gallagher>
Message-ID: <BANLkTik02nt4ttTTS-3u5R_ZH0W90FADJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Jun 14, 2011 at 04:29:26PM -0700, Peter Fordham wrote:
>> The current MPCore watchdog driver uses a misc_dev device node.
>> This patch changes it to use dynamically allocated device numbers.
>
> I'm not sure that this is the correct thing to do. ?All other watchdog devices
> use a miscdevice with a major:minor of 10:130, is there a specific reason
> that this node needs to be dynamic?

I was under the impressions that dynamic device nodes were the way of the
future. Is that not the case?

I'll add the relevant checks in other places as per your suggestions.

> I believe the sysfs classes are pretty much
> deprecated now in preference of a bus too.

Can you give me some more info here? I thought the sysfs stuff was the
new right way of doing stuff. The class stuff allows udev to automatically
create the right device node.

thanks,


-Pete
