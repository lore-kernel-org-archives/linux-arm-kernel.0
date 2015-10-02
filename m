From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 02 Oct 2015 07:40:39 +0300
Subject: [RFC PATCH 01/20] coresight: etm3x: splitting 'etm_enable_hw()'
 operations
In-Reply-To: <CANLsYkyOvHT1caPMNP0J90c1h9PAUsod7C8+kJg83taw4Ls6HQ@mail.gmail.com>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
 <1442593594-10665-2-git-send-email-mathieu.poirier@linaro.org>
 <87r3lgjkjw.fsf@ashishki-desk.ger.corp.intel.com>
 <CANLsYkyOvHT1caPMNP0J90c1h9PAUsod7C8+kJg83taw4Ls6HQ@mail.gmail.com>
Message-ID: <87y4fl3mt4.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> On 30 September 2015 at 03:58, Alexander Shishkin
> <alexander.shishkin@linux.intel.com> wrote:
>> Most of these things can also be bypassed, as at least initially perf
>> events won't be using trigger/sequencer configurations, so we could
>> simply clear all these things out when a first perf event is created
>> (which would also disallow any sysfs poking around the etm/etb) and not
>> worry about them in the pmu callbacks.
>
> I don't want to restrain configuration options to what is available
> through Perf's cmd line.  The sysFS interface is there to complement
> what is currently not available.

In practice this means that part of your trace configuration will be
global and part -- per event, which can indeed work if you only have one
event at a time, but again, makes using perf infrastructure redundant
for this driver. For multiple events this doesn't make much sense.

Regards,
--
Alex
