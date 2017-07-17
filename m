From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 17 Jul 2017 14:21:42 -0700
Subject: [PATCH v2] PM / suspend: Add suspend_target_state()
In-Reply-To: <CAJZ5v0gJQHUMEXTbvb0q6rmW-1xuRWAwGMmo_CCE8mYj-xf5QA@mail.gmail.com>
References: <20170716023610.4658-1-f.fainelli@gmail.com>
 <20170717200628.7018-1-f.fainelli@gmail.com> <20170717201631.GA13024@amd>
 <CAJZ5v0gJQHUMEXTbvb0q6rmW-1xuRWAwGMmo_CCE8mYj-xf5QA@mail.gmail.com>
Message-ID: <2615c143-6cb2-1b89-d453-921306d665b6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2017 02:03 PM, Rafael J. Wysocki wrote:
> On Mon, Jul 17, 2017 at 10:16 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> Hi!
>>
>>> Have the core suspend/resume framework store the system-wide suspend
>>> state (suspend_state_t) we are about to enter, and expose it to drivers
>>> via suspend_target_state() in order to retrieve that. The state is
>>> assigned in suspend_devices_and_enter().
>>
>> Do we really want to have variable + inline functions that just read
>> that variable?
> 
> Florian, Pavel is right, you can simply export the variable.
> 
> Anything accessing it should go under CONFIG_PM_SLEEP anyway.

Alright then, I will just export it. Stay tuned.
-- 
Florian
