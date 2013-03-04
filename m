From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 04 Mar 2013 11:44:22 +0100
Subject: [PATCH v3 3/3] leds: leds-pwm: Defer led_pwm_set() if PWM can
 sleep
In-Reply-To: <512E2F98.6070404@epfl.ch>
References: <1359381659-24454-1-git-send-email-florian.vaussard@epfl.ch>
 <1359381659-24454-4-git-send-email-florian.vaussard@epfl.ch>
 <20130130081728.GC13568@avionic-0098.mockup.avionic-design.de>
 <512E2F98.6070404@epfl.ch>
Message-ID: <51347B06.8090604@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bryan, Richard,

> On 01/30/2013 09:17 AM, Thierry Reding wrote:
>> On Mon, Jan 28, 2013 at 03:00:59PM +0100, Florian Vaussard wrote:
>>> Call to led_pwm_set() can happen inside atomic context, like triggers.
>>> If the PWM call can sleep, defer using a worker.
>>>
>>> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>>> ---
>>>   drivers/leds/leds-pwm.c |   50
>>> +++++++++++++++++++++++++++++++++++++++-------
>>>   1 files changed, 42 insertions(+), 8 deletions(-)
>>
>> Bryan, I assume that you'll be taking this? It doesn't apply cleanly to
>> my tree, probably because of Peter's recent changes that you took
>> through your tree and Florian based his patches on top of that. The
>> conflict resolution should be trivial, though.
>>
>
> It seems that this patch was not taken. Could you pull it, as the other
> part is already in linux-pwm? Or is there any show stopper?
>

Ping? Who should merge this?

Many thanks!

Florian
