From: jolsa@redhat.com (Jiri Olsa)
Date: Wed, 6 Dec 2017 14:36:07 +0100
Subject: [RFC PATCH 2/5] perf jevents: add support for arch recommended
 events
In-Reply-To: <1512490399-94107-3-git-send-email-john.garry@huawei.com>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
 <1512490399-94107-3-git-send-email-john.garry@huawei.com>
Message-ID: <20171206133607.GA12508@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 12:13:16AM +0800, John Garry wrote:
> For some architectures (like arm64), there are architecture-
> defined recommended events. Vendors may not be obliged to
> follow the recommendation and may implement their own pmu
> event for a specific event code.
> 
> This patch adds support for parsing events from arch-defined
> recommended JSONs, and then fixing up vendor events when
> they have implemented these events as recommended.

in the previous patch you added the vendor support, so
you have arch|vendor|platform key for the event list
and perf have the most current/local event list

why would you need to fix it? if there's new event list,
the table gets updated, perf is rebuilt.. I'm clearly
missing something ;-)

> In the vendor JSON, to specify that the event is supported
> according to the recommendation, only the event code is
> added to the JSON entry - no other event elements need be
> added, like below:
> [
>     {
>         "EventCode": "0x40",
>     },
> 
> ]
> 
> The pmu event parsing will check for "BriefDescription"
> field presence only for this.
> 
> If "BriefDescription" is present, then it is implied
> that the vendor has implemented their own custom event,
> and there is no fixup. Other fields are ignored.

if we are going this way, please use some new token,
this list is supposed to be human readable

thanks,
jirka
