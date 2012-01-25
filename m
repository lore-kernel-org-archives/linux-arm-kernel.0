From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 25 Jan 2012 10:23:01 +0200
Subject: [PATCH v4 - resend 10/13] ASoC: omap-abe-twl6040: Configure card
 according to platform data
In-Reply-To: <20120124130008.GC31839@opensource.wolfsonmicro.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
 <1327405950-6676-11-git-send-email-peter.ujfalusi@ti.com>
 <20120124130008.GC31839@opensource.wolfsonmicro.com>
Message-ID: <4F1FBBE5.5080804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2012 03:00 PM, Mark Brown wrote:
> On Tue, Jan 24, 2012 at 01:52:27PM +0200, Peter Ujfalusi wrote:
>> Disable the not connected pins on the board based on the
>> received platform data.
>> DO not register the jack function on boards, which does not have
>> means to detect it (jack is always connected).
> 
> This should no longer be needed with the auto not connected stuff.

The auto not connected checks if we have connected something in the card
domain to the codec's input/output/micbias widgets.
In the machine driver we start from fully wired configuration, and based
on the received platform data we mark certain connections not connected.
The audio nc feature would not work here. It will not mark anything nc
since the DAPM map is complete.

-- 
P?ter
