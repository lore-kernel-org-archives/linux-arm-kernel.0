From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 05 Aug 2016 10:48:19 +0200
Subject: [PATCH 3/8] ASoC: uda134x: Optionally initialize L3 ops to default
 GPIO ops
In-Reply-To: <20160804210323.GK10383@sirena.org.uk>
References: <1470317928-25365-1-git-send-email-s.nawrocki@samsung.com>
 <1470317928-25365-4-git-send-email-s.nawrocki@samsung.com>
 <20160804210323.GK10383@sirena.org.uk>
Message-ID: <e2dbe62b-8767-d0a5-a133-e927cfce98d4@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2016 11:03 PM, Mark Brown wrote:
> Does L3 actually support multiple devices?

>From the bus operation description in a few datasheets of the Philips'
UDA13XX codecs I have checked I would say it's possible to have multiple
devices working on same bus.  The slave devices are selectable by 6
most significant bits of the address byte and the device addresses
seem to be unique at first sight.

"In the event that the UDA1341TS receives a different address, it will
deselect its microcontroller interface logic." (ch. 7.19 [1])

However I can't answer yes for sure, I've never seen multiple device
operation mentioned explicitly in the datasheets nor such an hardware
configuration.

[1] http://www.nxp.com/documents/data_sheet/UDA1341TS.pdf
